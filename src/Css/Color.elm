module Css.Color exposing
    ( info, success, warning, error
    , red, orange, yellow, olive, green, teal, blue, violet, purple, pink, brown, grey, black
    )

{-|

@docs info, success, warning, error
@docs red, orange, yellow, olive, green, teal, blue, violet, purple, pink, brown, grey, black

-}

import Css exposing (..)


info : Color
info =
    hex "#31CCEC"


success : Color
success =
    green


warning : Color
warning =
    hex "#F2C037"


error : Color
error =
    red


red : Color
red =
    hex "#DB2828"


orange : Color
orange =
    hex "#F2711C"


yellow : Color
yellow =
    hex "#FBBD08"


olive : Color
olive =
    hex "#B5CC18"


green : Color
green =
    hex "#21BA45"


teal : Color
teal =
    hex "#00B5AD"


blue : Color
blue =
    hex "#2185D0"


violet : Color
violet =
    hex "#6435C9"


purple : Color
purple =
    hex "#A333C8"


pink : Color
pink =
    hex "#E03997"


brown : Color
brown =
    hex "#A5673F"


grey : Color
grey =
    hex "#767676"


black : Color
black =
    hex "#1B1C1D"
