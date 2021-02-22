module UI.Internal exposing (chassis)

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html)


chassis :
    { tag : List (Attribute msg) -> List (Html msg) -> Html msg
    , border : Bool
    , borderColor : Color
    }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
chassis { tag, border, borderColor } additionalStyles =
    Html.styled tag <|
        [ if border then
            border3 (px 1) solid borderColor

          else
            property "border" "none"
        ]
            ++ additionalStyles
