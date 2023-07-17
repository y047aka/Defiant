module Basics.Extra exposing (decrementIfPositive)


decrementIfPositive : Float -> Float -> Float
decrementIfPositive step value =
    if value > 0 then
        ((value * 10) - (step * 10)) / 10

    else
        value
