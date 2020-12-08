module UI.Button exposing (basicButton, button, buttonWithOption, labeledButton)

import Css exposing (..)
import Css.Global exposing (children, selector, typeSelector)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)
import UI.Modifier as Modifier exposing (Palette(..))


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.button <|
        [ -- .ui.button
          cursor pointer
        , display inlineBlock
        , minHeight (em 1)
        , outline none
        , borderStyle none
        , verticalAlign baseline
        , backgroundColor (hex "#E0E1E2")
        , color (rgba 0 0 0 0.6)
        , fontFamilies Modifier.fontFamilies
        , margin4 zero (em 0.25) zero zero
        , padding3 (em 0.78571429) (em 1.5) (em 0.78571429)
        , textTransform none
        , textShadow none
        , fontWeight bold
        , lineHeight (em 1)
        , fontStyle normal
        , textAlign center
        , textDecoration none
        , borderRadius (rem 0.28571429)
        , property "-webkit-box-shadow" "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        , property "box-shadow" "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        , property "-webkit-user-select" "none"
        , property "-moz-user-select" "none"
        , property "-ms-user-select" "none"
        , property "user-select" "none"
        , property "-webkit-transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "will-change" "auto"
        , property "-webkit-tap-highlight-color" "transparent"

        -- .ui.button:hover
        , hover
            [ backgroundColor (hex "#CACBCD")
            , backgroundImage none
            , property "-webkit-box-shadow" "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
            , property "box-shadow" "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
            , color (rgba 0 0 0 0.8)
            ]

        -- .ui.button:focus
        , focus
            [ backgroundColor (hex "#CACBCD")
            , color (rgba 0 0 0 0.8)
            , backgroundImage none
            , property "-webkit-box-shadow" ""
            , property "box-shadow" ""
            ]

        -- .ui.button:active
        , active
            [ backgroundColor (hex "#BABBBC")
            , backgroundImage none
            , color (rgba 0 0 0 0.9)
            , property "-webkit-box-shadow" "0 0 0 1px transparent inset, none"
            , property "box-shadow" "0 0 0 1px transparent inset, none"
            ]

        -- .ui.button:disabled
        , disabled
            [ cursor default
            , opacity (num 0.45) |> important
            , backgroundImage none
            , property "-webkit-box-shadow" "none"
            , property "box-shadow" "none"
            , pointerEvents none |> important
            ]

        -- .ui.button
        , fontSize (rem 1)
        ]
            ++ additionalStyles


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    basis []


basicButton : List (Attribute msg) -> List (Html msg) -> Html msg
basicButton =
    basis
        [ -- .ui.basic.button
          property "background" "transparent none"
        , color (rgba 0 0 0 0.6)
        , fontWeight normal
        , borderRadius (rem 0.28571429)
        , textTransform none
        , textShadow none |> important
        , property "-webkit-box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.15) inset"
        , property "box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.15) inset"

        -- .ui.basic.button:hover
        , backgroundColor (hex "#FFFFFF")
        , color (rgba 0 0 0 0.8)
        , property "-webkit-box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        , property "box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"

        -- .ui.basic.button:focus
        , backgroundColor (hex "#FFFFFF")
        , color (rgba 0 0 0 0.8)
        , property "-webkit-box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        , property "box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        ]


type alias Options =
    { palette : Palette }


