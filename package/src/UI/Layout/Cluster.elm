module UI.Layout.Cluster exposing
    ( Props, defaultProps
    , cluster
    , setJustify, setAlign, setGap
    )

{-|

@docs Props, defaultProps
@docs cluster
@docs setJustify, setAlign, setGap

-}

import Css exposing (..)
import Css.Extra exposing (gap)
import Html.Styled as Html exposing (Attribute, Html, div)


type alias Props =
    { justify : String
    , align : String
    , gap : Float
    }


defaultProps : Props
defaultProps =
    { justify = "flex-start"
    , align = "flex-start"
    , gap = 1
    }


cluster : Props -> List (Attribute msg) -> List (Html msg) -> Html msg
cluster props atributes items =
    Html.styled div
        [ displayFlex
        , flexWrap wrap
        , gap (rem props.gap)
        , property "justify-content" props.justify
        , property "align-items" props.align
        ]
        atributes
        items



-- HELPERS


setJustify : String -> Props -> Props
setJustify val props =
    { props | justify = val }


setAlign : String -> Props -> Props
setAlign val props =
    { props | align = val }


setGap : Float -> Props -> Props
setGap val props =
    { props | gap = val }
