module UI.Progress exposing (progress)

import Css exposing (..)
import Css.Animations as Animations exposing (keyframes)
import Css.Extra exposing (prefixed)
import Html.Styled as Html exposing (Attribute, Html, text)


basis : { disabled : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { disabled } =
    Html.styled Html.div
        [ -- .ui.progress
          position relative
        , prefixed [] "display" "flex"
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

        -- Disabled
        , batch <|
            if disabled then
                [ opacity (num 0.35) ]

            else
                []
        ]


progress :
    { value : Float
    , progress : String
    , label : String
    , active : Bool
    , disabled : Bool
    }
    -> Html msg
progress options =
    basis { disabled = options.disabled }
        []
        [ bar options
        , case options.label of
            "" ->
                text ""

            _ ->
                label [] [ text options.label ]
        ]


barBasis :
    { a
        | value : Float
        , active : Bool
        , disabled : Bool
    }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
barBasis { value, active, disabled } =
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

        -- Active
        , batch <|
            if active then
                let
                    progress_active =
                        keyframes
                            [ ( 0
                              , [ Animations.property "opacity" "0.3"
                                , Animations.property "-webkit-transform" "scale(0, 1)"
                                , Animations.transform [ scale2 0 1 ]
                                ]
                              )
                            , ( 100
                              , [ Animations.property "opacity" "0"
                                , Animations.property "-webkit-transform" "scale(1)"
                                , Animations.transform [ scale 1 ]
                                ]
                              )
                            ]
                in
                [ -- .ui.active.progress .bar
                  position relative
                , minWidth (em 2)

                -- .ui.active.progress .bar::after
                , after
                    [ property "content" (qt "")
                    , opacity zero
                    , position absolute
                    , top zero
                    , left zero
                    , right zero
                    , bottom zero
                    , property "background" "#FFFFFF"
                    , borderRadius (rem 0.28571429)
                    , prefixed [] "animation" "progress-active 2s ease infinite;"
                    , prefixed [] "transform-origin" "left"
                    , animationName progress_active
                    ]
                ]

            else
                []

        -- Disabled
        , batch <|
            if disabled then
                [ -- .ui.ui.disabled.progress .bar
                  -- .ui.ui.disabled.progress .bar::after
                  prefixed [] "animation" "none"
                , after
                    [ prefixed [] "animation" "none" ]
                ]

            else
                []
        ]


bar :
    { a
        | value : Float
        , progress : String
        , active : Bool
        , disabled : Bool
    }
    -> Html msg
bar options =
    let
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
                    if options.value == 0 then
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
    barBasis options [] <|
        case options.progress of
            "" ->
                []

            _ ->
                [ progress_ [] [ text options.progress ] ]


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
