module UI.Form exposing
    ( State(..)
    , form
    , fields, twoFields, threeFields
    , field
    , label
    , input, textarea
    , checkboxLabel
    )

{-|

@docs State
@docs form
@docs fields, twoFields, threeFields
@docs field
@docs label
@docs input, textarea
@docs checkboxLabel

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, descendants, each, selector)
import Css.Media as Media exposing (only, screen, withMedia)
import Css.Palette as Palette exposing (palette, paletteWith, setBackground, setBorder, setColor)
import Css.Typography exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html, text)
import UI.Checkbox


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

        -- .ui.form ::-webkit-datetime-edit
        -- .ui.form ::-webkit-inner-spin-button
        , descendants
            [ each
                [ selector "::-webkit-datetime-edit"
                , selector "::-webkit-inner-spin-button"
                ]
                [ height (em 1.21428571) ]
            ]
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

        -- States
        , descendants
            [ Css.Global.select
                (stylesByState state)
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
                    label { state = options.state } [] [ text options.label ]
    in
    fieldBasis options.state
        attributes
        (label_ :: children)


label : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
label { state } =
    Html.styled Html.label
        [ -- .ui.form .field > label
          display block
        , margin4 zero zero (rem 0.28571429) zero
        , color (rgba 0 0 0 0.87)
        , fontSize (em 0.92857143)
        , fontWeight bold
        , textTransform none

        -- State
        , colorByState state
        ]


input : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
input { state } =
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
    Html.styled Html.input
        [ width (pct 100)
        , verticalAlign top

        --
        , fontFamilies fomanticFontFamilies
        , margin zero
        , outline none
        , property "-webkit-appearance" "none"
        , property "-webkit-tap-highlight-color" "rgba(255, 255, 255, 0)"
        , lineHeight (em 1.21428571)
        , padding2 (em 0.67857143) (em 1)
        , fontSize (em 1)
        , paletteWith
            { border = border3 (px 1) solid
            , shadow = prefixed [] "box-shadow" "0 0 0 0 transparent inset"
            }
            (Palette.init
                |> setBackground (hex "#FFFFFF")
                |> setColor (rgba 0 0 0 0.87)
                |> setBorder (rgba 34 36 38 0.15)
            )
        , borderRadius (rem 0.28571429)
        , property "-webkit-transition" "color 0.1s ease, border-color 0.1s ease"
        , property "transition" "color 0.1s ease, border-color 0.1s ease"

        --
        , focus
            [ borderRadius (rem 0.28571429)
            , paletteWith { border = borderColor, shadow = prefixed [] "box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.35) inset" }
                (Palette.init
                    |> setBackground (hex "#ffffff")
                    |> setColor (rgba 0 0 0 0.95)
                    |> setBorder (hex "#85b7d9")
                )
            ]

        -- States
        , batch (stylesByState state)
        ]


textarea : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
textarea { state } =
    Html.styled Html.textarea
        [ -- .ui.form textarea
          width (pct 100)
        , verticalAlign top

        -- .ui.input textarea
        -- .ui.form textarea
        , margin zero
        , property "-webkit-appearance" "none"
        , property "-webkit-tap-highlight-color" "rgba(255, 255, 255, 0)"
        , padding2 (em 0.78571429) (em 1)
        , paletteWith
            { border = border3 (px 1) solid
            , shadow = prefixed [] "box-shadow" "0 0 0 0 transparent inset"
            }
            (Palette.init
                |> setBackground (hex "#FFFFFF")
                |> setColor (rgba 0 0 0 0.87)
                |> setBorder (rgba 34 36 38 0.15)
            )
        , outline none
        , borderRadius (rem 0.28571429)
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

        -- .ui.form textarea:focus
        , focus
            [ paletteWith { border = borderColor, shadow = prefixed [] "box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.35) inset" }
                (Palette.init
                    |> setBackground (hex "#ffffff")
                    |> setColor (rgba 0 0 0 0.95)
                    |> setBorder (hex "#85b7d9")
                )
            , borderRadius (rem 0.28571429)
            , property "-webkit-appearance" "none"
            ]

        -- State
        , batch (stylesByState state)
        ]


checkboxLabel : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
checkboxLabel { state } =
    UI.Checkbox.labelBasis
        [ case state of
            Success ->
                -- .ui.form .fields.success .field .checkbox:not(.toggle):not(.slider) label
                -- .ui.form .field.success .checkbox:not(.toggle):not(.slider) label
                -- .ui.form .fields.success .field .checkbox:not(.toggle):not(.slider) .box
                -- .ui.form .field.success .checkbox:not(.toggle):not(.slider) .box
                color (hex "#2c662d")

            Info ->
                -- .ui.form .fields.info .field .checkbox:not(.toggle):not(.slider) label
                -- .ui.form .field.info .checkbox:not(.toggle):not(.slider) label
                -- .ui.form .fields.info .field .checkbox:not(.toggle):not(.slider) .box
                -- .ui.form .field.info .checkbox:not(.toggle):not(.slider) .box
                color (hex "#276f86")

            Warning ->
                -- .ui.form .fields.warning .field .checkbox:not(.toggle):not(.slider) label
                -- .ui.form .field.warning .checkbox:not(.toggle):not(.slider) label
                -- .ui.form .fields.warning .field .checkbox:not(.toggle):not(.slider) .box
                -- .ui.form .field.warning .checkbox:not(.toggle):not(.slider) .box
                color (hex "#573a08")

            Error ->
                -- .ui.form .fields.error .field .checkbox:not(.toggle):not(.slider) label
                -- .ui.form .field.error .checkbox:not(.toggle):not(.slider) label
                -- .ui.form .fields.error .field .checkbox:not(.toggle):not(.slider) .box
                -- .ui.form .field.error .checkbox:not(.toggle):not(.slider) .box
                color (hex "#9f3a38")

            Default ->
                batch []

        --
        , before
            [ case state of
                Success ->
                    -- .ui.form .fields.success .field .checkbox:not(.toggle):not(.slider) label:before
                    -- .ui.form .field.success .checkbox:not(.toggle):not(.slider) label:before
                    -- .ui.form .fields.success .field .checkbox:not(.toggle):not(.slider) .box:before
                    -- .ui.form .field.success .checkbox:not(.toggle):not(.slider) .box:before
                    palette
                        (Palette.init
                            |> setBackground (hex "#fcfff5")
                            |> setBorder (hex "#a3c293")
                        )

                Info ->
                    -- .ui.form .fields.info .field .checkbox:not(.toggle):not(.slider) label:before
                    -- .ui.form .field.info .checkbox:not(.toggle):not(.slider) label:before
                    -- .ui.form .fields.info .field .checkbox:not(.toggle):not(.slider) .box:before
                    -- .ui.form .field.info .checkbox:not(.toggle):not(.slider) .box:before
                    palette
                        (Palette.init
                            |> setBackground (hex "#f8ffff")
                            |> setBorder (hex "#a9d5de")
                        )

                Warning ->
                    -- .ui.form .fields.warning .field .checkbox:not(.toggle):not(.slider) label:before
                    -- .ui.form .field.warning .checkbox:not(.toggle):not(.slider) label:before
                    -- .ui.form .fields.warning .field .checkbox:not(.toggle):not(.slider) .box:before
                    -- .ui.form .field.warning .checkbox:not(.toggle):not(.slider) .box:before
                    palette
                        (Palette.init
                            |> setBackground (hex "#fffaf3")
                            |> setBorder (hex "#c9ba9b")
                        )

                Error ->
                    -- .ui.form .fields.error .field .checkbox:not(.toggle):not(.slider) label:before
                    -- .ui.form .field.error .checkbox:not(.toggle):not(.slider) label:before
                    -- .ui.form .fields.error .field .checkbox:not(.toggle):not(.slider) .box:before
                    -- .ui.form .field.error .checkbox:not(.toggle):not(.slider) .box:before
                    palette
                        (Palette.init
                            |> setBackground (hex "#fff6f6")
                            |> setBorder (hex "#e0b4b4")
                        )

                _ ->
                    batch []
            ]

        --
        , after
            [ case state of
                Success ->
                    -- .ui.form .fields.success .field .checkbox label:after
                    -- .ui.form .field.success .checkbox label:after
                    -- .ui.form .fields.success .field .checkbox .box:after
                    -- .ui.form .field.success .checkbox .box:after
                    color (hex "#2c662d")

                Info ->
                    -- .ui.form .fields.info .field .checkbox label:after
                    -- .ui.form .field.info .checkbox label:after
                    -- .ui.form .fields.info .field .checkbox .box:after
                    -- .ui.form .field.info .checkbox .box:after
                    color (hex "#276f86")

                Warning ->
                    -- .ui.form .fields.warning .field .checkbox label:after
                    -- .ui.form .field.warning .checkbox label:after
                    -- .ui.form .fields.warning .field .checkbox .box:after
                    -- .ui.form .field.warning .checkbox .box:after
                    color (hex "#573a08")

                Error ->
                    -- .ui.form .fields.error .field .checkbox label:after
                    -- .ui.form .field.error .checkbox label:after
                    -- .ui.form .fields.error .field .checkbox .box:after
                    -- .ui.form .field.error .checkbox .box:after
                    color (hex "#9f3a38")

                _ ->
                    batch []
            ]
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


colorByState : State -> Style
colorByState state =
    case state of
        Success ->
            -- .ui.ui.form .fields.success .field label
            -- .ui.ui.form .fields.success .field .ui.label:not(.corner)
            -- .ui.ui.form .field.success label
            -- .ui.ui.form .field.success .ui.label:not(.corner)
            color (hex "#2c662d")

        Info ->
            -- .ui.ui.form .fields.info .field label
            -- .ui.ui.form .fields.info .field .ui.label:not(.corner)
            -- .ui.ui.form .field.info label
            -- .ui.ui.form .field.info .ui.label:not(.corner)
            color (hex "#276f86")

        Warning ->
            -- .ui.ui.form .fields.warning .field label
            -- .ui.ui.form .fields.warning .field .ui.label:not(.corner)
            -- .ui.ui.form .field.warning label
            -- .ui.ui.form .field.warning .ui.label:not(.corner)
            color (hex "#573a08")

        Error ->
            -- .ui.ui.form .fields.error .field label
            -- .ui.ui.form .fields.error .field .ui.label:not(.corner)
            -- .ui.ui.form .field.error label
            -- .ui.ui.form .field.error .ui.label:not(.corner)
            color (hex "#9f3a38")

        Default ->
            batch []


stylesByState : State -> List Style
stylesByState state =
    let
        paletteByState =
            case state of
                Success ->
                    palette
                        { background = Just (hex "#fcfff5")
                        , color = Just (hex "#2c662d")
                        , border = Just (hex "#a3c293")
                        }

                Info ->
                    palette
                        { background = Just (hex "#f8ffff")
                        , color = Just (hex "#276f86")
                        , border = Just (hex "#a9d5de")
                        }

                Warning ->
                    palette
                        { background = Just (hex "#fffaf3")
                        , color = Just (hex "#573a08")
                        , border = Just (hex "#c9ba9b")
                        }

                Error ->
                    palette
                        { background = Just (hex "#fff6f6")
                        , color = Just (hex "#9f3a38")
                        , border = Just (hex "#e0b4b4")
                        }

                Default ->
                    batch []
    in
    [ paletteByState
    , property "border-radius" "''"
    , prefixed [] "box-shadow" "none"
    , focus
        [ paletteByState
        , prefixed [] "box-shadow" "none"
        ]
    ]
