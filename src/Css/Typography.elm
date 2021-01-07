module Css.Typography exposing
    ( Typography
    , typography
    , init
    , default, heading
    , fomanticFont
    , int, num, px, rem, em
    , inherit, none
    , normal, italic, oblique
    , bold
    , left, center, right
    , baseline, top, middle, bottom
    , capitalize, uppercase, lowercase
    )

{-|

@docs Typography
@docs typography
@docs init
@docs default, heading
@docs fomanticFont
@docs int, num, px, rem, em
@docs inherit, none
@docs normal, italic, oblique
@docs bold
@docs left, center, right
@docs baseline, top, middle, bottom
@docs capitalize, uppercase, lowercase

-}

import Css exposing (Style, batch, fontFamilies, property, qt)
import Css.Extra exposing (whenStyle)


type alias Typography =
    { lineHeight : String
    , textAlign : String
    , verticalAlign : String
    , fontFamilies : List String
    , fontStyle : String
    , fontSize : String
    , fontWeight : String
    , textTransform : String
    , textDecoration : String
    }


typography : Typography -> Style
typography t =
    let
        setUnlessBlank p v =
            whenStyle (v /= "") <| property p v
    in
    batch
        [ setUnlessBlank "text-align" t.textAlign
        , setUnlessBlank "vertical-align" t.verticalAlign
        , whenStyle (t.fontFamilies /= []) <| fontFamilies t.fontFamilies
        , setUnlessBlank "font-style" t.fontStyle
        , setUnlessBlank "font-size" t.fontSize
        , setUnlessBlank "font-weight" t.fontWeight
        , setUnlessBlank "line-height" t.lineHeight
        , setUnlessBlank "text-transform" t.textTransform
        , setUnlessBlank "text-decoration" t.textDecoration
        ]


init : Typography
init =
    { textAlign = ""
    , verticalAlign = ""
    , fontFamilies = []
    , fontStyle = ""
    , fontSize = ""
    , fontWeight = ""
    , lineHeight = ""
    , textTransform = ""
    , textDecoration = ""
    }


default : Typography
default =
    { init
        | fontFamilies = fomanticFont
        , fontSize = px 14
        , lineHeight = em 1.4285
    }


heading : Typography
heading =
    { default
        | fontWeight = bold
        , lineHeight = em 1.28571429
    }


fomanticFont : List String
fomanticFont =
    [ qt "Lato", qt "Helvetica Neue", "Arial", "Helvetica", "sans-serif" ]



-- HELPERS


int : Int -> String
int =
    String.fromInt


num : Float -> String
num =
    String.fromFloat


px : Float -> String
px px_ =
    String.fromFloat px_ ++ "px"


rem : Float -> String
rem rem_ =
    String.fromFloat rem_ ++ "rem"


em : Float -> String
em em_ =
    String.fromFloat em_ ++ "em"


inherit : String
inherit =
    "inherit"


none : String
none =
    "none"


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


normal : String
normal =
    "normal"


italic : String
italic =
    "italic"


oblique : String
oblique =
    "oblique"


bold : String
bold =
    "bold"


capitalize : String
capitalize =
    "capitalize"


uppercase : String
uppercase =
    "uppercase"


lowercase : String
lowercase =
    "lowercase"
