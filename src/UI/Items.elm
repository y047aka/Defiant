module UI.Items exposing (itemsToList, itemsToTable)

import Html.Styled as Html exposing (Attribute, Html, br, div, li, strong, tbody, text, ul)
import UI.Segment exposing (segment)
import UI.Table exposing (table, td, th, thead, tr)



-- List


itemsToList :
    List (Attribute msg)
    -> { properties : List { label : String, getter : item -> Html msg } }
    -> List item
    -> Html msg
itemsToList attributes config items =
    ul attributes <|
        List.map (listItem [] config.properties) items


listItem :
    List (Attribute msg)
    -> List { label : String, getter : item -> Html msg }
    -> item
    -> Html msg
listItem attributes properties item =
    li attributes
        [ segment { inverted = False } [] <|
            List.map
                (\{ label, getter } ->
                    div []
                        [ strong [] [ text label ]
                        , br [] []
                        , getter item
                        ]
                )
                properties
        ]



-- Table


itemsToTable :
    List (Attribute msg)
    -> { properties : List { label : String, getter : item -> Html msg } }
    -> List item
    -> Html msg
itemsToTable attributes { properties } items =
    table attributes
        [ thead []
            [ tr [] <|
                List.map (\{ label } -> th [] [ text label ]) properties
            ]
        , tbody [] <|
            List.map (tableRow [] properties) items
        ]


tableRow :
    List (Attribute msg)
    -> List { label : String, getter : item -> Html msg }
    -> item
    -> Html msg
tableRow attributes properties item =
    tr attributes <|
        List.map (\{ getter } -> td [] [ getter item ]) properties
