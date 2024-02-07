module Playground exposing (playground)

import Css exposing (..)
import Css.Palette as Palette exposing (palette, setBackground, setBorder, setColor)
import Css.Palette.Extra exposing (darkPalette)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, div, p, text)
import Html.Styled.Attributes exposing (css)
import Props exposing (Props)
import Types exposing (FormState(..))
import UI.Layout.Box as Box exposing (box)
import UI.Layout.Sidebar exposing (withSidebar)
import UI.Layout.Stack as Stack exposing (stack)


type alias ConfigSection msg =
    { label : String
    , configs : List (Props msg)
    }


playground :
    { theme : Theme
    , inverted : Bool
    , preview : List (Html msg)
    , configSections : List (ConfigSection msg)
    }
    -> Html msg
playground { theme, inverted, preview, configSections } =
    let
        palette_ =
            Palette.init
                |> (\p ->
                        { p
                            | background = Just (hex "FFF")
                            , color = Just (hex "000")
                            , border = Just (hex "DDD")
                        }
                   )
    in
    box (Box.defaultProps |> Box.setPadding 0.5 |> Box.setPalette palette_)
        [ css [ borderRadius (px 20) ] ]
        [ withSidebar
            { side = "right"
            , sideWith = 25
            , contentMin = 50
            , space = 0
            , noStretch = False
            }
            []
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
            , palette (Palette.init |> setBackground (hex "#FFF"))
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
    box
        (Box.defaultProps
            |> Box.setPadding 0.5
            |> Box.setBorderWidth 0
            |> Box.setPalette (Palette.init |> setBackground (hex "EEE") |> setBorder (hex "#DDD"))
        )
        [ css [ borderRadius (px 15) ] ]
    <|
        [ stack (Stack.defaultProps |> Stack.setGap 0.5)
            []
            (List.map
                (\configSection ->
                    box
                        (Box.defaultProps
                            |> Box.setPadding 1
                            |> Box.setBorderWidth 0
                            |> Box.setPalette (Palette.init |> setBackground (hex "FFF"))
                        )
                        [ css [ borderRadius (px 10) ] ]
                        [ stack Stack.defaultProps
                            []
                            (div
                                [ css
                                    [ fontWeight bold
                                    , empty [ display none ]
                                    ]
                                ]
                                [ text configSection.label ]
                                :: List.map render configSection.configs
                            )
                        ]
                )
                configSections
            )
        ]


render : Props msg -> Html msg
render =
    Props.render
