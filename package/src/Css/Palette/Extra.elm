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

import Css exposing (Color, Style, backgroundColor, batch, borderColor, boxShadow, color, rgba, unset)
import Css.Media exposing (withMediaQuery)
import Css.Palette exposing (Palette, paletteWithBorder, setBackground, setBorder, setColor)
import Data.Theme exposing (Theme(..))


darkPalette : Theme -> Palette -> Style
darkPalette theme =
    darkPaletteWith theme borderColor


darkPaletteWith : Theme -> (Color -> Style) -> Palette -> Style
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


setIf : Bool -> (Color -> Palette -> Palette) -> Color -> Palette -> Palette
setIf bool setter c p =
    if bool then
        setter c p

    else
        p


setBackgroundIf : Bool -> Color -> Palette -> Palette
setBackgroundIf bool c p =
    setIf bool setBackground c p


setColorIf : Bool -> Color -> Palette -> Palette
setColorIf bool c p =
    setIf bool setColor c p


setBorderIf : Bool -> Color -> Palette -> Palette
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
