module Css.Palette exposing
    ( Palette, init
    , palette, paletteWith, darkPalette, darkPaletteWith
    , setBackground, setColor, setBorder
    , setBackgroundIf, setColorIf, setBorderIf
    , transparent_, textColor, hoverColor
    )

{-|

@docs Palette, init
@docs palette, paletteWith, darkPalette, darkPaletteWith
@docs setBackground, setColor, setBorder
@docs setBackgroundIf, setColorIf, setBorderIf

@docs transparent_, textColor, hoverColor

-}

import Css exposing (Color, Style, backgroundColor, batch, borderColor, color, rgba)
import Css.Media exposing (withMediaQuery)
import Data.Theme exposing (Theme(..))


type alias Palette =
    { background : Maybe Color
    , color : Maybe Color
    , border : Maybe Color
    }


init : Palette
init =
    { background = Nothing
    , color = Nothing
    , border = Nothing
    }


palette : Palette -> Style
palette =
    paletteWith { border = borderColor }


paletteWith : { border : Color -> Style } -> Palette -> Style
paletteWith option p =
    [ p.background
        |> Maybe.map backgroundColor
        |> Maybe.withDefault (batch [])
    , p.color
        |> Maybe.map color
        |> Maybe.withDefault (batch [])
    , p.border
        |> Maybe.map option.border
        |> Maybe.withDefault (batch [])
    ]
        |> batch


darkPalette : Theme -> Palette -> Style
darkPalette theme =
    darkPaletteWith theme { border = borderColor }


darkPaletteWith : Theme -> { border : Color -> Style } -> Palette -> Style
darkPaletteWith theme option p =
    case theme of
        Light ->
            batch []

        Dark ->
            paletteWith option p

        System ->
            withMediaQuery [ "(prefers-color-scheme: dark)" ]
                [ paletteWith option p ]


setBackground : Color -> Palette -> Palette
setBackground c p =
    { p | background = Just c }


setColor : Color -> Palette -> Palette
setColor c p =
    { p | color = Just c }


setBorder : Color -> Palette -> Palette
setBorder c p =
    { p | border = Just c }


setBackgroundIf : Bool -> Color -> Palette -> Palette
setBackgroundIf bool c p =
    setIf bool setBackground c p


setColorIf : Bool -> Color -> Palette -> Palette
setColorIf bool c p =
    setIf bool setColor c p


setBorderIf : Bool -> Color -> Palette -> Palette
setBorderIf bool c p =
    setIf bool setBorder c p


setIf : Bool -> (Color -> Palette -> Palette) -> Color -> Palette -> Palette
setIf bool setter c p =
    if bool then
        setter c p

    else
        p



-- COLOR


transparent_ : Color
transparent_ =
    Css.rgba 0 0 0 0


textColor : Color
textColor =
    rgba 0 0 0 0.6


hoverColor : Color
hoverColor =
    rgba 0 0 0 0.8
