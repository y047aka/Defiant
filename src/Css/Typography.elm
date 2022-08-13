module Css.Typography exposing
    ( Typography, init
    , typography
    , setFontFamilies, setFontWeight
    , default, bold
    )

{-|

@docs Typography, init
@docs typography
@docs setFontFamilies, setFontWeight

@docs default, bold
@docs fomanticFontFamilies

-}

import Css exposing (Compatible, FontWeight, Style, batch, fontFamilies, fontWeight, qt)


type alias Typography =
    { fontFamilies : List String
    , fontWeight : Maybe { value : String, fontWeight : Compatible }
    }


init : Typography
init =
    { fontFamilies = []
    , fontWeight = Nothing
    }


typography : Typography -> Style
typography t =
    [ if t.fontFamilies /= [] then
        fontFamilies t.fontFamilies

      else
        batch []
    , t.fontWeight
        |> Maybe.map fontWeight
        |> Maybe.withDefault (batch [])
    ]
        |> batch


setFontFamilies : List String -> Typography -> Typography
setFontFamilies families t =
    { t | fontFamilies = families }


setFontWeight : FontWeight a -> Typography -> Typography
setFontWeight { value, fontWeight } t =
    { t | fontWeight = Just { value = value, fontWeight = fontWeight } }


default : Typography
default =
    init
        |> setFontFamilies fomanticFontFamilies


bold : Typography
bold =
    init
        |> setFontFamilies fomanticFontFamilies
        |> setFontWeight Css.bold


fomanticFontFamilies : List String
fomanticFontFamilies =
    [ qt "Lato", qt "Helvetica Neue", "Arial", "Helvetica", "sans-serif" ]
