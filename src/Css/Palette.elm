module Css.Palette exposing
    ( Palette
    , palette
    , red, redOnHover, redOnFocus, redOnActive
    , orange, orangeOnHover, orangeOnFocus, orangeOnActive
    , yellow, yellowOnHover, yellowOnFocus, yellowOnActive
    , olive, oliveOnHover, oliveOnFocus, oliveOnActive
    , green, greenOnHover, greenOnFocus, greenOnActive
    , teal, tealOnHover, tealOnFocus, tealOnActive
    , blue, blueOnHover, blueOnFocus, blueOnActive
    , violet, violetOnHover, violetOnFocus, violetOnActive
    , purple, purpleOnHover, purpleOnFocus, purpleOnActive
    , pink, pinkOnHover, pinkOnFocus, pinkOnActive
    , brown, brownOnHover, brownOnFocus, brownOnActive
    , grey, greyOnHover, greyOnFocus, greyOnActive
    , black, blackOnHover, blackOnFocus, blackOnActive
    , transparent_, textColor, hoverColor
    )

{-|

@docs Palette
@docs palette
@docs red, redOnHover, redOnFocus, redOnActive
@docs orange, orangeOnHover, orangeOnFocus, orangeOnActive
@docs yellow, yellowOnHover, yellowOnFocus, yellowOnActive
@docs olive, oliveOnHover, oliveOnFocus, oliveOnActive
@docs green, greenOnHover, greenOnFocus, greenOnActive
@docs teal, tealOnHover, tealOnFocus, tealOnActive
@docs blue, blueOnHover, blueOnFocus, blueOnActive
@docs violet, violetOnHover, violetOnFocus, violetOnActive
@docs purple, purpleOnHover, purpleOnFocus, purpleOnActive
@docs pink, pinkOnHover, pinkOnFocus, pinkOnActive
@docs brown, brownOnHover, brownOnFocus, brownOnActive
@docs grey, greyOnHover, greyOnFocus, greyOnActive
@docs black, blackOnHover, blackOnFocus, blackOnActive
@docs transparent_, textColor, hoverColor

-}

import Css exposing (..)
import Css.Extra exposing (when)


type alias Palette =
    { background : Color
    , color : Color
    , border : Color
    }


palette : Palette -> Style
palette p =
    batch
        [ when (p.background /= transparent_) <| backgroundColor p.background
        , when (p.color /= transparent_) <| color p.color
        , when (p.border /= transparent_) <| borderColor p.border
        ]


empty : Palette
empty =
    { background = transparent_
    , color = transparent_
    , border = transparent_
    }



-- COLORED


colored : Palette
colored =
    { empty | color = hex "#FFFFFF" }


red : Palette
red =
    { colored
        | background = hex "#DB2828"
        , border = hex "#DB2828"
    }


redOnHover : Palette
redOnHover =
    { red | background = hex "#d01919" }


redOnFocus : Palette
redOnFocus =
    { red | background = hex "#ca1010" }


redOnActive : Palette
redOnActive =
    { red | background = hex "#b21e1e" }


orange : Palette
orange =
    { colored
        | background = hex "#F2711C"
        , border = hex "#F2711C"
    }


orangeOnHover : Palette
orangeOnHover =
    { orange | background = hex "#f26202" }


orangeOnFocus : Palette
orangeOnFocus =
    { orange | background = hex "#e55b00" }


orangeOnActive : Palette
orangeOnActive =
    { orange | background = hex "#cf590c" }


yellow : Palette
yellow =
    { colored
        | background = hex "#FBBD08"
        , border = hex "#FBBD08"
    }


yellowOnHover : Palette
yellowOnHover =
    { yellow | background = hex "#eaae00" }


yellowOnFocus : Palette
yellowOnFocus =
    { yellow | background = hex "#daa300" }


yellowOnActive : Palette
yellowOnActive =
    { yellow | background = hex "#cd9903" }


olive : Palette
olive =
    { colored
        | background = hex "#B5CC18"
        , border = hex "#B5CC18"
    }


oliveOnHover : Palette
oliveOnHover =
    { olive | background = hex "#a7bd0d" }


