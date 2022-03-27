module UI.SortableData exposing
    ( list, table
    , stringColumn, intColumn, floatColumn
    , State, initialSort
    , Config
    )

{-| This library helps you create sortable tables. The crucial feature is that it
lets you own your data separately and keep it in whatever format is best for
you. This way you are free to change your data without worrying about the table
&ldquo;getting out of sync&rdquo; with the data. Having a single source of
truth is pretty great!

I recommend checking out the [examples] to get a feel for how it works.

[examples]: https://github.com/evancz/elm-sortable-table/tree/master/examples


# View

@docs list, table


# Configuration

@docs stringColumn, intColumn, floatColumn


# State

@docs State, initialSort


## Custom Columns

@docs Column

-}

import Css exposing (color, hex)
import Html.Styled as Html exposing (Attribute, Html, li, span, text, ul)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as Events
import Html.Styled.Keyed as Keyed
import Html.Styled.Lazy exposing (lazy2)
import Json.Decode as Json
import UI.Table as Table exposing (td, th, thead, tr)



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



-- CONFIG


{-| Configuration for your table, describing your columns.

**Note:** Your `Config` should _never_ be held in your model.
It should only appear in `view` code.

-}
type alias Config data msg =
    { toId : data -> String
    , toMsg : State -> msg
    , columns : List (Column data msg)
    }


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
type alias Column data msg =
    { name : String
    , view : data -> Html msg
    , sorter : Sorter data
    }


{-| -}
stringColumn : { label : String, getter : data -> String } -> Column data msg
stringColumn { label, getter } =
    { name = label
    , view = getter >> text
    , sorter = increasingOrDecreasingBy getter
    }


{-| -}
intColumn : { label : String, getter : data -> Int } -> Column data msg
intColumn { label, getter } =
    { name = label
    , view = getter >> String.fromInt >> text
    , sorter = increasingOrDecreasingBy getter
    }


{-| -}
floatColumn : { label : String, getter : data -> Float } -> Column data msg
floatColumn { label, getter } =
    { name = label
    , view = getter >> String.fromFloat >> text
    , sorter = increasingOrDecreasingBy getter
    }



-- VIEW


list : Config data msg -> State -> (data -> List (Html msg)) -> List data -> Html msg
list { columns } state toListItem data =
    let
        sortedData =
            sort state columns data

        listItem d =
            li [] (toListItem d)
    in
    ul [] <| List.map listItem sortedData


table : Config data msg -> State -> List data -> Html msg
table { toId, toMsg, columns } state data =
    let
        sortedData =
            sort state columns data
    in
    Table.table []
        [ thead []
            [ tr [] <|
                List.map (toHeaderInfo state toMsg >> simpleTheadHelp) columns
            ]
        , Keyed.node "tbody" [] <|
            List.map (tableRow toId columns) sortedData
        ]


toHeaderInfo : State -> (State -> msg) -> Column data msg -> ( String, Status, Attribute msg )
toHeaderInfo (State sortName isReversed) toMsg { name, sorter } =
    case sorter of
        None ->
            ( name, Unsortable, onClick sortName isReversed toMsg )

        Increasing _ ->
            ( name, Sortable (name == sortName), onClick name False toMsg )

        Decreasing _ ->
            ( name, Sortable (name == sortName), onClick name False toMsg )

        IncOrDec _ ->
            if name == sortName then
                ( name, Reversible (Just isReversed), onClick name (not isReversed) toMsg )

            else
                ( name, Reversible Nothing, onClick name False toMsg )

        DecOrInc _ ->
            if name == sortName then
                ( name, Reversible (Just isReversed), onClick name (not isReversed) toMsg )

            else
                ( name, Reversible Nothing, onClick name False toMsg )


onClick : String -> Bool -> (State -> msg) -> Attribute msg
onClick name isReversed toMsg =
    Events.on "click" <|
        Json.map toMsg <|
            Json.map2 State (Json.succeed name) (Json.succeed isReversed)


simpleTheadHelp : ( String, Status, Attribute msg ) -> Html msg
simpleTheadHelp ( name, status, onClick_ ) =
    let
        symbol =
            case status of
                Unsortable ->
                    []

                Sortable selected ->
                    [ if selected then
                        darkGrey "↓"

                      else
                        lightGrey "↓"
                    ]

                Reversible Nothing ->
                    [ lightGrey "↕" ]

                Reversible (Just isReversed) ->
                    [ if isReversed then
                        darkGrey "↑"

                      else
                        darkGrey "↓"
                    ]

        content =
            text (name ++ " ") :: symbol
    in
    th [ onClick_ ] content


darkGrey : String -> Html msg
darkGrey symbol =
    span [ css [ color (hex "#555") ] ] [ text symbol ]


lightGrey : String -> Html msg
lightGrey symbol =
    span [ css [ color (hex "#ccc") ] ] [ text symbol ]


tableRow : (data -> String) -> List (Column data msg) -> data -> ( String, Html msg )
tableRow toId columns data =
    ( toId data
    , lazy2 tr [] <| List.map (\{ view } -> td [] [ view data ]) columns
    )



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
