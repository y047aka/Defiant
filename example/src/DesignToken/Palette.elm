module DesignToken.Palette exposing
    ( light, dark
    , textOptional
    , navigation, navItem
    , playground, controlSection, formField
    )

{-|

@docs light, dark
@docs textOptional

@docs navigation, navItem
@docs playground, controlSection, formField

-}

import Css exposing (Color, rgba)
import Css.Color exposing (Hsl360)
import Css.Palette exposing (Palette, init, setBackground, setColor)
import Css.Palette.Extra exposing (PalettesByState, initPalettes, light_dark)
import DesignToken.Color exposing (black, grey020, grey030, grey060, grey085, grey090, grey095, white)


light : Palette Hsl360
light =
    { background = Just white
    , color = Just grey030
    , border = Just grey090
    }


dark : Palette Hsl360
dark =
    { background = Just black
    , color = Just grey095
    , border = Just white
    }


textOptional : Palette Hsl360
textOptional =
    { background = Nothing
    , color = Just grey060
    , border = Nothing
    }



-- NAVIGATION


navigation : Bool -> Palette Hsl360
navigation isDarkMode =
    light_dark isDarkMode
        { light =
            { background = light.background
            , color = Just grey030
            , border = Nothing
            }
        , dark =
            { background = dark.background
            , color = Just grey095
            , border = Nothing
            }
        }


navItem : { isDarkMode : Bool, isSelected : Bool } -> PalettesByState Hsl360
navItem { isDarkMode, isSelected } =
    light_dark isDarkMode
        { light =
            let
                default =
                    init |> setColor grey030
            in
            { initPalettes
                | default =
                    if isSelected then
                        default |> setBackground grey090

                    else
                        default
                , hover = Just (init |> setBackground grey085 |> setColor grey030)
            }
        , dark =
            let
                default =
                    init |> setColor white
            in
            { initPalettes
                | default =
                    if isSelected then
                        default |> setBackground grey020

                    else
                        default
                , hover = Just (init |> setBackground grey030 |> setColor white)
            }
        }



-- PLAYGROUND


playground : Bool -> Palette Hsl360
playground isDarkMode =
    light_dark isDarkMode
        { light = { light | background = Just grey095 }
        , dark = dark
        }


controlSection : Bool -> Palette Hsl360
controlSection isDarkMode =
    light_dark isDarkMode
        { light = light
        , dark = dark
        }


formField : Palette Color
formField =
    { background = Just (rgba 0 0 0 0)
    , color = Just (rgba 0 0 0 0.87)
    , border = Just (rgba 34 36 38 0.15)
    }
