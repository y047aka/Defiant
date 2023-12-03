module UI.Form exposing
    ( form
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
import Css.Palette as Palette exposing (palette, paletteWithBorder, setBackground, setBorder, setColor)
import Css.Typography as Typography exposing (setFontSize, setFontWeight, setLineHeight, setTextTransform, typography)
import Html.Styled as Html exposing (Attribute, Html, text)
import Types exposing (FormState(..))


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


fieldBasis : FormState -> List (Attribute msg) -> List (Html msg) -> Html msg
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


field : { type_ : String, label : String, state : FormState } -> List (Attribute msg) -> List (Html msg) -> Html msg
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


label : { state : FormState } -> List (Attribute msg) -> List (Html msg) -> Html msg
label { state } =
    Html.styled Html.label
        [ -- .ui.form .field > label
          display block
        , margin4 zero zero (rem 0.28571429) zero
        , color (rgba 0 0 0 0.87)
        , typography
            (Typography.init
                |> setFontSize (em 0.92857143)
                |> setFontWeight bold
                |> setTextTransform none
            )

        -- State
        , colorByState state
        ]


input : { state : FormState } -> List (Attribute msg) -> List (Html msg) -> Html msg
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
        , margin zero
        , outline none
        , property "-webkit-appearance" "none"
        , property "-webkit-tap-highlight-color" "rgba(255, 255, 255, 0)"
        , padding2 (em 0.67857143) (em 1)
        , typography
            (Typography.default
                |> setFontSize (em 1)
                |> setLineHeight (em 1.21428571)
            )
        , paletteWithBorder (border3 (px 1) solid)
            (Palette.init
                |> setBackground (hex "#FFFFFF")
                |> setColor (rgba 0 0 0 0.87)
                |> setBorder (rgba 34 36 38 0.15)
            )
        , boxShadow6 inset zero zero zero zero transparent
        , borderRadius (rem 0.28571429)
        , property "-webkit-transition" "color 0.1s ease, border-color 0.1s ease"
        , property "transition" "color 0.1s ease, border-color 0.1s ease"

        --
        , focus
            [ borderRadius (rem 0.28571429)
            , palette
                (Palette.init
                    |> setBackground (hex "#ffffff")
                    |> setColor (rgba 0 0 0 0.95)
                    |> setBorder (hex "#85b7d9")
                )
            , boxShadow6 inset zero zero zero zero (rgba 34 36 38 0.35)
            ]

        -- States
        , batch (stylesByState state)
        ]


textarea : { state : FormState } -> List (Attribute msg) -> List (Html msg) -> Html msg
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
        , paletteWithBorder (border3 (px 1) solid)
            (Palette.init
                |> setBackground (hex "#FFFFFF")
                |> setColor (rgba 0 0 0 0.87)
                |> setBorder (rgba 34 36 38 0.15)
            )
        , boxShadow6 inset zero zero zero zero transparent
        , outline none
        , borderRadius (rem 0.28571429)
        , property "-webkit-transition" "color 0.1s ease, border-color 0.1s ease"
        , property "transition" "color 0.1s ease, border-color 0.1s ease"
        , typography
            (Typography.default
                |> setFontSize (em 1)
                |> setLineHeight (num 1.2857)
            )
        , resize vertical

        -- .ui.form textarea:not([rows])
        , pseudoClass "not([rows])"
            [ height (em 12)
            , minHeight (em 8)
            , maxHeight (em 24)
            ]

        -- .ui.form textarea:focus
        , focus
            [ palette
                (Palette.init
                    |> setBackground (hex "#ffffff")
                    |> setColor (rgba 0 0 0 0.95)
                    |> setBorder (hex "#85b7d9")
                )
            , boxShadow6 inset zero zero zero zero (rgba 34 36 38 0.35)
            , borderRadius (rem 0.28571429)
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


colorByState : FormState -> Style
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


stylesByState : FormState -> List Style
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
