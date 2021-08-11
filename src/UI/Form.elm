module UI.Form exposing (field, form, label)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (descendants, each, selector)
import Css.Typography exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html, text)


type FieldType
    = Text String
    | Textarea
    | Checkbox


form : List (Attribute msg) -> List (Html msg) -> Html msg
form =
    Html.styled Html.form
        [ -- .ui.form
          position relative
        , maxWidth (pct 100)
        ]


fieldBasis : List (Attribute msg) -> List (Html msg) -> Html msg
fieldBasis =
    Html.styled Html.div
        [ -- .ui.form .field
          property "clear" "both"
        , margin3 zero zero (em 1)

        -- Standard Inputs
        , descendants
            [ -- .ui.form textarea
              -- .ui.form input:not([type])
              -- .ui.form input[type="date"]
              -- .ui.form input[type="datetime-local"]
              -- .ui.form input[type="email"]
              -- .ui.form input[type="number"]
              -- .ui.form input[type="password"]
              -- .ui.form input[type="search"]
              -- .ui.form input[type="tel"]
              -- .ui.form input[type="time"]
              -- .ui.form input[type="text"]
              -- .ui.form input[type="file"]
              -- .ui.form input[type="url"]
              each
                [ Css.Global.textarea
                , selector """input:not([type])"""
                , selector """input[type="date"]"""
                , selector """input[type="datetime-local"]"""
                , selector """input[type="email"]"""
                , selector """input[type="number"]"""
                , selector """input[type="password"]"""
                , selector """input[type="search"]"""
                , selector """input[type="tel"]"""
                , selector """input[type="time"]"""
                , selector """input[type="text"]"""
                , selector """input[type="file"]"""
                , selector """input[type="url"]"""
                ]
                [ width (pct 100)
                , verticalAlign top
                ]

            -- .ui.form ::-webkit-datetime-edit
            -- .ui.form ::-webkit-inner-spin-button
            , each
                [ selector "::-webkit-datetime-edit"
                , selector "::-webkit-inner-spin-button"
                ]
                [ height (em 1.21428571) ]

            -- .ui.form input:not([type])
            -- .ui.form input[type="date"]
            -- .ui.form input[type="datetime-local"]
            -- .ui.form input[type="email"]
            -- .ui.form input[type="number"]
            -- .ui.form input[type="password"]
            -- .ui.form input[type="search"]
            -- .ui.form input[type="tel"]
            -- .ui.form input[type="time"]
            -- .ui.form input[type="text"]
            -- .ui.form input[type="file"]
            -- .ui.form input[type="url"]
            , each
                [ selector """input:not([type])"""
                , selector """input[type="date"]"""
                , selector """input[type="datetime-local"]"""
                , selector """input[type="email"]"""
                , selector """input[type="number"]"""
                , selector """input[type="password"]"""
                , selector """input[type="search"]"""
                , selector """input[type="tel"]"""
                , selector """input[type="time"]"""
                , selector """input[type="text"]"""
                , selector """input[type="file"]"""
                , selector """input[type="url"]"""
                ]
                [ fontFamilies fomanticFontFamilies
                , margin zero
                , outline none
                , property "-webkit-appearance" "none"
                , property "-webkit-tap-highlight-color" "rgba(255, 255, 255, 0)"
                , lineHeight (em 1.21428571)
                , padding2 (em 0.67857143) (em 1)
                , fontSize (em 1)
                , property "background" "#FFFFFF"
                , border3 (px 1) solid (rgba 34 36 38 0.15)
                , color (rgba 0 0 0 0.87)
                , borderRadius (rem 0.28571429)
                , prefixed [] "box-shadow" "0 0 0 0 transparent inset"
                , property "-webkit-transition" "color 0.1s ease, border-color 0.1s ease"
                , property "transition" "color 0.1s ease, border-color 0.1s ease"
                ]
            ]

        -- Text Area
        , descendants
            [ -- .ui.input textarea
              -- .ui.form textarea
              Css.Global.textarea
                [ margin zero
                , property "-webkit-appearance" "none"
                , property "-webkit-tap-highlight-color" "rgba(255, 255, 255, 0)"
                , padding2 (em 0.78571429) (em 1)
                , property "background" "#FFFFFF"
                , border3 (px 1) solid (rgba 34 36 38 0.15)
                , outline none
                , color (rgba 0 0 0 0.87)
                , borderRadius (rem 0.28571429)
                , prefixed [] "box-shadow" "0 0 0 0 transparent inset"
                , property "-webkit-transition" "color 0.1s ease, border-color 0.1s ease"
                , property "transition" "color 0.1s ease, border-color 0.1s ease"
                , fontSize (em 1)
                , fontFamilies fomanticFontFamilies
                , lineHeight (num 1.2857)
                , resize vertical

                -- .ui.form textarea:not([rows])
                , pseudoClass "not([rows])"
                    [ height (em 12)
                    , minHeight (em 8)
                    , maxHeight (em 24)
                    ]

                -- .ui.form textarea
                -- .ui.form input[type="checkbox"]
                , verticalAlign top
                ]
            ]
        ]


field : { type_ : String, label : String } -> List (Attribute msg) -> List (Html msg) -> Html msg
field options attributes children =
    let
        fieldType =
            fromString options.type_

        label_ =
            case options.label of
                "" ->
                    text ""

                _ ->
                    label [] [ text options.label ]
    in
    fieldBasis attributes
        (label_ :: children)


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    Html.styled Html.label
        [ -- .ui.form .field > label
          display block
        , margin4 zero zero (rem 0.28571429) zero
        , color (rgba 0 0 0 0.87)
        , fontSize (em 0.92857143)
        , fontWeight bold
        , textTransform none
        ]


fromString : String -> FieldType
fromString type_ =
    case type_ of
        "textarea" ->
            Textarea

        "checkbox" ->
            Checkbox

        _ ->
            Text type_
