module Data exposing
    ( Size(..), sizeFromString, sizeToString
    , PresetColor(..)
    )

{-|

@docs Size, sizeFromString, sizeToString
@docs PresetColor

-}


type Size
    = Massive
    | Huge
    | Big
    | Large
    | Medium
    | Small
    | Tiny
    | Mini


sizeFromString : String -> Maybe Size
sizeFromString string =
    case string of
        "Massive" ->
            Just Massive

        "Huge" ->
            Just Huge

        "Big" ->
            Just Big

        "Large" ->
            Just Large

        "Medium" ->
            Just Medium

        "Small" ->
            Just Small

        "Tiny" ->
            Just Tiny

        "Mini" ->
            Just Mini

        _ ->
            Nothing


sizeToString : Size -> String
sizeToString size =
    case size of
        Massive ->
            "Massive"

        Huge ->
            "Huge"

        Big ->
            "Big"

        Large ->
            "Large"

        Medium ->
            "Medium"

        Small ->
            "Small"

        Tiny ->
            "Tiny"

        Mini ->
            "Mini"


type PresetColor
    = Red
    | Orange
    | Yellow
    | Olive
    | Green
    | Teal
    | Blue
    | Violet
    | Purple
    | Pink
    | Brown
    | Grey
    | Black
