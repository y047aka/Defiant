module UI.Section exposing (section)

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)


section : List (Attribute msg) -> List (Html msg) -> Html msg
section attributes =
    Html.section <|
        css
            [ -- .ui.segment {
              position relative
            , backgroundColor (hex "#FFFFFF")
            , property "-webkit-box-shadow" "0 1px 2px 0 rgba(34, 36, 38, 0.15)"
            , property "box-shadow" "0 1px 2px 0 rgba(34, 36, 38, 0.15)"
            , margin2 (rem 1) zero
            , padding2 (em 1) (em 1)
            , borderRadius (rem 0.28571429)
            , border3 (px 1) solid (rgba 34 36 38 0.15)

            -- .ui.segment:first-child
            , marginTop zero

            -- .ui.segment:last-child
            , marginBottom zero
            ]
            :: attributes
