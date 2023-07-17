module UI.Layout.Stack exposing (Props, defaultProps, setGap, stack)

import Css exposing (..)
import Css.Extra exposing (marginBlock, rowGap)
import Css.Global exposing (children, everything)
import Html.Styled as Html exposing (Attribute, Html, div)


type alias Props =
    { gap : Float }


defaultProps : Props
defaultProps =
    { gap = 1.5 }


stack : Props -> List (Attribute msg) -> List (Html msg) -> Html msg
stack props atributes items =
    Html.styled div
        [ displayFlex
        , flexDirection column
        , justifyContent flexStart
        , rowGap (rem props.gap)
        , children
            [ everything
                [ marginBlock zero ]
            ]
        ]
        atributes
        items



-- HELPERS


setGap : Float -> Props -> Props
setGap gap props =
    { props | gap = gap }
