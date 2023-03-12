module View.Playground exposing (playground)

import Config
import Css exposing (..)
import Css.Palette as Palette exposing (darkPalette, palette, setBackground, setColor)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, aside, div, header, text)
import Html.Styled.Attributes exposing (css)
import UI.Header as Header


type alias ConfigSection msg =
    { label : String
    , configs : List (Html msg)
    }


playground :
    { title : String
    , toMsg : ({ a | inverted : Bool } -> { a | inverted : Bool }) -> msg
    , theme : Theme
    , inverted : Bool
    , preview : List (Html msg)
    , configSections : List (ConfigSection msg)
    }
    -> Html msg
playground { title, toMsg, theme, inverted, preview, configSections } =
    div []
        [ header
            [ css [ displayFlex, justifyContent spaceBetween ] ]
            [ Header.header { theme = theme } [] [ text title ]
            , div [ css [] ]
                [ Config.bool
                    { id = "inverted"
                    , label = "Inverted"
                    , bool = inverted
                    , onClick = (\c -> { c | inverted = not c.inverted }) |> toMsg
                    , note = ""
                    }
                ]
            ]
        , div
            [ css
                [ property "display" "grid"
                , property "grid-template-columns" "1fr 300px"
                , border3 (px 1) solid (hex "#DDD")
                , borderRadius (px 15)
                , overflow hidden
                ]
            ]
            [ previewPanel { inverted = inverted } preview
            , configPanel configSections
            ]
        ]


previewPanel : { inverted : Bool } -> List (Html msg) -> Html msg
previewPanel { inverted } previewSections =
    let
        theme =
            if inverted then
                Dark

            else
                Light
    in
    div
        [ css
            [ displayFlex
            , flexDirection column
            , justifyContent center
            , padding (em 2)
            , palette (Palette.init |> setBackground (hex "#FFFFFF"))
            , darkPalette theme
                (Palette.init
                    |> setBackground (hex "#1B1C1D")
                    |> setColor (rgba 255 255 255 0.9)
                )
            ]
        ]
        previewSections


configPanel : List (ConfigSection msg) -> Html msg
configPanel configSections =
    aside
        [ css
            [ padding (em 1)
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
                        , lastChild [ paddingBottom zero ]
                        ]
                    ]
                    (div
                        [ css
                            [ fontWeight bold
                            , empty [ display none ]
                            ]
                        ]
                        [ text configSection.label ]
                        :: configSection.configs
                    )
            )
            configSections
        )
