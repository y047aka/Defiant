module View.ConfigAndPreview exposing (configAndPreview)

import Css exposing (borderLeft3, color, column, displayFlex, flexDirection, hex, paddingLeft, pct, property, px, solid, width)
import Html.Styled as Html exposing (Html, aside, div, label, p, text)
import Html.Styled.Attributes exposing (css)
import UI.Example exposing (example)


configAndPreview :
    { title : String }
    -> List (Html msg)
    -> List { label : String, description : String, content : Html msg }
    -> Html msg
configAndPreview { title } preview config =
    example { title = title, description = "" }
        [ div [ css [ displayFlex, property "gap" "50px" ] ]
            [ div [ css [ width (pct 70) ] ] preview
            , aside
                [ css
                    [ width (pct 30)
                    , displayFlex
                    , flexDirection column
                    , property "gap" "25px"
                    , paddingLeft (px 25)
                    , borderLeft3 (px 1) solid (hex "#EEE")
                    ]
                ]
                (List.map
                    (\item ->
                        div [ css [ displayFlex, flexDirection column, property "gap" "5px" ] ]
                            [ label [] [ text item.label ]
                            , item.content
                            , p [ css [ color (hex "#999") ] ] [ text item.description ]
                            ]
                    )
                    config
                )
            ]
        ]
