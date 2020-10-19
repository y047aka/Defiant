module UI.Modifier exposing (Palette(..), fontFamilies)

import Css exposing (..)


fontFamilies : List String
fontFamilies =
    [ qt "Lato", qt "Helvetica Neue", "Arial", "Helvetica", "sans-serif" ]


type Palette
    = Primary
    | Secondary
    | Red
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
