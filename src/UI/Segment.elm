module UI.Segment exposing (segment, verticalSegment)

import Css exposing (..)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.section <|
        [ -- .ui.segment
          position relative
        , backgroundColor (hex "#FFFFFF")
        , Prefix.boxShadow "0 1px 2px 0 rgba(34, 36, 38, 0.15)"
        , margin2 (rem 1) zero
        , padding2 (em 1) (em 1)
        , borderRadius (rem 0.28571429)
        , border3 (px 1) solid (rgba 34 36 38 0.15)

        -- .ui.segment:first-child
        , pseudoClass "first-child"
            [ marginTop zero ]

        -- .ui.segment:last-child
        , pseudoClass "last-child"
            [ marginBottom zero ]
        ]
            ++ additionalStyles


segment : List (Attribute msg) -> List (Html msg) -> Html msg
segment =
    basis []


verticalSegment : List (Attribute msg) -> List (Html msg) -> Html msg
verticalSegment =
    basis
        [ -- .ui.vertical.segment
          margin zero
        , paddingLeft zero
        , paddingRight zero
        , property "background" "none transparent"
        , borderRadius zero
        , Prefix.boxShadow "none"
        , property "border" "none"
        , borderBottom3 (px 1) solid (rgba 34 36 38 0.15)

        -- .ui.vertical.segment:last-child
        , lastChild
            [ property "border-bottom" "none" ]
        ]
