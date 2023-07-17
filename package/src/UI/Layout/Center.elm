module UI.Layout.Center exposing (Props, center, defaultProps)

import Css exposing (..)
import Css.Extra exposing (batchIf, marginInline, paddingInline)
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
        ]
        atributes
        items
