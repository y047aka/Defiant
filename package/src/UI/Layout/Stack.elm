module UI.Layout.Stack exposing (Props, defaultProps, stack)

import Css exposing (..)
import Css.Extra exposing (rowGap)
import Css.Global exposing (children, everything)
import Html.Styled as Html exposing (Attribute, Html, div)


type alias Props =
    { gap : Float }


defaultProps : Props
defaultProps =
    { gap = 1.5 }


stack : { gap : Float } -> List (Attribute msg) -> List (Html msg) -> Html msg
stack props atributes items =
    Html.styled div
        [ displayFlex
        , flexDirection column
        , justifyContent flexStart
        , rowGap (rem props.gap)
        , children
            [ everything
                [ marginTop zero
                , marginBottom zero
                ]
            ]
        ]
        atributes
        items
