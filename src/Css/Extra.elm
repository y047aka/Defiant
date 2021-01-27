module Css.Extra exposing (none, orNone, when)

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
