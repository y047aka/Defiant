module Css.Layout exposing
    ( Layout
    , layout
    , init
    , default
    , left, center, right
    , baseline, top, middle, bottom
    )

{-|

@docs Layout
@docs layout
@docs init
@docs default
@docs left, center, right
@docs baseline, top, middle, bottom

-}

import Css exposing (Style, batch, property)
import Css.Extra exposing (when)


type alias Layout =
    { textAlign : String
    , verticalAlign : String
    }


layout : Layout -> Style
layout t =
    let
        setUnlessBlank p v =
            when (v /= "") <| property p v
    in
    batch
        [ setUnlessBlank "text-align" t.textAlign
        , setUnlessBlank "vertical-align" t.verticalAlign
        ]


init : Layout
init =
    { textAlign = ""
    , verticalAlign = ""
    }


default : Layout
default =
    { init | verticalAlign = baseline }



-- HELPERS


left : String
left =
    "left"


center : String
center =
    "center"


right : String
right =
    "right"


baseline : String
baseline =
    "baseline"


top : String
top =
    "top"


middle : String
middle =
    "middle"


bottom : String
bottom =
    "bottom"
