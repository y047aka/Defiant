module View.ConfigAndPreview exposing (configAndPreview)

import Css exposing (..)
import Html.Styled as Html exposing (Html, aside, div, label, p, text)
import Html.Styled.Attributes exposing (css)
import UI.Example exposing (example)


type alias FieldSet msg =
    { label : String
    , fields : List { label : String, description : String, content : Html msg }
    }


configAndPreview :
    { title : String }
    -> List (Html msg)
    -> List (FieldSet msg)
    -> Html msg
configAndPreview { title } preview configs =
    example { title = title, description = "" }
        [ div
            [ css
                [ property "display" "grid"
                , property "grid-template-columns" "1fr 300px"
                , property "gap" "50px"
                ]
            ]
            [ div [ css [ width (pct 100) ] ] preview
            , configPanel configs
            ]
        ]


configPanel : List (FieldSet msg) -> Html msg
configPanel configs =
    aside
        [ css
            [ paddingLeft (px 15)
            , borderLeft3 (px 1) solid (hex "#DDD")
            ]
        ]
        (List.map
            (\fieldset ->
                div
                    [ css
                        [ displayFlex
                        , flexDirection column
                        , property "gap" "15px"
                        , paddingBottom (px 15)
                        , nthChild "n+2"
                            [ paddingTop (px 15)
                            , borderTop3 (px 1) solid (hex "#DDD")
                            ]
                        ]
                    ]
                    (div
                        [ css
                            [ fontWeight bold
                            , empty [ display none ]
                            ]
                        ]
                        [ text fieldset.label ]
                        :: List.map
                            (\field ->
                                div [ css [ displayFlex, flexDirection column, property "gap" "5px" ] ]
                                    [ label [] [ text field.label ]
                                    , field.content
                                    , p [ css [ color (hex "#999") ] ] [ text field.description ]
                                    ]
                            )
                            fieldset.fields
                    )
            )
            configs
        )
