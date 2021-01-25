module Css.Extra exposing (none, when)

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
