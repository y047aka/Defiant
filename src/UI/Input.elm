module UI.Input exposing (input, label)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (adjacentSiblings, children)
import Css.Palette as Palette exposing (palette, paletteWith, setBackground, setBorder, setColor)
import Css.Typography as Typography exposing (setFontStyle, setFontWeight, setLineHeight, typography)
import Html.Styled as Html exposing (Attribute, Html)
import UI.Label as Label


input : List (Attribute msg) -> List (Html msg) -> Html msg
input =
    Html.styled Html.div
        [ -- .ui.input
          position relative
        , typography
            (Typography.init
                |> setFontStyle normal
                |> setFontWeight normal
            )
        , prefixed [] "display" "inline-flex"
        , color (rgba 0 0 0 0.87)

        -- .ui.input > input
        , children
            [ Css.Global.input
                [ margin zero
                , maxWidth (pct 100)
                , prefixed [] "flex" "1 0 auto"
                , outline none
                , property "-webkit-tap-highlight-color" "rgba(255, 255, 255, 0)"
                , textAlign left
                , typography (Typography.default |> setLineHeight (em 1.21428571))
                , padding2 (em 0.67857143) (em 1)
                , paletteWith { border = border3 (px 1) solid }
                    (Palette.init
                        |> setBackground (hex "#FFFFFF")
                        |> setColor (rgba 0 0 0 0.87)
                        |> setBorder (rgba 34 36 38 0.15)
                    )
                , borderRadius (rem 0.28571429)
                , property "-webkit-transition" "border-color 0.1s ease, -webkit-box-shadow 0.1s ease"
                , property "transition" "border-color 0.1s ease, -webkit-box-shadow 0.1s ease"
                , property "transition" "box-shadow 0.1s ease, border-color 0.1s ease"
                , property "transition" "box-shadow 0.1s ease, border-color 0.1s ease, -webkit-box-shadow 0.1s ease"
                , prefixed [] "box-shadow" "none"

                -- .ui.input > input::-webkit-input-placeholder
                , pseudoElement "-webkit-input-placeholder"
                    [ color (rgba 191 191 191 0.87) ]

                -- .ui.input > input::-moz-placeholder
                , pseudoElement "-moz-placeholder"
                    [ color (rgba 191 191 191 0.87) ]

                -- .ui.input > input:-ms-input-placeholder
                , pseudoClass "-ms-input-placeholder"
                    [ color (rgba 191 191 191 0.87) ]

                -- .ui.input > input:active
                -- .ui.input.down input
                , active
                    [ palette
                        (Palette.init
                            |> setBackground (hex "#FAFAFA")
                            |> setColor (rgba 0 0 0 0.87)
                            |> setBorder (rgba 0 0 0 0.3)
                        )
                    , prefixed [] "box-shadow" "none"
                    ]

                -- .ui.input.focus > input
                -- .ui.input > input:focus
                , focus
                    [ palette
                        (Palette.init
                            |> setBackground (hex "#FFFFFF")
                            |> setColor (rgba 0 0 0 0.8)
                            |> setBorder (hex "#85B7D9")
                        )
                    , prefixed [] "box-shadow" "none"

                    -- .ui.input.focus > input::-webkit-input-placeholder
                    -- .ui.input > input:focus::-webkit-input-placeholder
                    , pseudoElement "-webkit-input-placeholder"
                        [ color (rgba 115 115 115 0.87) ]

                    -- .ui.input.focus > input::-moz-placeholder
                    -- .ui.input > input:focus::-moz-placeholder
                    , pseudoElement "-moz-placeholder"
                        [ color (rgba 115 115 115 0.87) ]

                    -- .ui.input.focus > input:-ms-input-placeholder
                    -- .ui.input > input:focus:-ms-input-placeholder
                    , pseudoClass "-ms-input-placeholder"
                        [ color (rgba 115 115 115 0.87) ]
                    ]
                ]
            ]
        ]


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    Html.styled Label.label
        [ -- .ui.labeled.input > .label
          prefixed [] "flex" "0 0 auto"
        , margin zero
        , fontSize (em 1)

        -- .ui.labeled.input > .label:not(.corner)
        , paddingTop (em 0.78571429)
        , paddingBottom (em 0.78571429)

        -- Regular Label on Left
        , firstChild
            [ -- .ui.labeled.input:not([class*="corner labeled"]) .label:first-child
              borderTopRightRadius zero
            , borderBottomRightRadius zero

            -- .ui.labeled.input:not([class*="corner labeled"]) .label:first-child + input
            , adjacentSiblings
                [ Css.Global.input
                    [ borderTopLeftRadius zero
                    , borderBottomLeftRadius zero
                    , borderLeftColor transparent

                    -- .ui.labeled.input:not([class*="corner labeled"]) .label:first-child + input:focus
                    , focus
                        [ borderLeftColor (hex "#85B7D9") ]
                    ]
                ]
            ]

        -- Regular Label on Right
        , nthChild "n+2"
            [ -- .ui[class*="right labeled"].input > input + .label
              borderTopLeftRadius zero
            , borderBottomLeftRadius zero
            ]
        ]
