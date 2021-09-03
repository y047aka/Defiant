module UI.Step exposing (step, steps)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Typography exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html, text)
import Html.Styled.Attributes exposing (css)
import UI.Icon as Icon


steps : List (Attribute msg) -> List (Html msg) -> Html msg
steps =
    Html.styled Html.div
        [ -- .ui.steps
          prefixed [] "display" "inline-flex"
        , property "-webkit-box-orient" "horizontal"
        , property "-webkit-box-direction" "normal"
        , prefixed [] "flex-direction" "row"
        , prefixed [] "align-items" "stretch"
        , margin2 (em 1) zero
        , property "background" "''"
        , prefixed [] "box-shadow" "none"
        , lineHeight (em 1.14285714)
        , borderRadius (rem 0.28571429)
        , border3 (px 1) solid (rgba 34 36 38 0.15)

        -- .ui.steps:not(.unstackable)
        , prefixed [] "flex-wrap" "wrap"

        -- .ui.steps:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.steps:last-child
        , lastChild
            [ marginBottom zero ]
        ]


stepBasis : List (Attribute msg) -> List (Html msg) -> Html msg
stepBasis =
    Html.styled Html.div
        [ -- .ui.steps .step
          position relative
        , prefixed [] "display" "flex"
        , prefixed [] "flex" "1 0 auto"
        , prefixed [] "flex-wrap" "wrap"
        , property "-webkit-box-orient" "horizontal"
        , property "-webkit-box-direction" "normal"
        , prefixed [] "flex-direction" "row"
        , verticalAlign middle
        , prefixed [] "align-items" "center"
        , prefixed [] "justify-content" "center"
        , margin2 zero zero
        , padding2 (em 1.14285714) (em 2)
        , property "background" "#FFFFFF"
        , color (rgba 0 0 0 0.87)
        , prefixed [] "box-shadow" "none"
        , borderRadius zero
        , property "border" "none"
        , borderRight3 (px 1) solid (rgba 34 36 38 0.15)
        , property "-webkit-transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"

        -- .ui.steps .step:after
        , after
            [ display none
            , position absolute
            , zIndex (int 2)
            , property "content" "''"
            , top (pct 50)
            , right zero
            , backgroundColor (hex "#FFFFFF")
            , width (em 1.14285714)
            , height (em 1.14285714)
            , borderStyle solid
            , borderColor (rgba 34 36 38 0.15)
            , borderWidth4 zero (px 1) (px 1) zero
            , property "-webkit-transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "-webkit-transform" "translateY(-50%) translateX(50%) rotate(-45deg)"
            , property "transform" "translateY(-50%) translateX(50%) rotate(-45deg)"
            ]

        -- .ui.steps .step:first-child
        , firstChild
            [ paddingLeft (em 2)
            , borderRadius4 (rem 0.28571429) zero zero (rem 0.28571429)
            ]

        -- .ui.steps .step:last-child
        , lastChild
            [ borderRadius4 zero (rem 0.28571429) (rem 0.28571429) zero
            , property "border-right" "none"
            , marginRight zero
            ]

        -- .ui.steps .step:only-child
        , onlyChild
            [ borderRadius (rem 0.28571429) ]
        ]


step : List (Attribute msg) -> { icon : String, title : String, description : String } -> Html msg
step attributes content_ =
    stepBasis
        attributes
        [ case content_.icon of
            "" ->
                text ""

            icon_ ->
                icon icon_
        , content [] content_
        ]


icon : String -> Html msg
icon =
    Icon.icon
        [ css
            [ -- .ui.steps .step > i.icon
              lineHeight (int 1)
            , fontSize (em 2.5)
            , margin4 zero (rem 1) zero zero

            -- .ui.steps .step > i.icon
            -- .ui.steps .step > i.icon ~ .content
            , display block
            , prefixed [] "flex" "0 1 auto"
            , prefixed [] "align-self" "middle"

            -- .ui.steps:not(.vertical) .step > i.icon
            , width auto
            ]
        ]


content : List (Attribute msg) -> { a | title : String, description : String } -> Html msg
content attributes options =
    Html.styled Html.div
        []
        attributes
        [ case options.title of
            "" ->
                text ""

            title_ ->
                title [] [ text title_ ]
        , case options.description of
            "" ->
                text ""

            description_ ->
                description [] [ text description_ ]
        ]


title : List (Attribute msg) -> List (Html msg) -> Html msg
title =
    Html.styled Html.div
        [ -- .ui.steps .step .title
          fontFamilies fomanticFontFamilies
        , fontSize (em 1.14285714)
        , fontWeight bold

        -- .ui.steps .step > .title
        , width (pct 100)
        ]


description : List (Attribute msg) -> List (Html msg) -> Html msg
description =
    Html.styled Html.div
        [ -- .ui.steps .step .description
          fontWeight normal
        , fontSize (em 0.92857143)
        , color (rgba 0 0 0 0.87)

        -- .ui.steps .step > .description
        , width (pct 100)

        -- .ui.steps .step .title ~ .description
        , marginTop (em 0.25)
        ]
