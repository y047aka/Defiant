module UI.Checkbox exposing (checkbox, checkboxWithProps)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (generalSiblings)
import Css.Palette as Palette exposing (palette, paletteWith, setBackground, setBorder)
import Css.Typography as Typography exposing (setFontSize, setFontStyle, setLineHeight, typography)
import Html.Styled as Html exposing (Attribute, Html, text)
import Html.Styled.Attributes as Attributes exposing (for, id, type_)
import Html.Styled.Events exposing (onClick)
import Types exposing (FormState(..))


checkboxWithProps :
    { id : String
    , label : String
    , checked : Bool
    , state : FormState
    , onClick : msg
    }
    -> Html msg
checkboxWithProps props =
    checkboxWrapper []
        [ input
            [ id props.id
            , type_ "checkbox"
            , Attributes.checked props.checked
            , onClick props.onClick
            ]
            []
        , label { state = props.state } [ for props.id ] [ text props.label ]
        ]


checkbox :
    { id : String
    , label : String
    , checked : Bool
    , onClick : msg
    }
    -> Html msg
checkbox props =
    checkboxWithProps
        { id = props.id
        , label = props.label
        , checked = props.checked
        , state = Default
        , onClick = props.onClick
        }


checkboxWrapper : List (Attribute msg) -> List (Html msg) -> Html msg
checkboxWrapper =
    Html.styled Html.div
        [ -- .ui.checkbox
          position relative
        , display inlineBlock
        , prefixed [] "backface-visibility" "hidden"
        , outline none
        , verticalAlign baseline
        , minHeight (px 17)
        , typography
            (Typography.init
                |> setFontSize (em 1)
                |> setFontStyle normal
                |> setLineHeight (px 17)
            )
        , minWidth (px 17)
        ]


input : List (Attribute msg) -> List (Html msg) -> Html msg
input =
    Html.styled Html.input
        [ -- .ui.checkbox input[type="checkbox"]
          -- .ui.checkbox input[type="radio"]
          cursor pointer
        , position absolute
        , top zero
        , left zero
        , opacity zero |> important
        , outline none
        , zIndex (int 3)
        , width (px 17)
        , height (px 17)
        , active
            [ generalSiblings
                [ Css.Global.label
                    [ -- .ui.checkbox input:active ~ label
                      color (rgba 0 0 0 0.95)
                    ]
                ]
            ]
        , focus
            [ generalSiblings
                [ Css.Global.label
                    [ -- .ui.checkbox input:focus ~ label
                      color (rgba 0 0 0 0.95)

                    -- .ui.checkbox input:focus ~ label:before
                    , before
                        [ palette
                            (Palette.init
                                |> setBackground (hex "#FFFFFF")
                                |> setBorder (hex "#96C8DA")
                            )
                        ]

                    -- .ui.checkbox input:focus ~ label:after
                    , after
                        [ color (rgba 0 0 0 0.95) ]
                    ]
                ]
            ]
        , checked
            [ generalSiblings
                [ Css.Global.label
                    [ -- .ui.checkbox input:checked ~ label:before
                      before
                        [ palette
                            (Palette.init
                                |> setBackground (hex "#FFFFFF")
                                |> setBorder (rgba 34 36 38 0.35)
                            )
                        ]

                    -- .ui.checkbox input:checked ~ label:after
                    , after
                        [ opacity (int 1)
                        , color (rgba 0 0 0 0.95)
                        ]

                    -- .ui.checkbox input:checked ~ .box:after
                    -- .ui.checkbox input:checked ~ label:after
                    , after
                        [ property "content" "url(\"data:image/svg+xml,%3csvg viewBox='0 0 16 16' fill='black' xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M5.707 7.293a1 1 0 0 0-1.414 1.414l2 2a1 1 0 0 0 1.414 0l4-4a1 1 0 0 0-1.414-1.414L7 8.586 5.707 7.293z'/%3e%3c/svg%3e\")" ]
                    ]
                ]
            ]
        ]


labelBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
labelBasis additionalStyles =
    Html.styled Html.label
        [ -- .ui.checkbox label
          cursor auto
        , position relative
        , display block
        , paddingLeft (em 1.85714)
        , outline none
        , fontSize (em 1)

        -- .ui.checkbox label:before
        , before
            [ position absolute
            , top zero
            , left zero
            , width (px 17)
            , height (px 17)
            , property "content" "''"
            , borderRadius (rem 0.21428571)
            , property "-webkit-transition" "border 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, transform 0.1s ease, box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, transform 0.1s ease, box-shadow 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , paletteWith { border = border3 (px 1) solid }
                (Palette.init
                    |> setBackground (hex "#FFFFFF")
                    |> setBorder (hex "#D4D4D5")
                )
            ]

        -- .ui.checkbox label:after
        , after
            [ position absolute
            , fontSize (px 14)
            , top zero
            , left zero
            , width (px 17)
            , height (px 17)
            , textAlign center
            , opacity zero
            , color (rgba 0 0 0 0.87)
            , property "-webkit-transition" "border 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease;"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease;"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, transform 0.1s ease, box-shadow 0.1s ease;"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, transform 0.1s ease, box-shadow 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease;"
            ]

        -- Hover
        , hover
            [ -- .ui.checkbox label:hover::before
              before
                [ palette
                    (Palette.init
                        |> setBackground (hex "#FFFFFF")
                        |> setBorder (rgba 34 36 38 0.35)
                    )
                ]

            -- .ui.checkbox label:hover
            -- .ui.checkbox + label:hover
            , color (rgba 0 0 0 0.8)
            ]

        -- Down
        , active
            [ -- .ui.checkbox label:active::before
              before
                [ palette
                    (Palette.init
                        |> setBackground (hex "#F9FAFB")
                        |> setBorder (rgba 34 36 38 0.35)
                    )
                ]

            -- .ui.checkbox label:active::after
            , after
                [ color (rgba 0 0 0 0.95) ]
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


label : { state : FormState } -> List (Attribute msg) -> List (Html msg) -> Html msg
label { state } =
    labelBasis
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
