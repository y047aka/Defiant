module UI.Checkbox exposing (checkbox, input, label)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (generalSiblings)
import Html.Styled as Html exposing (Attribute, Html)


checkbox : List (Attribute msg) -> List (Html msg) -> Html msg
checkbox =
    Html.styled Html.div
        [ -- .ui.checkbox
          position relative
        , display inlineBlock
        , prefixed [] "backface-visibility" "hidden"
        , outline none
        , verticalAlign baseline
        , fontStyle normal
        , minHeight (px 17)
        , fontSize (em 1)
        , lineHeight (px 17)
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
                        [ property "background" "#FFFFFF"
                        , borderColor (hex "#96C8DA")
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
                        [ property "background" "#FFFFFF"
                        , borderColor (rgba 34 36 38 0.35)
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


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
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
            , property "background" "#FFFFFF"
            , borderRadius (rem 0.21428571)
            , property "-webkit-transition" "border 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, transform 0.1s ease, box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, transform 0.1s ease, box-shadow 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , border3 (px 1) solid (hex "#D4D4D5")
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
                [ property "background" "#FFFFFF"
                , borderColor (rgba 34 36 38 0.35)
                ]

            -- .ui.checkbox label:hover
            -- .ui.checkbox + label:hover
            , color (rgba 0 0 0 0.8)
            ]

        -- Down
        , active
            [ -- .ui.checkbox label:active::before
              before
                [ property "background" "#F9FAFB"
                , borderColor (rgba 34 36 38 0.35)
                ]

            -- .ui.checkbox label:active::after
            , after
                [ color (rgba 0 0 0 0.95) ]
            ]
        ]
