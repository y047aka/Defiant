module Css.Palette exposing
    ( Palette, init
    , palette, paletteWith, darkPalette, darkPaletteWith
    , setBackground, setColor, setBorder
    , setBackgroundIf, setColorIf, setBorderIf
    , red, redOnHover, redOnFocus, redOnActive
    , orange, orangeOnHover, orangeOnFocus, orangeOnActive
    , yellow, yellowOnHover, yellowOnFocus, yellowOnActive
    , olive, oliveOnHover, oliveOnFocus, oliveOnActive
    , green, greenOnHover, greenOnFocus, greenOnActive
    , teal, tealOnHover, tealOnFocus, tealOnActive
    , blue, blueOnHover, blueOnFocus, blueOnActive
    , violet, violetOnHover, violetOnFocus, violetOnActive
    , purple, purpleOnHover, purpleOnFocus, purpleOnActive
    , pink, pinkOnHover, pinkOnFocus, pinkOnActive
    , brown, brownOnHover, brownOnFocus, brownOnActive
    , grey, greyOnHover, greyOnFocus, greyOnActive
    , black, blackOnHover, blackOnFocus, blackOnActive
    , transparent_, textColor, hoverColor
    )

{-|

@docs Palette, init
@docs palette, paletteWith, darkPalette, darkPaletteWith
@docs setBackground, setColor, setBorder
@docs setBackgroundIf, setColorIf, setBorderIf

@docs red, redOnHover, redOnFocus, redOnActive
@docs orange, orangeOnHover, orangeOnFocus, orangeOnActive
@docs yellow, yellowOnHover, yellowOnFocus, yellowOnActive
@docs olive, oliveOnHover, oliveOnFocus, oliveOnActive
@docs green, greenOnHover, greenOnFocus, greenOnActive
@docs teal, tealOnHover, tealOnFocus, tealOnActive
@docs blue, blueOnHover, blueOnFocus, blueOnActive
@docs violet, violetOnHover, violetOnFocus, violetOnActive
@docs purple, purpleOnHover, purpleOnFocus, purpleOnActive
@docs pink, pinkOnHover, pinkOnFocus, pinkOnActive
@docs brown, brownOnHover, brownOnFocus, brownOnActive
@docs grey, greyOnHover, greyOnFocus, greyOnActive
@docs black, blackOnHover, blackOnFocus, blackOnActive
@docs transparent_, textColor, hoverColor

-}

import Css exposing (Color, Style, backgroundColor, batch, borderColor, color, hex, rgba)
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
darkPalette =
    darkPaletteWith { border = borderColor }


darkPaletteWith : { border : Color -> Style } -> Theme -> Palette -> Style
darkPaletteWith option theme p =
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



-- COLORED


colored : Palette
colored =
    { init | color = Just (hex "#FFFFFF") }


red : Palette
red =
    { colored
        | background = Just (hex "#DB2828")
        , border = Just (hex "#DB2828")
    }


redOnHover : Palette
redOnHover =
    { red | background = Just (hex "#d01919") }


redOnFocus : Palette
redOnFocus =
    { red | background = Just (hex "#ca1010") }


redOnActive : Palette
redOnActive =
    { red | background = Just (hex "#b21e1e") }


orange : Palette
orange =
    { colored
        | background = Just (hex "#F2711C")
        , border = Just (hex "#F2711C")
    }


orangeOnHover : Palette
orangeOnHover =
    { orange | background = Just (hex "#f26202") }


orangeOnFocus : Palette
orangeOnFocus =
    { orange | background = Just (hex "#e55b00") }


orangeOnActive : Palette
orangeOnActive =
    { orange | background = Just (hex "#cf590c") }


yellow : Palette
yellow =
    { colored
        | background = Just (hex "#FBBD08")
        , border = Just (hex "#FBBD08")
    }


yellowOnHover : Palette
yellowOnHover =
    { yellow | background = Just (hex "#eaae00") }


yellowOnFocus : Palette
yellowOnFocus =
    { yellow | background = Just (hex "#daa300") }


yellowOnActive : Palette
yellowOnActive =
    { yellow | background = Just (hex "#cd9903") }


olive : Palette
olive =
    { colored
        | background = Just (hex "#B5CC18")
        , border = Just (hex "#B5CC18")
    }


