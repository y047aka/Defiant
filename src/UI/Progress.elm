module UI.Progress exposing (progress)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html, text)


basis : List (Attribute msg) -> List (Html msg) -> Html msg
basis =
    Html.styled Html.div
        [ -- .ui.progress
          position relative
        , Prefix.displayFlex
        , maxWidth (pct 100)
        , property "border" "none"
        , margin3 (em 1) zero (em 2.5)
        , prefixed [] "box-shadow" "none"
        , property "background" "rgba(0, 0, 0, 0.1)"
        , padding zero
        , borderRadius (rem 0.28571429)

        -- .ui.progress:first-child
        , firstChild
            [ margin3 zero zero (em 2.5) ]

        -- .ui.progress:last-child
        , lastChild
            [ margin3 zero zero (em 1.5) ]

        -- .ui.progress
        , fontSize (rem 1)
        ]


progress : { value : Float, label : String } -> Html msg
progress options =
    basis []
        [ bar options.value
        , label [] [ text options.label ]
        ]


bar : Float -> Html msg
bar value =
    let
        bar_ =
            Html.styled Html.div
                [ -- .ui.progress .bar
                  display block
                , lineHeight (int 1)
                , position relative
                , width (pct value)
                , minWidth (em 2)
                , if value == 0 then
                    -- .ui.ui.ui.progress:not([data-percent]):not(.indeterminate) .bar
                    -- .ui.ui.ui.progress[data-percent="0"]:not(.indeterminate) .bar
                    property "background" "transparent"

                  else if value == 100 then
                    -- .ui.ui.progress.success .bar
                    backgroundColor (hex "#21BA45")

                  else
                    property "background" "#888888"
                , borderRadius (rem 0.28571429)
                , property "-webkit-transition" "width 0.1s ease, background-color 0.1s ease"
                , property "transition" "width 0.1s ease, background-color 0.1s ease"
                , overflow hidden

                -- .ui.progress .bar
                , height (em 1.75)

                -- progress.js
                , property "transition-duration" "300ms"
                ]

        progress_ =
            Html.styled Html.div
                [ -- .ui.progress .bar > .progress
                  whiteSpace noWrap
                , position absolute
                , width auto
                , fontSize (em 0.92857143)
                , top (pct 50)
                , right (em 0.5)
                , left auto
                , bottom auto
                , color <|
                    if value == 0 then
                        -- .ui.progress[data-percent="0"] .bar .progress
                        rgba 0 0 0 0.87

                    else
                        rgba 255 255 255 0.7
                , textShadow none
                , marginTop (em -0.5)
                , fontWeight bold
                , textAlign left
                ]
    in
    bar_ []
        [ progress_ [] [ text (String.fromFloat value ++ "%") ] ]


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    Html.styled Html.div
        [ -- .ui.progress > .label
          position absolute
        , width (pct 100)
        , fontSize (em 1)
        , top (pct 100)
        , right auto
        , left zero
        , bottom auto
        , color (rgba 0 0 0 0.87)
        , fontWeight bold
        , textShadow none
        , marginTop (em 0.2)
        , textAlign center
        , property "-webkit-transition" "color 0.4s ease"
        , property "transition" "color 0.4s ease"
        ]
