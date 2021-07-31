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
prefixed additionalPrefixes p v =
    let
        originalStyle =
            Css.property p v

        prefixedStyles defaultPrefixes =
            (defaultPrefixes ++ additionalPrefixes)
                |> List.map (\prefix -> Css.property (prefix ++ p) v)

        default defaultPrefixes =
            batch <| prefixedStyles defaultPrefixes ++ [ originalStyle ]
    in
    case p of
        "box-shadow" ->
            default [ "-webkit-" ]

        _ ->
            originalStyle
