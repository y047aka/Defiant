module Css.Palette.Extra exposing
    ( darkPalette, darkPaletteWith
    , setBackgroundIf, setColorIf, setBorderIf
    , transparent, textColor, hoverColor
    )

{-|

@docs darkPalette, darkPaletteWith
@docs setBackgroundIf, setColorIf, setBorderIf

@docs transparent, textColor, hoverColor

-}

import Css exposing (Color, ColorValue, Style, backgroundColor, batch, borderColor, boxShadow, color, rgba, unset)
import Css.Media exposing (withMediaQuery)
import Css.Palette exposing (Palette, paletteWithBorder, setBackground, setBorder, setColor)
import Data.Theme exposing (Theme(..))


darkPalette : Theme -> Palette (ColorValue c) -> Style
darkPalette theme =
    darkPaletteWith theme borderColor


darkPaletteWith : Theme -> (ColorValue c -> Style) -> Palette (ColorValue c) -> Style
darkPaletteWith theme fn p =
    let
        unset_ =
            batch
                [ backgroundColor unset
                , color unset
                , borderColor unset
                , boxShadow unset
                ]
    in
    case theme of
        Light ->
            batch []

        Dark ->
            batch [ unset_, paletteWithBorder fn p ]

        System ->
            withMediaQuery [ "(prefers-color-scheme: dark)" ]
                [ unset_, paletteWithBorder fn p ]


setIf : Bool -> (color -> Palette color -> Palette color) -> color -> Palette color -> Palette color
setIf bool setter c p =
    if bool then
        setter c p

    else
        p


setBackgroundIf : Bool -> color -> Palette color -> Palette color
setBackgroundIf bool c p =
    setIf bool setBackground c p


setColorIf : Bool -> color -> Palette color -> Palette color
setColorIf bool c p =
    setIf bool setColor c p


setBorderIf : Bool -> color -> Palette color -> Palette color
setBorderIf bool c p =
    setIf bool setBorder c p



-- COLOR


transparent : Color
transparent =
    Css.transparent
        |> (\{ value, color } -> { value = value, color = color, red = 0, green = 0, blue = 0, alpha = 0 })


textColor : Color
textColor =
    rgba 0 0 0 0.6


hoverColor : Color
hoverColor =
    rgba 0 0 0 0.8