oliveOnHover : Palette
oliveOnHover =
    { olive | background = Just (hex "#a7bd0d") }


oliveOnFocus : Palette
oliveOnFocus =
    { olive | background = Just (hex "#a0b605") }


oliveOnActive : Palette
oliveOnActive =
    { olive | background = Just (hex "#8d9e13") }


green : Palette
green =
    { colored
        | background = Just (hex "#21BA45")
        , border = Just (hex "#21BA45")
    }


greenOnHover : Palette
greenOnHover =
    { green | background = Just (hex "#16ab39") }


greenOnFocus : Palette
greenOnFocus =
    { green | background = Just (hex "#0ea432") }


greenOnActive : Palette
greenOnActive =
    { green | background = Just (hex "#198f35") }


teal : Palette
teal =
    { colored
        | background = Just (hex "#00B5AD")
        , border = Just (hex "#00B5AD")
    }


tealOnHover : Palette
tealOnHover =
    { teal | background = Just (hex "#009c95") }


tealOnFocus : Palette
tealOnFocus =
    { teal | background = Just (hex "#008c86") }


tealOnActive : Palette
tealOnActive =
    { teal | background = Just (hex "#00827c") }


blue : Palette
blue =
    { colored
        | background = Just (hex "#2185D0")
        , border = Just (hex "#2185D0")
    }


blueOnHover : Palette
blueOnHover =
    { blue | background = Just (hex "#1678c2") }


blueOnFocus : Palette
blueOnFocus =
    { blue | background = Just (hex "#0d71bb") }


blueOnActive : Palette
blueOnActive =
    { blue | background = Just (hex "#1a69a4") }


violet : Palette
violet =
    { colored
        | background = Just (hex "#6435C9")
        , border = Just (hex "#6435C9")
    }


violetOnHover : Palette
violetOnHover =
    { violet | background = Just (hex "#5829bb") }


violetOnFocus : Palette
violetOnFocus =
    { violet | background = Just (hex "#4f20b5") }


violetOnActive : Palette
violetOnActive =
    { violet | background = Just (hex "#502aa1") }


purple : Palette
purple =
    { colored
        | background = Just (hex "#A333C8")
        , border = Just (hex "#A333C8")
    }


purpleOnHover : Palette
purpleOnHover =
    { purple | background = Just (hex "#9627ba") }


purpleOnFocus : Palette
purpleOnFocus =
    { purple | background = Just (hex "#8f1eb4") }


purpleOnActive : Palette
purpleOnActive =
    { purple | background = Just (hex "#82299f") }


pink : Palette
pink =
    { colored
        | background = Just (hex "#E03997")
        , border = Just (hex "#E03997")
    }


pinkOnHover : Palette
pinkOnHover =
    { pink | background = Just (hex "#e61a8d") }


pinkOnFocus : Palette
pinkOnFocus =
    { pink | background = Just (hex "#e10f85") }


pinkOnActive : Palette
pinkOnActive =
    { pink | background = Just (hex "#c71f7e") }


brown : Palette
brown =
    { colored
        | background = Just (hex "#A5673F")
        , border = Just (hex "#A5673F")
    }


brownOnHover : Palette
brownOnHover =
    { brown | background = Just (hex "#975b33") }


brownOnFocus : Palette
brownOnFocus =
    { brown | background = Just (hex "#90532b") }


brownOnActive : Palette
brownOnActive =
    { brown | background = Just (hex "#805031") }


grey : Palette
grey =
    { colored
        | background = Just (hex "#767676")
        , border = Just (hex "#767676")
    }


greyOnHover : Palette
greyOnHover =
    { grey | background = Just (hex "#838383") }


greyOnFocus : Palette
greyOnFocus =
    { grey | background = Just (hex "#8a8a8a") }


greyOnActive : Palette
greyOnActive =
    { grey | background = Just (hex "#909090") }


black : Palette
black =
    { colored
        | background = Just (hex "#1B1C1D")
        , border = Just (hex "#1B1C1D")
    }


blackOnHover : Palette
blackOnHover =
    { black | background = Just (hex "#27292a") }


blackOnFocus : Palette
blackOnFocus =
    { black | background = Just (hex "#2f3032") }


blackOnActive : Palette
blackOnActive =
    { black | background = Just (hex "#343637") }



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
