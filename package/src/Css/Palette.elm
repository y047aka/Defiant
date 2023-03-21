module Css.Palette exposing
    ( Palette, init
    , palette, paletteWith, darkPalette, darkPaletteWith
    , setBackground, setColor, setBorder, setShadow
    , setBackgroundIf, setColorIf, setBorderIf, setShadowIf
    , transparent, textColor, hoverColor
    )

{-|

@docs Palette, init
@docs palette, paletteWith, darkPalette, darkPaletteWith
@docs setBackground, setColor, setBorder, setShadow
@docs setBackgroundIf, setColorIf, setBorderIf, setShadowIf

@docs transparent, textColor, hoverColor

-}

import Css exposing (Color, Style, backgroundColor, batch, borderColor, boxShadow, color, rgba, unset)
import Css.Media exposing (withMediaQuery)
import Data.Theme exposing (Theme(..))


type alias Palette =
    { background : Maybe Color
    , color : Maybe Color
    , border : Maybe Color
    , shadow : Maybe Style
    }


init : Palette
init =
    { background = Nothing
    , color = Nothing
    , border = Nothing
    , shadow = Nothing
    }


palette : Palette -> Style
palette =
    paletteWith { border = borderColor }


paletteWith : { border : Color -> Style } -> Palette -> Style
paletteWith options p =
    [ p.background
        |> Maybe.map backgroundColor
        |> Maybe.withDefault (batch [])
    , p.color
        |> Maybe.map color
        |> Maybe.withDefault (batch [])
    , p.border
        |> Maybe.map options.border
        |> Maybe.withDefault (batch [])
    , p.shadow
        |> Maybe.withDefault (batch [])
    ]
        |> batch


darkPalette : Theme -> Palette -> Style
darkPalette theme =
    darkPaletteWith theme { border = borderColor }


darkPaletteWith : Theme -> { border : Color -> Style } -> Palette -> Style
darkPaletteWith theme options p =
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
            batch [ unset_, paletteWith options p ]

        System ->
            withMediaQuery [ "(prefers-color-scheme: dark)" ]
                [ unset_, paletteWith options p ]


setBackground : Color -> Palette -> Palette
setBackground c p =
    { p | background = Just c }


setColor : Color -> Palette -> Palette
setColor c p =
    { p | color = Just c }


setBorder : Color -> Palette -> Palette
setBorder c p =
    { p | border = Just c }


setShadow : Style -> Palette -> Palette
setShadow shadow p =
    { p | shadow = Just shadow }


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


setShadowIf : Bool -> Style -> Palette -> Palette
setShadowIf bool shadow p =
    if bool then
        setShadow shadow p

    else
        p



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
