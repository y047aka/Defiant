module Css.Typography exposing
    ( Typography
    , typography
    , init
    , default, heading
    , fomanticFontFamilies
    , int, num, px, rem, em
    , inherit, none
    , normal, italic, oblique
    , bold
    , capitalize, uppercase, lowercase
    )

{-|

@docs Typography
@docs typography
@docs init
@docs default, heading
@docs fomanticFontFamilies
@docs int, num, px, rem, em
@docs inherit, none
@docs normal, italic, oblique
@docs bold
@docs capitalize, uppercase, lowercase

-}

import Css exposing (Style, batch, fontFamilies, property, qt)
import Css.Extra exposing (when)


type alias Typography =
    { lineHeight : String
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
            when (v /= "") <| property p v
    in
    batch
        [ when (t.fontFamilies /= []) <| fontFamilies t.fontFamilies
        , setUnlessBlank "font-style" t.fontStyle
        , setUnlessBlank "font-size" t.fontSize
        , setUnlessBlank "font-weight" t.fontWeight
        , setUnlessBlank "line-height" t.lineHeight
        , setUnlessBlank "text-transform" t.textTransform
        , setUnlessBlank "text-decoration" t.textDecoration
        ]


init : Typography
init =
    { fontFamilies = []
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
        | fontFamilies = fomanticFontFamilies
        , fontSize = px 14
        , lineHeight = em 1.4285
    }


heading : Typography
heading =
    { default
        | fontWeight = bold
        , lineHeight = em 1.28571429
    }


fomanticFontFamilies : List String
fomanticFontFamilies =
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
