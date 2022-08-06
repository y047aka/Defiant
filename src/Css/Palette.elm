module Css.Palette exposing
    ( Palette, init
    , palette, paletteWith, darkPalette, darkPaletteWith
    , setBackground, setColor, setBorder
    , setBackgroundIf, setColorIf, setBorderIf
    , red, orange, yellow, olive, green, teal, blue, violet, purple, pink, brown, grey, black
    , transparent_, textColor, hoverColor
    )

{-|

@docs Palette, init
@docs palette, paletteWith, darkPalette, darkPaletteWith
@docs setBackground, setColor, setBorder
@docs setBackgroundIf, setColorIf, setBorderIf

@docs red, orange, yellow, olive, green, teal, blue, violet, purple, pink, brown, grey, black
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



-- COLORED


type alias PalettesByState =
    { default : Palette
    , onHover : Palette
    , onFocus : Palette
    , onActive : Palette
    }


red : PalettesByState
red =
    let
        default =
            { init
                | background = Just (hex "#DB2828")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#DB2828")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#d01919")
    , onFocus = default |> setBackground (hex "#ca1010")
    , onActive = default |> setBackground (hex "#b21e1e")
    }


orange : PalettesByState
orange =
    let
        default =
            { init
                | background = Just (hex "#F2711C")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#F2711C")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#f26202")
    , onFocus = default |> setBackground (hex "#e55b00")
    , onActive = default |> setBackground (hex "#cf590c")
    }


yellow : PalettesByState
yellow =
    let
        default =
            { init
                | background = Just (hex "#FBBD08")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#FBBD08")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#eaae00")
    , onFocus = default |> setBackground (hex "#daa300")
    , onActive = default |> setBackground (hex "#cd9903")
    }


olive : PalettesByState
olive =
    let
        default =
            { init
                | background = Just (hex "#B5CC18")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#B5CC18")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#a7bd0d")
    , onFocus = default |> setBackground (hex "#a0b605")
    , onActive = default |> setBackground (hex "#8d9e13")
    }


green : PalettesByState
green =
    let
        default =
            { init
                | background = Just (hex "#21BA45")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#21BA45")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#16ab39")
    , onFocus = default |> setBackground (hex "#0ea432")
    , onActive = default |> setBackground (hex "#198f35")
    }


teal : PalettesByState
teal =
    let
        default =
            { init
                | background = Just (hex "#00B5AD")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#00B5AD")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#009c95")
    , onFocus = default |> setBackground (hex "#008c86")
    , onActive = default |> setBackground (hex "#00827c")
    }


blue : PalettesByState
blue =
    let
        default =
            { init
                | background = Just (hex "#2185D0")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#2185D0")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#1678c2")
    , onFocus = default |> setBackground (hex "#0d71bb")
    , onActive = default |> setBackground (hex "#1a69a4")
    }


violet : PalettesByState
violet =
    let
        default =
            { init
                | background = Just (hex "#6435C9")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#6435C9")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#5829bb")
    , onFocus = default |> setBackground (hex "#4f20b5")
    , onActive = default |> setBackground (hex "#502aa1")
    }


purple : PalettesByState
purple =
    let
        default =
            { init
                | background = Just (hex "#A333C8")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#A333C8")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#9627ba")
    , onFocus = default |> setBackground (hex "#8f1eb4")
    , onActive = default |> setBackground (hex "#82299f")
    }


pink : PalettesByState
pink =
    let
        default =
            { init
                | background = Just (hex "#E03997")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#E03997")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#e61a8d")
    , onFocus = default |> setBackground (hex "#e10f85")
    , onActive = default |> setBackground (hex "#c71f7e")
    }


brown : PalettesByState
brown =
    let
        default =
            { init
                | background = Just (hex "#A5673F")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#A5673F")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#975b33")
    , onFocus = default |> setBackground (hex "#90532b")
    , onActive = default |> setBackground (hex "#805031")
    }


grey : PalettesByState
grey =
    let
        default =
            { init
                | background = Just (hex "#767676")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#767676")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#838383")
    , onFocus = default |> setBackground (hex "#8a8a8a")
    , onActive = default |> setBackground (hex "#909090")
    }


black : PalettesByState
black =
    let
        default =
            { init
                | background = Just (hex "#1B1C1D")
                , color = Just (hex "#FFFFFF")
                , border = Just (hex "#1B1C1D")
            }
    in
    { default = default
    , onHover = default |> setBackground (hex "#27292a")
    , onFocus = default |> setBackground (hex "#2f3032")
    , onActive = default |> setBackground (hex "#343637")
    }



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
