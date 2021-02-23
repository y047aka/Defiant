module UI.Internal exposing (chassis)

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html)


chassis :
    { tag : List (Attribute msg) -> List (Html msg) -> Html msg
    , position : Maybe Style
    , margin : Maybe Style
    , padding : Maybe Style
    , borderRadius : Maybe (Length compatible units)
    , border : Bool
    , palette :
        { background : Maybe Color
        , color : Maybe Color
        , border : Color
        }
    }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
chassis opts additionalStyles =
    Html.styled opts.tag <|
        [ opts.position
            |> Maybe.withDefault (batch [])
        , opts.margin
            |> Maybe.withDefault (batch [])
        , opts.padding
            |> Maybe.withDefault (batch [])
        , opts.borderRadius
            |> Maybe.map borderRadius
            |> Maybe.withDefault (borderRadius zero)
        , opts.palette.background
            |> Maybe.map backgroundColor
            |> Maybe.withDefault (property "background" "none")
        , opts.palette.color
            |> Maybe.map color
            |> Maybe.withDefault (batch [])
        , if opts.border then
            border3 (px 1) solid opts.palette.border

          else
            property "border" "none"
        ]
            ++ additionalStyles
