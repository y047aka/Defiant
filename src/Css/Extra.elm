module Css.Extra exposing (none, orNone, prefixed, when)

import Css exposing (..)



-- HELPERS


none : Style
none =
    batch []


when : Bool -> Style -> Style
when condition style =
    if condition then
        style

    else
        none


orNone : Maybe a -> (a -> Style) -> Style
orNone maybe f =
    maybe
        |> Maybe.map f
        |> Maybe.withDefault none



-- PREFIXER


prefixed : List String -> String -> String -> Style
prefixed prefixes p v =
    let
        originalStyle =
            Css.property p v

        prefixedStyles =
            List.map (\prefix -> Css.property (prefix ++ p) v) prefixes

        default =
            List.append prefixedStyles [ originalStyle ]
                |> batch
    in
    case p of
        "box-shadow" ->
            default

        _ ->
            originalStyle
