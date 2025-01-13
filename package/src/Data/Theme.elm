module Data.Theme exposing (Theme(..), fromString, isDark, isSystem, toString)


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


isSystem : Theme -> Bool
isSystem theme =
    case theme of
        System ->
            True

        _ ->
            False


isDark : Theme -> Bool
isDark theme =
    case theme of
        Dark ->
            True

        _ ->
            False
