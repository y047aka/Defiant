module Css.Palette exposing
    ( Palette
    , primary, primaryOnHover, primaryOnFocus
    , secondary, secondaryOnHover, secondaryOnFocus
    , red, redOnHover, redOnFocus
    , orange, orangeOnHover, orangeOnFocus
    , yellow, yellowOnHover, yellowOnFocus
    , olive, oliveOnHover, oliveOnFocus
    , green, greenOnHover, greenOnFocus
    , teal, tealOnHover, tealOnFocus
    , blue, blueOnHover, blueOnFocus
    , violet, violetOnHover, violetOnFocus
    , purple, purpleOnHover, purpleOnFocus
    , pink, pinkOnHover, pinkOnFocus
    , brown, brownOnHover, brownOnFocus
    , grey, greyOnHover, greyOnFocus
    , black, blackOnHover, blackOnFocus
    , transparent_
    )

{-|

@docs Palette
@docs primary, primaryOnHover, primaryOnFocus
@docs secondary, secondaryOnHover, secondaryOnFocus
@docs red, redOnHover, redOnFocus
@docs orange, orangeOnHover, orangeOnFocus
@docs yellow, yellowOnHover, yellowOnFocus
@docs olive, oliveOnHover, oliveOnFocus
@docs green, greenOnHover, greenOnFocus
@docs teal, tealOnHover, tealOnFocus
@docs blue, blueOnHover, blueOnFocus
@docs violet, violetOnHover, violetOnFocus
@docs purple, purpleOnHover, purpleOnFocus
@docs pink, pinkOnHover, pinkOnFocus
@docs brown, brownOnHover, brownOnFocus
@docs grey, greyOnHover, greyOnFocus
@docs black, blackOnHover, blackOnFocus

-}

import Css exposing (Color, hex)


type alias Palette =
    { background : Color
    , color : Color
    }


empty : Palette
empty =
    { background = transparent_
    , color = transparent_
    }


transparent_ : Color
transparent_ =
    Css.rgba 0 0 0 0



-- COLORED


colored : Palette
colored =
    { empty | color = hex "#FFFFFF" }


primary : Palette
primary =
    blue


primaryOnHover : Palette
primaryOnHover =
    blueOnHover


primaryOnFocus : Palette
primaryOnFocus =
    blueOnFocus


secondary : Palette
secondary =
    black


secondaryOnHover : Palette
secondaryOnHover =
    blackOnHover


secondaryOnFocus : Palette
secondaryOnFocus =
    blackOnFocus


red : Palette
red =
    { colored | background = hex "#DB2828" }


redOnHover : Palette
redOnHover =
    { red | background = hex "#d01919" }


redOnFocus : Palette
redOnFocus =
    { red | background = hex "#ca1010" }


orange : Palette
orange =
    { colored | background = hex "#F2711C" }


orangeOnHover : Palette
orangeOnHover =
    { orange | background = hex "#f26202" }


orangeOnFocus : Palette
orangeOnFocus =
    { orange | background = hex "#e55b00" }


yellow : Palette
yellow =
    { colored | background = hex "#FBBD08" }


yellowOnHover : Palette
yellowOnHover =
    { yellow | background = hex "#eaae00" }


yellowOnFocus : Palette
yellowOnFocus =
    { yellow | background = hex "#daa300" }


olive : Palette
olive =
    { colored | background = hex "#B5CC18" }


oliveOnHover : Palette
oliveOnHover =
    { olive | background = hex "#a7bd0d" }


oliveOnFocus : Palette
oliveOnFocus =
    { olive | background = hex "#a0b605" }


green : Palette
green =
    { colored | background = hex "#21BA45" }


greenOnHover : Palette
greenOnHover =
    { green | background = hex "#16ab39" }


greenOnFocus : Palette
greenOnFocus =
    { green | background = hex "#0ea432" }


teal : Palette
teal =
    { colored | background = hex "#00B5AD" }


tealOnHover : Palette
tealOnHover =
    { teal | background = hex "#009c95" }


tealOnFocus : Palette
tealOnFocus =
    { teal | background = hex "#008c86" }


blue : Palette
blue =
    { colored | background = hex "#2185D0" }


blueOnHover : Palette
blueOnHover =
    { blue | background = hex "#1678c2" }


blueOnFocus : Palette
blueOnFocus =
    { blue | background = hex "#0d71bb" }


violet : Palette
violet =
    { colored | background = hex "#6435C9" }


violetOnHover : Palette
violetOnHover =
    { violet | background = hex "#5829bb" }


violetOnFocus : Palette
violetOnFocus =
    { violet | background = hex "#4f20b5" }


purple : Palette
purple =
    { colored | background = hex "#A333C8" }


purpleOnHover : Palette
purpleOnHover =
    { purple | background = hex "#9627ba" }


purpleOnFocus : Palette
purpleOnFocus =
    { purple | background = hex "#8f1eb4" }


pink : Palette
pink =
    { colored | background = hex "#E03997" }


pinkOnHover : Palette
pinkOnHover =
    { pink | background = hex "#e61a8d" }


pinkOnFocus : Palette
pinkOnFocus =
    { pink | background = hex "#e10f85" }


brown : Palette
brown =
    { colored | background = hex "#A5673F" }


brownOnHover : Palette
brownOnHover =
    { brown | background = hex "#975b33" }


brownOnFocus : Palette
brownOnFocus =
    { brown | background = hex "#90532b" }


grey : Palette
grey =
    { colored | background = hex "#767676" }


greyOnHover : Palette
greyOnHover =
    { grey | background = hex "#838383" }


greyOnFocus : Palette
greyOnFocus =
    { grey | background = hex "#8a8a8a" }


black : Palette
black =
    { colored | background = hex "#1B1C1D" }


blackOnHover : Palette
blackOnHover =
    { black | background = hex "#27292a" }


blackOnFocus : Palette
blackOnFocus =
    { black | background = hex "#2f3032" }
