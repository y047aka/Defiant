module UI.Layout.Center exposing
    ( Props, defaultProps
    , center
    , setMax, setAndText, setGutters, setIntrinsic
    )

{-|

@docs Props, defaultProps
@docs center
@docs setMax, setAndText, setGutters, setIntrinsic

-}

import Css exposing (..)
import Css.Extra exposing (batchIf, marginInline, paddingInline)
import Css.Global exposing (descendants, everything)
import Html.Styled as Html exposing (Attribute, Html, div)


type alias Props =
    { max : Float
    , andText : Bool
    , gutters : Float
    , intrinsic : Bool
    }


defaultProps : Props
defaultProps =
    { max = 60
    , andText = False
    , gutters = 0
    , intrinsic = False
    }


center : Props -> List (Attribute msg) -> List (Html msg) -> Html msg
center props atributes items =
    Html.styled div
        [ boxSizing contentBox
        , maxWidth (ch props.max)
        , marginInline auto
        , paddingInline (rem props.gutters)
        , batchIf props.andText
            [ textAlign Css.center ]
        , batchIf props.intrinsic
            [ displayFlex
            , flexDirection column
            , alignItems Css.center
            ]
        , descendants
            [ everything [ boxSizing borderBox ] ]
        ]
        atributes
        items



-- HELPERS


setMax : Float -> Props -> Props
setMax val props =
    { props | max = val }


setAndText : Bool -> Props -> Props
setAndText bool props =
    { props | andText = bool }


setGutters : Float -> Props -> Props
setGutters val props =
    { props | gutters = val }


setIntrinsic : Bool -> Props -> Props
setIntrinsic bool props =
    { props | intrinsic = bool }
