module Css.Typography exposing
    ( Typography, init
    , typography
    , setFontFamilies, setFontSize, setFontStyle, setFontWeight, setLineHeight, setLetterSpacing, setTextDecoration, setTextTransform
    , default, bold
    )

{-|

@docs Typography, init
@docs typography
@docs setFontFamilies, setFontSize, setFontStyle, setFontWeight, setLineHeight, setLetterSpacing, setTextDecoration, setTextTransform

@docs default, bold

-}

import Css exposing (FontSize, FontStyle, FontWeight, Length, LengthOrNumber, Style, TextDecorationLine, TextTransform, batch, fontFamilies, fontSize, fontStyle, fontWeight, letterSpacing, property, qt, textDecoration, textTransform)


type alias Typography =
    { fontFamilies : List String
    , fontSize : Maybe (FontSize {})
    , fontStyle : Maybe (FontStyle {})
    , fontWeight : Maybe (FontWeight {})
    , lineHeight : Maybe (LengthOrNumber {})
    , letterSpacing : Maybe (Length {} {})
    , textDecoration : Maybe (TextDecorationLine {})
    , textTransform : Maybe (TextTransform {})
    }


init : Typography
init =
    { fontFamilies = []
    , fontSize = Nothing
    , fontStyle = Nothing
    , fontWeight = Nothing
    , lineHeight = Nothing
    , letterSpacing = Nothing
    , textDecoration = Nothing
    , textTransform = Nothing
    }


typography : Typography -> Style
typography t =
    [ if t.fontFamilies /= [] then
        fontFamilies t.fontFamilies

      else
        batch []
    , t.fontSize
        |> Maybe.map fontSize
        |> Maybe.withDefault (batch [])
    , t.fontStyle
        |> Maybe.map fontStyle
        |> Maybe.withDefault (batch [])
    , t.fontWeight
        |> Maybe.map fontWeight
        |> Maybe.withDefault (batch [])
    , t.lineHeight
        |> Maybe.map (.value >> property "line-height")
        |> Maybe.withDefault (batch [])
    , t.letterSpacing
        |> Maybe.map letterSpacing
        |> Maybe.withDefault (batch [])
    , t.textDecoration
        |> Maybe.map textDecoration
        |> Maybe.withDefault (batch [])
    , t.textTransform
        |> Maybe.map textTransform
        |> Maybe.withDefault (batch [])
    ]
        |> batch


setFontFamilies : List String -> Typography -> Typography
setFontFamilies families t =
    { t | fontFamilies = families }


setFontSize : FontSize a -> Typography -> Typography
setFontSize { value, fontSize } t =
    { t | fontSize = Just { value = value, fontSize = fontSize } }


setFontStyle : FontStyle a -> Typography -> Typography
setFontStyle { value, fontStyle } t =
    { t | fontStyle = Just { value = value, fontStyle = fontStyle } }


setFontWeight : FontWeight a -> Typography -> Typography
setFontWeight { value, fontWeight } t =
    { t | fontWeight = Just { value = value, fontWeight = fontWeight } }


setLineHeight : LengthOrNumber compatible -> Typography -> Typography
setLineHeight { value, lengthOrNumber } t =
    { t | lineHeight = Just { value = value, lengthOrNumber = lengthOrNumber } }


setLetterSpacing : Length compatible unit -> Typography -> Typography
setLetterSpacing { value, length, numericValue, unitLabel } t =
    { t | letterSpacing = Just { value = value, length = length, numericValue = numericValue, units = {}, unitLabel = unitLabel } }


setTextDecoration : TextDecorationLine a -> Typography -> Typography
setTextDecoration { value, textDecorationLine } t =
    { t | textDecoration = Just { value = value, textDecorationLine = textDecorationLine } }


setTextTransform : TextTransform compatible -> Typography -> Typography
setTextTransform { value, textTransform } t =
    { t | textTransform = Just { value = value, textTransform = textTransform } }


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
