module UI.SortableData.View exposing (list, table)

import Css exposing (color, hex, property)
import Html.Styled exposing (Html, li, span, text, ul)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Html.Styled.Keyed as Keyed
import Html.Styled.Lazy exposing (lazy2)
import UI.SortableData exposing (Column, Direction(..), Model, Msg(..), Sorting, findSorting)
import UI.Table as Table exposing (td, th, thead, tr)


list : (data -> List (Html msg)) -> List data -> Html msg
list toListItem data =
    ul [] <| List.map (\d -> li [] (toListItem d)) data


table : Model data (Html msg) -> (Msg -> msg) -> List data -> Html msg
table { columns, sorting, toId } toMsg data =
    Table.table []
        [ thead [] [ tr [] (headerCells columns sorting toMsg) ]
        , Keyed.node "tbody" [] (tableRows toId columns data)
        ]


headerCells : List (Column data (Html msg)) -> List Sorting -> (Msg -> msg) -> List (Html msg)
headerCells columns sorting toMsg =
    let
        cell { name } =
            th
                [ css [ property "user-select" "none" ]
                , onClick <| toMsg <| Sort name
                ]
                [ text name
                , text " "
                , direction (findSorting name sorting)
                ]
    in
    List.map cell columns


direction : Direction -> Html msg
direction d =
    case d of
        Ascending ->
            darkGrey "↑"

        Descending ->
            darkGrey "↓"

        None ->
            lightGrey "↕"


darkGrey : String -> Html msg
darkGrey symbol =
    span [ css [ color (hex "#555") ] ] [ text symbol ]


lightGrey : String -> Html msg
lightGrey symbol =
    span [ css [ color (hex "#ccc") ] ] [ text symbol ]


tableRows : (data -> String) -> List (Column data (Html msg)) -> List data -> List ( String, Html msg )
tableRows toId columns data =
    let
        row d =
            ( toId d
            , lazy2 tr [] <| List.map (\{ view } -> td [] [ view d ]) columns
            )
    in
    List.map row data