oliveOnFocus : Palette
oliveOnFocus =
    { olive | background = hex "#a0b605" }


oliveOnActive : Palette
oliveOnActive =
    { olive | background = hex "#8d9e13" }


green : Palette
green =
    { colored
        | background = hex "#21BA45"
        , border = hex "#21BA45"
    }


greenOnHover : Palette
greenOnHover =
    { green | background = hex "#16ab39" }


greenOnFocus : Palette
greenOnFocus =
    { green | background = hex "#0ea432" }


greenOnActive : Palette
greenOnActive =
    { green | background = hex "#198f35" }


teal : Palette
teal =
    { colored
        | background = hex "#00B5AD"
        , border = hex "#00B5AD"
    }


tealOnHover : Palette
tealOnHover =
    { teal | background = hex "#009c95" }


tealOnFocus : Palette
tealOnFocus =
    { teal | background = hex "#008c86" }


tealOnActive : Palette
tealOnActive =
    { teal | background = hex "#00827c" }


blue : Palette
blue =
    { colored
        | background = hex "#2185D0"
        , border = hex "#2185D0"
    }


blueOnHover : Palette
blueOnHover =
    { blue | background = hex "#1678c2" }


blueOnFocus : Palette
blueOnFocus =
    { blue | background = hex "#0d71bb" }


blueOnActive : Palette
blueOnActive =
    { blue | background = hex "#1a69a4" }


violet : Palette
violet =
    { colored
        | background = hex "#6435C9"
        , border = hex "#6435C9"
    }


violetOnHover : Palette
violetOnHover =
    { violet | background = hex "#5829bb" }


violetOnFocus : Palette
violetOnFocus =
    { violet | background = hex "#4f20b5" }


violetOnActive : Palette
violetOnActive =
    { violet | background = hex "#502aa1" }


purple : Palette
purple =
    { colored
        | background = hex "#A333C8"
        , border = hex "#A333C8"
    }


purpleOnHover : Palette
purpleOnHover =
    { purple | background = hex "#9627ba" }


purpleOnFocus : Palette
purpleOnFocus =
    { purple | background = hex "#8f1eb4" }


purpleOnActive : Palette
purpleOnActive =
    { purple | background = hex "#82299f" }


pink : Palette
pink =
    { colored
        | background = hex "#E03997"
        , border = hex "#E03997"
    }


pinkOnHover : Palette
pinkOnHover =
    { pink | background = hex "#e61a8d" }


pinkOnFocus : Palette
pinkOnFocus =
    { pink | background = hex "#e10f85" }


pinkOnActive : Palette
pinkOnActive =
    { pink | background = hex "#c71f7e" }


brown : Palette
brown =
    { colored
        | background = hex "#A5673F"
        , border = hex "#A5673F"
    }


brownOnHover : Palette
brownOnHover =
    { brown | background = hex "#975b33" }


brownOnFocus : Palette
brownOnFocus =
    { brown | background = hex "#90532b" }


brownOnActive : Palette
brownOnActive =
    { brown | background = hex "#805031" }


grey : Palette
grey =
    { colored
        | background = hex "#767676"
        , border = hex "#767676"
    }


greyOnHover : Palette
greyOnHover =
    { grey | background = hex "#838383" }


greyOnFocus : Palette
greyOnFocus =
    { grey | background = hex "#8a8a8a" }


greyOnActive : Palette
greyOnActive =
    { grey | background = hex "#909090" }


black : Palette
black =
    { colored
        | background = hex "#1B1C1D"
        , border = hex "#1B1C1D"
    }


blackOnHover : Palette
blackOnHover =
    { black | background = hex "#27292a" }


blackOnFocus : Palette
blackOnFocus =
    { black | background = hex "#2f3032" }


blackOnActive : Palette
blackOnActive =
    { black | background = hex "#343637" }



-- COLOR


transparent_ : Color
transparent_ =
    Css.rgba 0 0 0 0


textColor : Color
textColor =
    rgba 0 0 0 0.6


hoverColor : Color
hoverColor =
    rgba 0 0 0 0.8
