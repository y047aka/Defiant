module Types exposing
    ( Size(..), sizeFromString, sizeToString
    , PresetColor(..), colorFromString, colorToString
    )

{-|

@docs Size, sizeFromString, sizeToString
@docs PresetColor, colorFromString, colorToString

-}

-- Size


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



-- PresetColor


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


colorFromString : String -> Maybe PresetColor
colorFromString string =
    case string of
        "Red" ->
            Just Red

        "Orange" ->
            Just Orange

        "Yellow" ->
            Just Yellow

        "Olive" ->
            Just Olive

        "Green" ->
            Just Green

        "Teal" ->
            Just Teal

        "Blue" ->
            Just Blue

        "Violet" ->
            Just Violet

        "Purple" ->
            Just Purple

        "Pink" ->
            Just Pink

        "Brown" ->
            Just Brown

        "Grey" ->
            Just Grey

        "Black" ->
            Just Black

        _ ->
            Nothing


colorToString : PresetColor -> String
colorToString color =
    case color of
        Red ->
            "Red"

        Orange ->
            "Orange"

        Yellow ->
            "Yellow"

        Olive ->
            "Olive"

        Green ->
            "Green"

        Teal ->
            "Teal"

        Blue ->
            "Blue"

        Violet ->
            "Violet"

        Purple ->
            "Purple"

        Pink ->
            "Pink"

        Brown ->
            "Brown"

        Grey ->
            "Grey"

        Black ->
            "Black"
