module Playground exposing (playground)

import Control exposing (Control)
import Css exposing (..)
import Css.Extra exposing (columnGap, grid, rowGap)
import Css.Global exposing (children, everything)
import Css.Palette exposing (palette, paletteWithBorder)
import DesignToken.Palette as Palette
import Html.Styled as Html exposing (Html, div, section)
import Html.Styled.Attributes exposing (css)


playground :
    { isDarkMode : Bool
    , preview : Html msg
    , props : List (Control msg)
    }
    -> Html msg
playground { isDarkMode, preview, props } =
    section
        [ css
            [ padding4 (Css.em 0.5) (Css.em 0.5) (Css.em 0.5) (Css.em 1.5)
            , borderRadius (Css.em 1.5)
            , display grid
            , property "grid-template-columns" "1fr 25em"
            , columnGap (Css.em 1.5)
            , fontSize (px 14)
            , paletteWithBorder (border3 (px 1) solid) (Palette.playground isDarkMode)
            , property "-webkit-backdrop-filter" "blur(300px)"
            , property "backdrop-filter" "blur(300px)"
            , property "box-shadow" "0 5px 20px hsl(0, 0%, 0%, 0.05)"
            ]
        ]
        [ div [ css [ displayFlex, flexDirection column, justifyContent center ] ]
            [ preview ]
        , div
            [ css
                [ alignSelf start
                , padding (Css.em 0.5)
                , displayFlex
                , flexDirection column
                , rowGap (Css.em 0.5)
                , borderRadius (Css.em 1)
                , palette (Palette.propsPanel isDarkMode)
                , children
                    [ everything
                        [ padding (Css.em 0.75)
                        , borderRadius (Css.em 0.5)
                        , palette (Palette.propsField isDarkMode)
                        ]
                    ]
                ]
            ]
            (List.map Control.render props)
        ]
