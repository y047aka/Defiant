module UI.SortableData exposing
    ( Model, Msg(..)
    , init, update, render
    , stringColumn, intColumn, floatColumn
    , Column
    , Direction(..), Sorting, findSorting
    )

{-| This library helps you create sortable tables. The crucial feature is that it
lets you own your data separately and keep it in whatever format is best for
you. This way you are free to change your data without worrying about the table
&ldquo;getting out of sync&rdquo; with the data. Having a single source of
truth is pretty great!

I recommend checking out the [examples] to get a feel for how it works.

[examples]: https://github.com/evancz/elm-sortable-table/tree/master/examples

@docs Model, Msg
@docs init, update, render


# Configuration

@docs stringColumn, intColumn, floatColumn


## Custom Columns

@docs Column

-}

import Html.Styled exposing (Html)
import List.Extra



-- INIT


type alias Model data view =
    { columns : List (Column data view)
    , sorting : List Sorting
    , filter : { key : String, query : String }
    , toId : data -> String
    }


type alias Sorting =
    ( String, Direction )


type Direction
    = Ascending
    | Descending
    | None


init :
    (data -> String)
    -> List (Column data view)
    -> Model data view
init toId columns =
    { columns = columns
    , sorting = []
    , filter = { key = "", query = "" }
    , toId = toId
    }



-- UPDATE


type Msg
    = Sort String
    | Filter String String


update : Msg -> Model data view -> Model data view
update msg model =
    case msg of
        Sort key ->
            let
                newDirection =
                    findSorting key model.sorting |> stepDirection

                sorting =
                    case newDirection of
                        None ->
                            List.filter (\s -> Tuple.first s /= key) model.sorting

                        _ ->
                            let
                                newSorting =
                                    List.filter (\s -> Tuple.first s /= key) model.sorting
                            in
                            List.append newSorting [ ( key, newDirection ) ]
            in
            { model | sorting = sorting }

        Filter key query ->
            { model | filter = { key = key, query = query } }


stepDirection : Direction -> Direction
stepDirection direction =
    case direction of
        Ascending ->
            Descending

        Descending ->
            None

        None ->
            Ascending


findSorting : String -> List Sorting -> Direction
findSorting key sorting =
    List.Extra.find (\( key_, _ ) -> key_ == key) sorting
        |> Maybe.map (\( _, direction ) -> direction)
        |> Maybe.withDefault None



-- VIEW MODEL


render : Model data (Html msg) -> List data -> List data
render model data =
    data
        |> filter model
        |> sort model



-- COLUMNS


{-| Describes how to turn `data` into a column in your table.
-}
type alias Column data view =
    { name : String
    , view : data -> view
    , sort : data -> String
    , filter : String -> data -> Bool
    }


{-| -}
stringColumn : { label : String, getter : data -> String, renderer : String -> view } -> Column data view
stringColumn { label, getter, renderer } =
    { name = label
    , view = getter >> renderer
    , sort = getter
    , filter = \query data -> String.contains (String.toLower query) (String.toLower <| getter data)
    }


{-| -}
intColumn : { label : String, getter : data -> Int, renderer : String -> view } -> Column data view
intColumn { label, getter, renderer } =
    { name = label
    , view = getter >> String.fromInt >> renderer
    , sort = getter >> String.fromInt
    , filter = \query data -> getter data |> String.fromInt |> String.startsWith query
    }


{-| -}
floatColumn : { label : String, getter : data -> Float, renderer : String -> view } -> Column data view
floatColumn { label, getter, renderer } =
    { name = label
    , view = getter >> String.fromFloat >> renderer
    , sort = getter >> String.fromFloat
    , filter = \query data -> getter data |> String.fromFloat |> String.startsWith query
    }



-- FILTER


filter : Model data (Html msg) -> List data -> List data
filter m data =
    let
        filter_ =
            findColumn m.filter.key m.columns
                |> Maybe.map (\c -> c.filter m.filter.query)
                |> Maybe.withDefault (\_ -> True)
    in
    List.filter filter_ data


findColumn : String -> List (Column data view) -> Maybe (Column data view)
findColumn key columns =
    List.head <| List.filter (\c -> c.name == key) columns



-- SORTING


sort : Model data view -> List data -> List data
sort m prevData =
    List.foldl
        (\( key, direction ) data ->
            findSorter key m.columns
                |> Maybe.map (\sorter -> applySorter direction sorter data)
                |> Maybe.withDefault data
        )
        prevData
        m.sorting


findSorter : String -> List (Column data view) -> Maybe (data -> String)
findSorter key columns =
    columns
        |> List.Extra.find (\c -> c.name == key)
        |> Maybe.map .sort


applySorter : Direction -> (data -> comparable) -> List data -> List data
applySorter direction sorter data =
    case direction of
        Descending ->
            List.sortBy sorter data
                |> List.reverse

        _ ->
            List.sortBy sorter data
