module UI.Internal exposing (styledBlock)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Html.Styled as Html exposing (Attribute, Html)


styledBlock :
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
styledBlock opts additionalStyles =
    Html.styled opts.tag
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
            |> Maybe.map (prefixed [] "box-shadow")
            |> Maybe.withDefault (batch [])

        -- AdditionalStyles
        , batch additionalStyles
        ]
