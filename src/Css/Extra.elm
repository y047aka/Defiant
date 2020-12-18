module Css.Extra exposing (none, palette)

import Css exposing (..)
import Css.Palette exposing (Palette, transparent_)


palette : Palette -> Style
palette p =
    batch
        [ whenStyle (p.background /= transparent_) <| backgroundColor p.background
        , whenStyle (p.color /= transparent_) <| color p.color

        -- , whenStyle (p.border /= transparent_) <| borderColor p.border
        ]



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
