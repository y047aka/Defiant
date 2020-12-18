module Css.Extra exposing (Palette, palette, transparent_)

import Css exposing (..)


type alias Palette =
    { background : Color
    , color : Color
    }


palette : Palette -> Style
palette p =
    batch
        [ whenStyle (p.background /= transparent_) <| backgroundColor p.background
        , whenStyle (p.color /= transparent_) <| color p.color

        -- , whenStyle (p.border /= transparent_) <| borderColor p.border
        ]


transparent_ : Color
transparent_ =
    Css.rgba 0 0 0 0



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
