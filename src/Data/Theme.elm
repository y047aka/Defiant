module Data.Theme exposing (Theme(..), fromString, toString)


type Theme
    = System
    | Light
    | Dark


fromString : String -> Maybe Theme
fromString string =
    case string of
        "System" ->
            Just System

        "Light" ->
            Just Light

        "Dark" ->
            Just Dark

        _ ->
            Nothing


toString : Theme -> String
toString theme =
    case theme of
        System ->
            "System"

        Light ->
            "Light"

        Dark ->
            "Dark"
