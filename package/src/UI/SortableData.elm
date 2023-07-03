module UI.SortableData exposing
    ( Model, Msg(..)
    , init, update, render, filter
    , stringColumn, intColumn, floatColumn
    , State(..), initialSort
    , Column
    , Sorter(..), Status(..), sort
    )

{-| This library helps you create sortable tables. The crucial feature is that it
lets you own your data separately and keep it in whatever format is best for
you. This way you are free to change your data without worrying about the table
&ldquo;getting out of sync&rdquo; with the data. Having a single source of
truth is pretty great!

I recommend checking out the [examples] to get a feel for how it works.

[examples]: https://github.com/evancz/elm-sortable-table/tree/master/examples

@docs Model, Msg
@docs init, update, render, filter


# Configuration

@docs stringColumn, intColumn, floatColumn


# State

@docs State, initialSort


## Custom Columns

@docs Column

-}

import Html.Styled exposing (Html)



-- INIT


type alias Model data view =
    { columns : List (Column data view)
    , state : State
    , filter : { key : String, query : String }
    , toId : data -> String
    }


init :
    (data -> String)
    -> List (Column data view)
    -> State
    -> Model data view
init toId columns state =
    { columns = columns
    , state = state
    , filter = { key = "", query = "" }
    , toId = toId
    }



-- UPDATE


type Msg
    = SetState State
    | Filter String String


update : Msg -> Model data view -> Model data view
update msg model =
    case msg of
        SetState state ->
            { model | state = state }

        Filter key query ->
            { model | filter = { key = key, query = query } }



-- VIEW MODEL


render : Model data (Html msg) -> List data -> List data
render ({ columns, state } as tableState) data =
    data
        |> filter tableState
        |> sort state columns


filter : Model data (Html msg) -> List data -> List data
filter m data =
    let
        filter_ =
            findColumn m.columns m.filter.key
                |> Maybe.map (\c -> c.filter m.filter.query)
                |> Maybe.withDefault (\_ -> True)

        findColumn columns key =
            List.head <| List.filter (\c -> c.name == key) columns
    in
    List.filter filter_ data



-- STATE


{-| Tracks which column to sort by.
-}
type State
    = State String Bool


{-| Create a table state. By providing a column name, you determine which
column should be used for sorting by default. So if you want your table of
yachts to be sorted by length by default, you might say:

    import Table

    Table.initialSort "Length"

-}
initialSort : String -> State
initialSort header =
    State header False


{-| The status of a particular column, for use in the `thead` field of your
`Customizations`.

  - If the column is unsortable, the status will always be `Unsortable`.
  - If the column can be sorted in one direction, the status will be `Sortable`.
    The associated boolean represents whether this column is selected. So it is
    `True` if the table is currently sorted by this column, and `False` otherwise.
  - If the column can be sorted in either direction, the status will be `Reversible`.
    The associated maybe tells you whether this column is selected. It is
    `Just isReversed` if the table is currently sorted by this column, and
    `Nothing` otherwise. The `isReversed` boolean lets you know which way it
    is sorted.

This information lets you do custom header decorations for each scenario.

-}
type Status
    = Unsortable
    | Sortable Bool
    | Reversible (Maybe Bool)



-- COLUMNS


{-| Describes how to turn `data` into a column in your table.
-}
type alias Column data view =
    { name : String
    , view : data -> view
    , sorter : Sorter data
    , filter : String -> data -> Bool
    }


{-| -}
stringColumn : { label : String, getter : data -> String, renderer : String -> view } -> Column data view
stringColumn { label, getter, renderer } =
    { name = label
    , view = getter >> renderer
    , sorter = increasingOrDecreasingBy getter
    , filter = \query data -> String.contains (String.toLower query) (String.toLower <| getter data)
    }


{-| -}
intColumn : { label : String, getter : data -> Int, renderer : String -> view } -> Column data view
intColumn { label, getter, renderer } =
    { name = label
    , view = getter >> String.fromInt >> renderer
    , sorter = increasingOrDecreasingBy getter
    , filter = \query data -> getter data |> String.fromInt |> String.startsWith query
    }


{-| -}
floatColumn : { label : String, getter : data -> Float, renderer : String -> view } -> Column data view
floatColumn { label, getter, renderer } =
    { name = label
    , view = getter >> String.fromFloat >> renderer
    , sorter = increasingOrDecreasingBy getter
    , filter = \query data -> getter data |> String.fromFloat |> String.startsWith query
    }



-- SORTING


sort : State -> List (Column data msg) -> List data -> List data
sort (State selectedColumn isReversed) columns data =
    case findSorter selectedColumn columns of
        Nothing ->
            data

        Just sorter ->
            applySorter isReversed sorter data


findSorter : String -> List (Column data msg) -> Maybe (Sorter data)
findSorter selectedColumn columns =
    case columns of
        [] ->
            Nothing

        { name, sorter } :: remainingColumns ->
            if name == selectedColumn then
                Just sorter

            else
                findSorter selectedColumn remainingColumns


applySorter : Bool -> Sorter data -> List data -> List data
applySorter isReversed sorter data =
    case sorter of
        None ->
            data

        Increasing sort_ ->
            sort_ data

        Decreasing sort_ ->
            List.reverse (sort_ data)

        IncOrDec sort_ ->
            if isReversed then
                List.reverse (sort_ data)

            else
                sort_ data

        DecOrInc sort_ ->
            if isReversed then
                sort_ data

            else
                List.reverse (sort_ data)



-- SORTERS


{-| Specifies a particular way of sorting data.
-}
type Sorter data
    = None
    | Increasing (List data -> List data)
    | Decreasing (List data -> List data)
    | IncOrDec (List data -> List data)
    | DecOrInc (List data -> List data)


{-| Sometimes you want to be able to sort data in increasing _or_ decreasing
order. Maybe you have race times for the 100 meter sprint. This function lets
sort by best time by default, but also see the other order.

    sorter : Sorter { a | time : comparable }
    sorter =
        increasingOrDecreasingBy .time

-}
increasingOrDecreasingBy : (data -> comparable) -> Sorter data
increasingOrDecreasingBy toComparable =
    IncOrDec (List.sortBy toComparable)
