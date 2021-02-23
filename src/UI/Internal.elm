module UI.Internal exposing (chassis)

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html)


chassis :
    { tag : List (Attribute msg) -> List (Html msg) -> Html msg
    , borderRadius_ : Maybe (Length compatible units)
    , border : Bool
    , palette_ :
        { background : Maybe Color
        , color : Maybe Color
        , border : Color
        }
    }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
chassis { tag, borderRadius_, border, palette_ } additionalStyles =
    Html.styled tag <|
        [ borderRadius_
            |> Maybe.map borderRadius
            |> Maybe.withDefault (borderRadius zero)
        , palette_.background
            |> Maybe.map backgroundColor
            |> Maybe.withDefault (property "background" "none")
        , palette_.color
            |> Maybe.map color
            |> Maybe.withDefault (batch [])
        , if border then
            border3 (px 1) solid palette_.border

          else
            property "border" "none"
        ]
            ++ additionalStyles
