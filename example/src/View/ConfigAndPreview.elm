module View.ConfigAndPreview exposing (configAndPreview)

import Config
import Css exposing (..)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, aside, div, label, p, text)
import Html.Styled.Attributes exposing (css)
import UI.Header as Header


type alias ConfigSection model msg =
    { label : String
    , configs : List { label : String, config : Html (Config.Msg model msg), note : String }
    }


configAndPreview :
    (Config.Msg model msg -> msg)
    -> { theme : Theme }
    ->
        { title : String
        , preview : List (Html msg)
        , configSections : List (ConfigSection model msg)
        }
    -> Html msg
configAndPreview msg props { title, preview, configSections } =
    let
        title_ =
            if title == "" then
                text ""

            else
                Header.header props [] [ text title ]
    in
    Html.styled Html.div
        [ padding2 (em 2) zero
        , position relative
        , property "-webkit-tap-highlight-color" "transparent"
        , whiteSpace preWrap
        ]
        []
        [ title_
        , div
            [ css
                [ property "display" "grid"
                , property "grid-template-columns" "1fr 300px"
                , property "gap" "50px"
                ]
            ]
            [ div [ css [ width (pct 100) ] ] preview
            , configPanel msg configSections
            ]
        ]


configPanel : (Config.Msg model msg -> msg) -> List (ConfigSection model msg) -> Html msg
configPanel msg configSections =
    Html.map msg <|
        aside
            [ css
                [ paddingLeft (px 15)
                , borderLeft3 (px 1) solid (hex "#DDD")
                ]
            ]
            (List.map
                (\configSection ->
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
                            [ text configSection.label ]
                            :: List.map
                                (\field ->
                                    div [ css [ displayFlex, flexDirection column, property "gap" "5px" ] ]
                                        [ label [] [ text field.label ]
                                        , field.config
                                        , p [ css [ color (hex "#999") ] ] [ text field.note ]
                                        ]
                                )
                                configSection.configs
                        )
                )
                configSections
            )