buttonWithOption : Options -> List (Attribute msg) -> List (Html msg) -> Html msg
buttonWithOption { palette } =
    basis
        [ -- .ui.xxx.button
          backgroundColor <|
            case palette of
                Primary ->
                    hex "#2185D0"

                Secondary ->
                    hex "#1B1C1D"

                Red ->
                    hex "#DB2828"

                Orange ->
                    hex "#F2711C"

                Yellow ->
                    hex "#FBBD08"

                Olive ->
                    hex "#B5CC18"

                Green ->
                    hex "#21BA45"

                Teal ->
                    hex "#00B5AD"

                Blue ->
                    hex "#2185D0"

                Violet ->
                    hex "#6435C9"

                Purple ->
                    hex "#A333C8"

                Pink ->
                    hex "#E03997"

                Brown ->
                    hex "#A5673F"

                Grey ->
                    hex "#767676"

                Black ->
                    hex "#1B1C1D"
        , color (hex "#FFFFFF")
        , textShadow none
        , backgroundImage none

        -- .ui.xxx.button
        , property "-webkit-box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        , property "box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.15) inset"

        -- .ui.xxx.button:hover
        , hover
            [ backgroundColor <|
                case palette of
                    Primary ->
                        hex "#1678c2"

                    Secondary ->
                        hex "#27292a"

                    Red ->
                        hex "#d01919"

                    Orange ->
                        hex "#f26202"

                    Yellow ->
                        hex "#eaae00"

                    Olive ->
                        hex "#a7bd0d"

                    Green ->
                        hex "#16ab39"

                    Teal ->
                        hex "#009c95"

                    Blue ->
                        hex "#1678c2"

                    Violet ->
                        hex "#5829bb"

                    Purple ->
                        hex "#9627ba"

                    Pink ->
                        hex "#e61a8d"

                    Brown ->
                        hex "#975b33"

                    Grey ->
                        hex "#838383"

                    Black ->
                        hex "#27292a"
            , color (hex "#FFFFFF")
            , textShadow none
            ]

        -- .ui.xxx.button:focus
        , focus
            [ backgroundColor <|
                case palette of
                    Primary ->
                        hex "#0d71bb"

                    Secondary ->
                        hex "#2e3032"

                    Red ->
                        hex "#ca1010"

                    Orange ->
                        hex "#e55b00"

                    Yellow ->
                        hex "#daa300"

                    Olive ->
                        hex "#a0b605"

                    Green ->
                        hex "#0ea432"

                    Teal ->
                        hex "#008c86"

                    Blue ->
                        hex "#0d71bb"

                    Violet ->
                        hex "#4f20b5"

                    Purple ->
                        hex "#8f1eb4"

                    Pink ->
                        hex "#e10f85"

                    Brown ->
                        hex "#90532b"

                    Grey ->
                        hex "#8a8a8a"

                    Black ->
                        hex "#2f3032"
            , color (hex "#FFFFFF")
            , textShadow none
            ]
        ]


labeledButton : List (Attribute msg) -> List (Html msg) -> Html msg
labeledButton attributes =
    Html.div <|
        css
            [ -- .ui.button
              cursor pointer
            , minHeight (em 1)
            , outline none
            , borderStyle none
            , verticalAlign baseline
            , color (rgba 0 0 0 0.6)
            , fontFamilies Modifier.fontFamilies
            , margin4 zero (em 0.25) zero zero
            , textTransform none
            , textShadow none
            , fontWeight bold
            , lineHeight (em 1)
            , fontStyle normal
            , textAlign center
            , textDecoration none
            , borderRadius (rem 0.28571429)
            , property "-webkit-user-select" "none"
            , property "-moz-user-select" "none"
            , property "-ms-user-select" "none"
            , property "user-select" "none"
            , property "-webkit-tap-highlight-color" "transparent"

            -- .ui.labeled.button:not(.icon)
            , property "display" "-webkit-inline-box"
            , property "display" "-ms-inline-flexbox"
            , display inlineFlex
            , property "-webkit-box-orient" "horizontal"
            , property "-webkit-box-direction" "normal"
            , property "-ms-flex-direction" "row"
            , flexDirection row
            , backgroundColor transparent
            , padding zero |> important
            , borderStyle none
            , property "-webkit-box-shadow" "none"
            , boxShadow none
            , children
                [ typeSelector "button"
                    [ -- .ui.labeled.button > .button
                      margin zero

                    -- .ui.labeled.button:not([class*="left labeled"]) > .button
                    , firstChild
                        [ borderTopRightRadius zero
                        , borderBottomRightRadius zero
                        ]

                    -- .ui[class*="left labeled"].button > .label
                    , lastChild
                        [ borderTopLeftRadius zero
                        , borderBottomLeftRadius zero
                        ]
                    ]
                , selector "*:not(button)"
                    [ -- .ui.labeled.button > .label
                      property "display" "-webkit-box"
                    , property "display" "-ms-flexbox"
                    , property "display" "flex"
                    , property "-webkit-box-align" "center"
                    , property "-ms-flex-align" "center"
                    , alignItems center
                    , margin4 zero zero zero (px -1) |> important
                    , fontSize (em 1)

                    -- padding: '';
                    , borderColor (rgba 34 36 38 0.15)

                    -- Extra Styles
                    , borderRadius zero
                    , firstChild
                        [ -- Based on `.ui[class*="left labeled"].button > .label`
                          borderRadius4 (rem 0.28571429) zero zero (rem 0.28571429)
                        ]
                    , lastChild
                        [ -- Based on `.ui.labeled.button:not([class*="left labeled"]) > .label`
                          borderRadius4 zero (rem 0.28571429) (rem 0.28571429) zero
                        ]
                    ]
                , selector "*:not(button):not(first-child):not(last-child)"
                    [ borderRadius zero ]
                ]
            ]
            :: attributes
