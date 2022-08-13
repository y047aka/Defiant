module Css.Typography exposing
    ( Typography, init
    , typography
    , fomanticFontFamilies
    )

{-|

@docs Typography, init
@docs typography

@docs fomanticFontFamilies

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


fomanticFontFamilies : List String
fomanticFontFamilies =
    [ qt "Lato", qt "Helvetica Neue", "Arial", "Helvetica", "sans-serif" ]
