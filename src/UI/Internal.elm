module UI.Internal exposing (chassis)

import Css exposing (..)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)


chassis :
    { tag : List (Attribute msg) -> List (Html msg) -> Html msg
    , position : Maybe Style
    , margin : Maybe Style
    , padding : Maybe Style
    , borderRadius : Maybe (Length compatible units)
    , palette :
        { background : Maybe Color
        , color : Maybe Color
        , border : Maybe Color
        }
    , boxShadow : Maybe String
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
        , opts.palette.border
            |> Maybe.map (border3 (px 1) solid)
            |> Maybe.withDefault (batch [])
        , opts.boxShadow
            |> Maybe.map Prefix.boxShadow
            |> Maybe.withDefault (batch [])
        ]
            ++ additionalStyles
