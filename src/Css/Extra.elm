module Css.Extra exposing (none, whenStyle)

import Css exposing (..)



-- HELPERS


none : Style
none =
    batch []


whenStyle : Bool -> Style -> Style
whenStyle condition style =
    if condition then
        style

    else
        none
