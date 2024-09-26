module Data.PalettesByState exposing
    ( PalettesByState, palettesByState
    , red, orange, yellow, olive, green, teal, blue, violet, purple, pink, brown, grey, black
    , fromPresetColor
    )

{-|

@docs PalettesByState, palettesByState
@docs red, orange, yellow, olive, green, teal, blue, violet, purple, pink, brown, grey, black
@docs fromPresetColor

-}

import Css exposing (Color, Style, active, batch, focus, hex, hover)
import Css.Palette as Palette exposing (Palette, palette, setBackground, setBorder, setColor)
import Types_Outdated exposing (PresetColor(..))


type alias PalettesByState =
    { default : Palette Color
    , onHover : Palette Color
    , onFocus : Palette Color
    , onActive : Palette Color
    }


palettesByState : PalettesByState -> Style
palettesByState { default, onHover, onFocus, onActive } =
    batch
        [ palette default
        , hover [ palette onHover ]
        , focus [ palette onFocus ]
        , active [ palette onActive ]
        ]


red : PalettesByState
red =
    let
        default =
            Palette.init
                |> setBackground (hex "#DB2828")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#DB2828")
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
            Palette.init
                |> setBackground (hex "#F2711C")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#F2711C")
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
            Palette.init
                |> setBackground (hex "#FBBD08")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#FBBD08")
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
            Palette.init
                |> setBackground (hex "#B5CC18")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#B5CC18")
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
            Palette.init
                |> setBackground (hex "#21BA45")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#21BA45")
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
            Palette.init
                |> setBackground (hex "#00B5AD")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#00B5AD")
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
            Palette.init
                |> setBackground (hex "#2185D0")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#2185D0")
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
            Palette.init
                |> setBackground (hex "#6435C9")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#6435C9")
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
            Palette.init
                |> setBackground (hex "#A333C8")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#A333C8")
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
            Palette.init
                |> setBackground (hex "#E03997")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#E03997")
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
            Palette.init
                |> setBackground (hex "#A5673F")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#A5673F")
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
            Palette.init
                |> setBackground (hex "#767676")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#767676")
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
            Palette.init
                |> setBackground (hex "#1B1C1D")
                |> setColor (hex "#FFFFFF")
                |> setBorder (hex "#1B1C1D")
    in
    { default = default
    , onHover = default |> setBackground (hex "#27292a")
    , onFocus = default |> setBackground (hex "#2f3032")
    , onActive = default |> setBackground (hex "#343637")
    }


fromPresetColor : PresetColor -> PalettesByState
fromPresetColor color =
    case color of
        Red ->
            red

        Orange ->
            orange

        Yellow ->
            yellow

        Olive ->
            olive

        Green ->
            green

        Teal ->
            teal

        Blue ->
            blue

        Violet ->
            violet

        Purple ->
            purple

        Pink ->
            pink

        Brown ->
            brown

        Grey ->
            grey

        Black ->
            black
