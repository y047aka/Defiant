module UI.Form exposing
    ( State(..)
    , form
    , fields, twoFields, threeFields
    , field
    , label
    )

{-|

@docs State
@docs form
@docs fields, twoFields, threeFields
@docs field
@docs label

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, descendants, each, selector)
import Css.Media as Media exposing (only, screen, withMedia)
import Css.Typography exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html, text)


type FieldType
    = Text String
    | Textarea
    | Checkbox


type State
    = Default
    | Success
    | Info
    | Warning
    | Error


form : List (Attribute msg) -> List (Html msg) -> Html msg
form =
    Html.styled Html.form
        [ -- .ui.form
          position relative
        , maxWidth (pct 100)
        ]


fieldsBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
fieldsBasis additionalStyles =
    Html.styled Html.div
        [ -- .ui.form .fields
          prefixed [] "display" "flex"
        , property "-webkit-box-orient" "horizontal"
        , property "-webkit-box-direction" "normal"
        , prefixed [] "flex-direction" "row"
        , margin3 zero (em -0.5) (em 1)

        -- .ui.form .fields > .field
        , children
            [ Css.Global.div
                [ prefixed [] "flex" "0 1 auto"
                , paddingLeft (em 0.5)
                , paddingRight (em 0.5)

                -- .ui.form .fields > .field:first-child
                , firstChild
                    [ property "border-left" "none"
                    , prefixed [] "box-shadow" "none"
                    ]
                ]
            ]

        -- @media only screen and (max-width: 767.98px)
        , withMedia [ only screen [ Media.maxWidth (px 767.98) ] ]
            [ -- .ui.form .fields
              prefixed [] "flex-wrap" "wrap"
            , marginBottom zero

            -- .ui.form:not(.unstackable) .fields:not(.unstackable) > .fields
            -- .ui.form:not(.unstackable) .fields:not(.unstackable) > .field
            , children
                [ Css.Global.div
                    [ width (pct 100)
                    , margin3 zero zero (em 1)
                    ]
                ]
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


fields : List (Attribute msg) -> List (Html msg) -> Html msg
fields =
    fieldsBasis []


equallyDivideFields : Int -> List (Attribute msg) -> List (Html msg) -> Html msg
equallyDivideFields count =
    fieldsBasis
        [ children
            [ Css.Global.div <|
                case count of
                    2 ->
                        -- .ui.form .two.fields > .fields
                        -- .ui.form .two.fields > .field
                        [ width (pct 50) ]

                    3 ->
                        -- .ui.form .three.fields > .fields
                        -- .ui.form .three.fields > .field
                        [ width (pct 33.33333333) ]

                    _ ->
                        []
            ]
        ]


twoFields : List (Attribute msg) -> List (Html msg) -> Html msg
twoFields =
    equallyDivideFields 2


threeFields : List (Attribute msg) -> List (Html msg) -> Html msg
threeFields =
    equallyDivideFields 3


fieldBasis : State -> List (Attribute msg) -> List (Html msg) -> Html msg
fieldBasis state =
    Html.styled Html.div
        [ -- .ui.form .field
          property "clear" "both"
        , margin3 zero zero (em 1)

        --
        , descendants
            [ -- Standard Inputs
              -- .ui.form textarea
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

            -- Text Area
            -- .ui.input textarea
            -- .ui.form textarea
            , Css.Global.textarea
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

            -- Focus
            -- .ui.form input:not([type]):focus
            -- .ui.form input[type='date']:focus
            -- .ui.form input[type='datetime-local']:focus
            -- .ui.form input[type='email']:focus
            -- .ui.form input[type='number']:focus
            -- .ui.form input[type='password']:focus
            -- .ui.form input[type='search']:focus
            -- .ui.form input[type='tel']:focus
            -- .ui.form input[type='time']:focus
            -- .ui.form input[type='text']:focus
            -- .ui.form input[type='file']:focus
            -- .ui.form input[type='url']:focus
            , each
                [ selector "input:not([type]):focus"
                , selector "input[type='date']:focus"
                , selector "input[type='datetime-local']:focus"
                , selector "input[type='email']:focus"
                , selector "input[type='number']:focus"
                , selector "input[type='password']:focus"
                , selector "input[type='search']:focus"
                , selector "input[type='tel']:focus"
                , selector "input[type='time']:focus"
                , selector "input[type='text']:focus"
                , selector "input[type='file']:focus"
                , selector "input[type='url']:focus"
                ]
                [ color (rgba 0 0 0 0.95)
                , borderColor (hex "#85b7d9")
                , borderRadius (rem 0.28571429)
                , property "background" "#ffffff"
                , prefixed [] "box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.35) inset"
                ]

            -- .ui.form textarea:focus
            , each [ selector "textarea:focus" ]
                [ color (rgba 0 0 0 0.95)
                , borderColor (hex "#85b7d9")
                , borderRadius (rem 0.28571429)
                , property "background" "#ffffff"

                -- -webkit-box-shadow: 0 0 0 0 rgba(34, 36, 38, 0.35) inset;
                , prefixed [] "box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.35) inset"
                , property "-webkit-appearance" "none"
                ]

            -- States
            , each
                [ Css.Global.label
                , Css.Global.input
                ]
                (case state of
                    Success ->
                        -- .ui.ui.form .fields.success .field label
                        -- .ui.ui.form .fields.success .field .ui.label:not(.corner)
                        -- .ui.ui.form .field.success label
                        -- .ui.ui.form .field.success .ui.label:not(.corner)
                        -- .ui.ui.form .fields.success .field .input
                        -- .ui.ui.form .field.success .input
                        [ color (hex "#2c662d") ]

                    Info ->
                        -- .ui.ui.form .fields.info .field label
                        -- .ui.ui.form .fields.info .field .ui.label:not(.corner)
                        -- .ui.ui.form .field.info label
                        -- .ui.ui.form .field.info .ui.label:not(.corner)
                        -- .ui.ui.form .fields.info .field .input
                        -- .ui.ui.form .field.info .input
                        [ color (hex "#276f86") ]

                    Warning ->
                        -- .ui.ui.form .fields.warning .field label
                        -- .ui.ui.form .fields.warning .field .ui.label:not(.corner)
                        -- .ui.ui.form .field.warning label
                        -- .ui.ui.form .field.warning .ui.label:not(.corner)
                        -- .ui.ui.form .fields.warning .field .input
                        -- .ui.ui.form .field.warning .input
                        [ color (hex "#573a08") ]

                    Error ->
                        -- .ui.ui.form .fields.error .field label
                        -- .ui.ui.form .fields.error .field .ui.label:not(.corner)
                        -- .ui.ui.form .field.error label
                        -- .ui.ui.form .field.error .ui.label:not(.corner)
                        -- .ui.ui.form .fields.error .field .input
                        -- .ui.ui.form .field.error .input
                        [ color (hex "#9f3a38") ]

                    Default ->
                        []
                )
            , each
                [ Css.Global.textarea
                , Css.Global.select
                , selector "input:not([type])"
                , selector "input[type='date']"
                , selector "input[type='datetime-local']"
                , selector "input[type='email']"
                , selector "input[type='number']"
                , selector "input[type='password']"
                , selector "input[type='search']"
                , selector "input[type='tel']"
                , selector "input[type='time']"
                , selector "input[type='text']"
                , selector "input[type='file']"
                , selector "input[type='url']"
                ]
                (case state of
                    Success ->
                        -- .ui.form .fields.success .field textarea
                        -- .ui.form .fields.success .field select
                        -- .ui.form .fields.success .field input:not([type])
                        -- .ui.form .fields.success .field input[type='date']
                        -- .ui.form .fields.success .field input[type='datetime-local']
                        -- .ui.form .fields.success .field input[type='email']
                        -- .ui.form .fields.success .field input[type='number']
                        -- .ui.form .fields.success .field input[type='password']
                        -- .ui.form .fields.success .field input[type='search']
                        -- .ui.form .fields.success .field input[type='tel']
                        -- .ui.form .fields.success .field input[type='time']
                        -- .ui.form .fields.success .field input[type='text']
                        -- .ui.form .fields.success .field input[type='file']
                        -- .ui.form .fields.success .field input[type='url']
                        -- .ui.form .field.success textarea
                        -- .ui.form .field.success select
                        -- .ui.form .field.success input:not([type])
                        -- .ui.form .field.success input[type='date']
                        -- .ui.form .field.success input[type='datetime-local']
                        -- .ui.form .field.success input[type='email']
                        -- .ui.form .field.success input[type='number']
                        -- .ui.form .field.success input[type='password']
                        -- .ui.form .field.success input[type='search']
                        -- .ui.form .field.success input[type='tel']
                        -- .ui.form .field.success input[type='time']
                        -- .ui.form .field.success input[type='text']
                        -- .ui.form .field.success input[type='file']
                        -- .ui.form .field.success input[type='url']
                        [ color (hex "#2c662d")
                        , property "background" "#fcfff5"
                        , borderColor (hex "#a3c293")
                        , property "border-radius" "''"
                        , prefixed [] "box-shadow" "none"
                        ]

                    Info ->
                        -- .ui.form .fields.info .field textarea
                        -- .ui.form .fields.info .field select
                        -- .ui.form .fields.info .field input:not([type])
                        -- .ui.form .fields.info .field input[type='date']
                        -- .ui.form .fields.info .field input[type='datetime-local']
                        -- .ui.form .fields.info .field input[type='email']
                        -- .ui.form .fields.info .field input[type='number']
                        -- .ui.form .fields.info .field input[type='password']
                        -- .ui.form .fields.info .field input[type='search']
                        -- .ui.form .fields.info .field input[type='tel']
                        -- .ui.form .fields.info .field input[type='time']
                        -- .ui.form .fields.info .field input[type='text']
                        -- .ui.form .fields.info .field input[type='file']
                        -- .ui.form .fields.info .field input[type='url']
                        -- .ui.form .field.info textarea
                        -- .ui.form .field.info select
                        -- .ui.form .field.info input:not([type])
                        -- .ui.form .field.info input[type='date']
                        -- .ui.form .field.info input[type='datetime-local']
                        -- .ui.form .field.info input[type='email']
                        -- .ui.form .field.info input[type='number']
                        -- .ui.form .field.info input[type='password']
                        -- .ui.form .field.info input[type='search']
                        -- .ui.form .field.info input[type='tel']
                        -- .ui.form .field.info input[type='time']
                        -- .ui.form .field.info input[type='text']
                        -- .ui.form .field.info input[type='file']
                        -- .ui.form .field.info input[type='url']
                        [ color (hex "#276f86")
                        , property "background" "#f8ffff"
                        , borderColor (hex "#a9d5de")
                        , property "border-radius" "''"
                        , prefixed [] "box-shadow" "none"
                        ]

                    Warning ->
                        -- .ui.form .fields.warning .field textarea
                        -- .ui.form .fields.warning .field select
                        -- .ui.form .fields.warning .field input:not([type])
                        -- .ui.form .fields.warning .field input[type='date']
                        -- .ui.form .fields.warning .field input[type='datetime-local']
                        -- .ui.form .fields.warning .field input[type='email']
                        -- .ui.form .fields.warning .field input[type='number']
                        -- .ui.form .fields.warning .field input[type='password']
                        -- .ui.form .fields.warning .field input[type='search']
                        -- .ui.form .fields.warning .field input[type='tel']
                        -- .ui.form .fields.warning .field input[type='time']
                        -- .ui.form .fields.warning .field input[type='text']
                        -- .ui.form .fields.warning .field input[type='file']
                        -- .ui.form .fields.warning .field input[type='url']
                        -- .ui.form .field.warning textarea
                        -- .ui.form .field.warning select
                        -- .ui.form .field.warning input:not([type])
                        -- .ui.form .field.warning input[type='date']
                        -- .ui.form .field.warning input[type='datetime-local']
                        -- .ui.form .field.warning input[type='email']
                        -- .ui.form .field.warning input[type='number']
                        -- .ui.form .field.warning input[type='password']
                        -- .ui.form .field.warning input[type='search']
                        -- .ui.form .field.warning input[type='tel']
                        -- .ui.form .field.warning input[type='time']
                        -- .ui.form .field.warning input[type='text']
                        -- .ui.form .field.warning input[type='file']
                        -- .ui.form .field.warning input[type='url']
                        [ color (hex "#573a08")
                        , property "background" "#fffaf3"
                        , borderColor (hex "#c9ba9b")
                        , property "border-radius" "''"
                        , prefixed [] "box-shadow" "none"
                        ]

                    Error ->
                        -- .ui.form .fields.error .field textarea
                        -- .ui.form .fields.error .field select
                        -- .ui.form .fields.error .field input:not([type])
                        -- .ui.form .fields.error .field input[type='date']
                        -- .ui.form .fields.error .field input[type='datetime-local']
                        -- .ui.form .fields.error .field input[type='email']
                        -- .ui.form .fields.error .field input[type='number']
                        -- .ui.form .fields.error .field input[type='password']
                        -- .ui.form .fields.error .field input[type='search']
                        -- .ui.form .fields.error .field input[type='tel']
                        -- .ui.form .fields.error .field input[type='time']
                        -- .ui.form .fields.error .field input[type='text']
                        -- .ui.form .fields.error .field input[type='file']
                        -- .ui.form .fields.error .field input[type='url']
                        -- .ui.form .field.error textarea
                        -- .ui.form .field.error select
                        -- .ui.form .field.error input:not([type])
                        -- .ui.form .field.error input[type='date']
                        -- .ui.form .field.error input[type='datetime-local']
                        -- .ui.form .field.error input[type='email']
                        -- .ui.form .field.error input[type='number']
                        -- .ui.form .field.error input[type='password']
                        -- .ui.form .field.error input[type='search']
                        -- .ui.form .field.error input[type='tel']
                        -- .ui.form .field.error input[type='time']
                        -- .ui.form .field.error input[type='text']
                        -- .ui.form .field.error input[type='file']
                        -- .ui.form .field.error input[type='url']
                        [ color (hex "#9f3a38")
                        , property "background" "#fff6f6"
                        , borderColor (hex "#e0b4b4")
                        , property "border-radius" "''"
                        , prefixed [] "box-shadow" "none"
                        ]

                    Default ->
                        []
                )
            , each
                [ Css.Global.textarea
                , Css.Global.select
                , selector "input:not([type])"
                , selector "input[type='date']"
                , selector "input[type='datetime-local']"
                , selector "input[type='email']"
                , selector "input[type='number']"
                , selector "input[type='password']"
                , selector "input[type='search']"
                , selector "input[type='tel']"
                , selector "input[type='time']"
                , selector "input[type='text']"
                , selector "input[type='file']"
                , selector "input[type='url']"
                ]
                [ focus
                    (case state of
                        Success ->
                            -- .ui.form .field.success textarea:focus
                            -- .ui.form .field.success select:focus
                            -- .ui.form .field.success input:not([type]):focus
                            -- .ui.form .field.success input[type='date']:focus
                            -- .ui.form .field.success input[type='datetime-local']:focus
                            -- .ui.form .field.success input[type='email']:focus
                            -- .ui.form .field.success input[type='number']:focus
                            -- .ui.form .field.success input[type='password']:focus
                            -- .ui.form .field.success input[type='search']:focus
                            -- .ui.form .field.success input[type='tel']:focus
                            -- .ui.form .field.success input[type='time']:focus
                            -- .ui.form .field.success input[type='text']:focus
                            -- .ui.form .field.success input[type='file']:focus
                            -- .ui.form .field.success input[type='url']:focus
                            [ property "background" "#fcfff5"
                            , borderColor (hex "#a3c293")
                            , color (hex "#2c662d")
                            , prefixed [] "box-shadow" "none"
                            ]

                        Info ->
                            -- .ui.form .field.info textarea:focus
                            -- .ui.form .field.info select:focus
                            -- .ui.form .field.info input:not([type]):focus
                            -- .ui.form .field.info input[type='date']:focus
                            -- .ui.form .field.info input[type='datetime-local']:focus
                            -- .ui.form .field.info input[type='email']:focus
                            -- .ui.form .field.info input[type='number']:focus
                            -- .ui.form .field.info input[type='password']:focus
                            -- .ui.form .field.info input[type='search']:focus
                            -- .ui.form .field.info input[type='tel']:focus
                            -- .ui.form .field.info input[type='time']:focus
                            -- .ui.form .field.info input[type='text']:focus
                            -- .ui.form .field.info input[type='file']:focus
                            -- .ui.form .field.info input[type='url']:focus
                            [ property "background" "#f8ffff"
                            , borderColor (hex "#a9d5de")
                            , color (hex "#276f86")
                            , prefixed [] "box-shadow" "none"
                            ]

                        Warning ->
                            -- .ui.form .field.warning textarea:focus
                            -- .ui.form .field.warning select:focus
                            -- .ui.form .field.warning input:not([type]):focus
                            -- .ui.form .field.warning input[type='date']:focus
                            -- .ui.form .field.warning input[type='datetime-local']:focus
                            -- .ui.form .field.warning input[type='email']:focus
                            -- .ui.form .field.warning input[type='number']:focus
                            -- .ui.form .field.warning input[type='password']:focus
                            -- .ui.form .field.warning input[type='search']:focus
                            -- .ui.form .field.warning input[type='tel']:focus
                            -- .ui.form .field.warning input[type='time']:focus
                            -- .ui.form .field.warning input[type='text']:focus
                            -- .ui.form .field.warning input[type='file']:focus
                            -- .ui.form .field.warning input[type='url']:focus
                            [ property "background" "#fffaf3"
                            , borderColor (hex "#c9ba9b")
                            , color (hex "#573a08")
                            , prefixed [] "box-shadow" "none"
                            ]

                        Error ->
                            -- .ui.form .field.error textarea:focus
                            -- .ui.form .field.error select:focus
                            -- .ui.form .field.error input:not([type]):focus
                            -- .ui.form .field.error input[type='date']:focus
                            -- .ui.form .field.error input[type='datetime-local']:focus
                            -- .ui.form .field.error input[type='email']:focus
                            -- .ui.form .field.error input[type='number']:focus
                            -- .ui.form .field.error input[type='password']:focus
                            -- .ui.form .field.error input[type='search']:focus
                            -- .ui.form .field.error input[type='tel']:focus
                            -- .ui.form .field.error input[type='time']:focus
                            -- .ui.form .field.error input[type='text']:focus
                            -- .ui.form .field.error input[type='file']:focus
                            -- .ui.form .field.error input[type='url']:focus
                            [ property "background" "#fff6f6"
                            , borderColor (hex "#e0b4b4")
                            , color (hex "#9f3a38")
                            , prefixed [] "box-shadow" "none"
                            ]

                        Default ->
                            []
                    )
                ]
            ]
        ]


field : { type_ : String, label : String, state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
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
    fieldBasis options.state
        attributes
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
