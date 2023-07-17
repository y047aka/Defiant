module UI.Layout.Cluster exposing (Props, cluster, defaultProps)

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
        , property "flex-wrap" "wrap"
        , gap (rem props.gap)
        , property "justify-content" props.justify
        , property "align-items" props.align
        ]
        atributes
        items
