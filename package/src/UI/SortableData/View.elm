module UI.SortableData.View exposing (list, table)

import Css exposing (color, hex)
import Html.Styled exposing (Attribute, Html, li, span, text, ul)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as Events
import Html.Styled.Keyed as Keyed
import Html.Styled.Lazy exposing (lazy2)
import Json.Decode as Json
import UI.SortableData as SortableData exposing (Column, Sorter(..), State(..), Status(..))
import UI.Table as Table exposing (td, th, thead, tr)


list : (data -> List (Html msg)) -> List data -> Html msg
list toListItem data =
    ul [] <| List.map (\d -> li [] (toListItem d)) data


table : SortableData.Model data (Html msg) -> (SortableData.Msg -> msg) -> List data -> Html msg
table { toId, columns, state } toMsg data =
    Table.table []
        [ thead []
            [ tr [] <|
                List.map (toHeaderInfo state (SortableData.SetState >> toMsg) >> simpleTheadHelp) columns
            ]
        , Keyed.node "tbody" [] <|
            List.map (tableRow toId columns) data
        ]


toHeaderInfo : State -> (State -> msg) -> Column data view -> ( String, Status, Attribute msg )
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


tableRow : (data -> String) -> List (Column data (Html msg)) -> data -> ( String, Html msg )
tableRow toId columns data =
    ( toId data
    , lazy2 tr [] <| List.map (\{ view } -> td [] [ view data ]) columns
    )
