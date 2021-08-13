module UI.Form exposing
    ( State(..)
    , form
    , fields, twoFields, threeFields
    , field
    , label
    , input, textarea
    )

{-|

@docs State
@docs form
@docs fields, twoFields, threeFields
@docs field
@docs label
@docs input, textarea

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
            [ -- .ui.form ::-webkit-datetime-edit
              -- .ui.form ::-webkit-inner-spin-button
              each
                [ selector "::-webkit-datetime-edit"
                , selector "::-webkit-inner-spin-button"
                ]
                [ height (em 1.21428571) ]

            -- States
            , Css.Global.select
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
        , property "background" "#FFFFFF"
        , border3 (px 1) solid (rgba 34 36 38 0.15)
        , color (rgba 0 0 0 0.87)
        , borderRadius (rem 0.28571429)
        , prefixed [] "box-shadow" "0 0 0 0 transparent inset"
        , property "-webkit-transition" "color 0.1s ease, border-color 0.1s ease"
        , property "transition" "color 0.1s ease, border-color 0.1s ease"

        --
        , focus
            [ color (rgba 0 0 0 0.95)
            , borderColor (hex "#85b7d9")
            , borderRadius (rem 0.28571429)
            , property "background" "#ffffff"
            , prefixed [] "box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.35) inset"
            ]

        -- States
        , colorByState state
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

        -- .ui.form textarea:focus
        , focus
            [ color (rgba 0 0 0 0.95)
            , borderColor (hex "#85b7d9")
            , borderRadius (rem 0.28571429)
            , property "background" "#ffffff"

            -- -webkit-box-shadow: 0 0 0 0 rgba(34, 36, 38, 0.35) inset;
            , prefixed [] "box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.35) inset"
            , property "-webkit-appearance" "none"
            ]

        -- State
        , batch (stylesByState state)
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
            -- .ui.ui.form .fields.success .field .input
            -- .ui.ui.form .field.success .input
            color (hex "#2c662d")

        Info ->
            -- .ui.ui.form .fields.info .field label
            -- .ui.ui.form .fields.info .field .ui.label:not(.corner)
            -- .ui.ui.form .field.info label
            -- .ui.ui.form .field.info .ui.label:not(.corner)
            -- .ui.ui.form .fields.info .field .input
            -- .ui.ui.form .field.info .input
            color (hex "#276f86")

        Warning ->
            -- .ui.ui.form .fields.warning .field label
            -- .ui.ui.form .fields.warning .field .ui.label:not(.corner)
            -- .ui.ui.form .field.warning label
            -- .ui.ui.form .field.warning .ui.label:not(.corner)
            -- .ui.ui.form .fields.warning .field .input
            -- .ui.ui.form .field.warning .input
            color (hex "#573a08")

        Error ->
            -- .ui.ui.form .fields.error .field label
            -- .ui.ui.form .fields.error .field .ui.label:not(.corner)
            -- .ui.ui.form .field.error label
            -- .ui.ui.form .field.error .ui.label:not(.corner)
            -- .ui.ui.form .fields.error .field .input
            -- .ui.ui.form .field.error .input
            color (hex "#9f3a38")

        Default ->
            batch []


stylesByState : State -> List Style
stylesByState state =
    let
        paletteByState =
            batch <|
                case state of
                    Success ->
                        [ property "background" "#fcfff5"
                        , color (hex "#2c662d")
                        , borderColor (hex "#a3c293")
                        ]

                    Info ->
                        [ property "background" "#f8ffff"
                        , color (hex "#276f86")
                        , borderColor (hex "#a9d5de")
                        ]

                    Warning ->
                        [ property "background" "#fffaf3"
                        , color (hex "#573a08")
                        , borderColor (hex "#c9ba9b")
                        ]

                    Error ->
                        [ property "background" "#fff6f6"
                        , color (hex "#9f3a38")
                        , borderColor (hex "#e0b4b4")
                        ]

                    Default ->
                        []
    in
    [ paletteByState
    , property "border-radius" "''"
    , prefixed [] "box-shadow" "none"
    , focus
        [ paletteByState
        , prefixed [] "box-shadow" "none"
        ]
    ]
