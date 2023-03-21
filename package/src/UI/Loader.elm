module UI.Loader exposing (loader, textLoader)

import Css exposing (..)
import Css.Animations as Animations exposing (keyframes)
import Css.Extra exposing (prefixed)
import Data.Theme exposing (Theme, isDark)
import Html.Styled as Html exposing (Attribute, Html)


basis : { theme : Theme } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { theme } additionalStyles =
    Html.styled Html.div <|
        [ -- Standard Size
          -- .ui.loader
          -- display none
          position absolute
        , top (pct 50)
        , left (pct 50)
        , margin zero
        , textAlign center
        , zIndex (int 1000)
        , prefixed [] "transform" "translateX(-50%) translateY(-50%)"

        -- Static Shape
        , before
            [ -- .ui.loader:before
              position absolute
            , property "content" (qt "")
            , top zero
            , left (pct 50)
            , width (pct 100)
            , height (pct 100)
            , borderRadius (rem 500)
            , border3 (em 0.2) solid (rgba 0 0 0 0.1)
            ]

        -- Active Shape
        , let
            loader_ =
                keyframes
                    [ ( 100
                      , [ Animations.property "-webkit-transform" "rotate(360deg)"
                        , Animations.transform [ rotate (deg 360) ]
                        ]
                      )
                    ]
          in
          after
            [ -- .ui.loader:after
              position absolute
            , property "content" (qt "")
            , top zero
            , left (pct 50)
            , width (pct 100)
            , height (pct 100)

            -- , prefixed [] "animation" "loader 0.6s infinite linear"
            , animationName loader_
            , animationDuration (sec 0.6)
            , property "animation-timing-function" "linear"
            , animationIterationCount infinite
            , border3 (em 0.2) solid (hex "#767676")
            , borderRadius (rem 500)
            , prefixed [] "box-shadow" "0 0 0 1px transparent"

            -- .ui.elastic.loader.loader:before
            -- .ui.elastic.loading.loading.loading:before
            -- .ui.elastic.loading.loading.loading .input > i.icon:before
            -- .ui.elastic.loading.loading.loading > i.icon:before
            -- .ui.loading.loading.loading.loading:not(.usual):after
            -- .ui.loading.loading.loading.loading .input > i.icon:after
            -- .ui.loading.loading.loading.loading > i.icon:after
            -- .ui.loader.loader.loader:after
            , borderColor currentColor

            -- .ui.loading.loading.loading.loading.loading.loading:after
            -- .ui.loading.loading.loading.loading.loading.loading .input > i.icon:after
            -- .ui.loading.loading.loading.loading.loading.loading > i.icon:after
            -- .ui.loader.loader.loader.loader.loader:after
            , borderLeftColor transparent
            , borderRightColor transparent

            -- .ui.loading.loading.loading.loading.loading.loading.loading:not(.double):after
            -- .ui.loading.loading.loading.loading.loading.loading.loading:not(.double) .input > i.icon:after
            -- .ui.loading.loading.loading.loading.loading.loading.loading:not(.double) > i.icon:after
            -- .ui.loader.loader.loader.loader.loader.loader:not(.double):after
            , borderBottomColor transparent
            ]

        -- Coupling
        , if isDark theme then
            -- White Dimmer (Inverted)
            batch
                [ -- .ui.inverted.dimmer > .ui.loader
                  color (rgba 0 0 0 0.87)

                -- .ui.inverted.dimmer > .ui.loader:not(.elastic):before
                , before
                    [ borderColor (rgba 0 0 0 0.1) ]
                ]

          else
            -- Black Dimmer
            batch
                [ -- .ui.dimmer > .ui.loader
                  color (rgba 255 255 255 0.9)

                -- .ui.dimmer > .ui.loader:not(.elastic):before
                , before
                    [ borderColor (rgba 255 255 255 0.15) ]
                ]

        -- Sizes
        -- .ui.loader
        , width (rem 2.28571429)
        , height (rem 2.28571429)
        , fontSize (em 1)

        -- .ui.loader:before
        -- .ui.loader:after
        , before
            [ width (rem 2.28571429)
            , height (rem 2.28571429)
            , margin4 zero zero zero (rem -1.14285714)
            ]
        , after
            [ width (rem 2.28571429)
            , height (rem 2.28571429)
            , margin4 zero zero zero (rem -1.14285714)
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


loader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
loader options =
    basis options []


textLoader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
textLoader options =
    basis options
        [ -- .ui.ui.ui.ui.text.loader
          width auto
        , height auto
        , textAlign center
        , fontStyle normal

        -- .ui.text.loader
        , minWidth (rem 2.28571429)
        , paddingTop (rem 3.07142857)
        ]
