module UI.Button exposing (basicButton, button, buttonWithOption, labeledButton)

import Css exposing (..)
import Css.Extra exposing (Palette, palette, transparent_)
import Css.Global exposing (children, selector, typeSelector)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)
import UI.Modifier as Modifier


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
        , palette basis_
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
        , Prefix.boxShadow "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        , Prefix.userSelect "none"
        , property "-webkit-transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "will-change" "auto"
        , property "-webkit-tap-highlight-color" "transparent"

        -- .ui.button:hover
        , hover
            [ palette basisOnHover
            , backgroundImage none
            , Prefix.boxShadow "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
            ]

        -- .ui.button:focus
        , focus
            [ palette basisOnFocus
            , backgroundImage none
            , Prefix.boxShadow ""
            ]

        -- .ui.button:active
        , active
            [ palette basisOnActive
            , backgroundImage none
            , Prefix.boxShadow "0 0 0 1px transparent inset, none"
            ]

        -- .ui.button:disabled
        , disabled
            [ cursor default
            , opacity (num 0.45) |> important
            , backgroundImage none
            , Prefix.boxShadow "none"
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
        , palette basic
        , fontWeight normal
        , borderRadius (rem 0.28571429)
        , textTransform none
        , textShadow none |> important
        , Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.15) inset"

        -- .ui.basic.button:hover
        , palette basicOnHover
        , Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"

        -- .ui.basic.button:focus
        , palette basicOnFocus
        , Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        ]


type alias Options =
    { palette : Modifier.Palette }


buttonWithOption : Options -> List (Attribute msg) -> List (Html msg) -> Html msg
buttonWithOption options =
    let
        ( palette_, paletteOnHover, paletteOnFocus ) =
            case options.palette of
                Modifier.Primary ->
                    ( primary, primaryOnHover, primaryOnFocus )

                Modifier.Secondary ->
                    ( secondary, secondaryOnHover, secondaryOnFocus )

                Modifier.Red ->
                    ( red, redOnHover, redOnFocus )

                Modifier.Orange ->
                    ( orange, orangeOnHover, orangeOnFocus )

                Modifier.Yellow ->
                    ( yellow, yellowOnHover, yellowOnFocus )

                Modifier.Olive ->
                    ( olive, oliveOnHover, oliveOnFocus )

                Modifier.Green ->
                    ( green, greenOnHover, greenOnFocus )

                Modifier.Teal ->
                    ( teal, tealOnHover, tealOnFocus )

                Modifier.Blue ->
                    ( blue, blueOnHover, blueOnFocus )

                Modifier.Violet ->
                    ( violet, violetOnHover, violetOnFocus )

                Modifier.Purple ->
                    ( purple, purpleOnHover, purpleOnFocus )

                Modifier.Pink ->
                    ( pink, pinkOnHover, pinkOnFocus )

                Modifier.Brown ->
                    ( brown, brownOnHover, brownOnFocus )

                Modifier.Grey ->
                    ( grey, greyOnHover, greyOnFocus )

                Modifier.Black ->
                    ( black, blackOnHover, blackOnFocus )
    in
    basis
        [ -- .ui.xxx.button
          palette palette_
        , textShadow none
        , backgroundImage none

        -- .ui.xxx.button
        , Prefix.boxShadow "0 0 0 0 rgba(34, 36, 38, 0.15) inset"

        -- .ui.xxx.button:hover
        , hover
            [ palette paletteOnHover
            , textShadow none
            ]

        -- .ui.xxx.button:focus
        , focus
            [ palette paletteOnFocus
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
            , Prefix.userSelect "none"
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
            , Prefix.boxShadow "none"
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



-- PALETTE
-- BASIS


textColor =
    rgba 0 0 0 0.6


hoverColor =
    rgba 0 0 0 0.8


empty : Palette
empty =
    { background = transparent_
    , color = transparent_
    }


basis_ : Palette
basis_ =
    { background = hex "#E0E1E2"
    , color = textColor
    }


basisOnHover : Palette
basisOnHover =
    { background = hex "#CACBCD"
    , color = hoverColor
    }


basisOnFocus : Palette
basisOnFocus =
    basisOnHover


basisOnActive : Palette
basisOnActive =
    { background = hex "#BABBBC"
    , color = rgba 0 0 0 0.9
    }



-- BASIC


basic : Palette
basic =
    { background = rgba 0 0 0 0
    , color = textColor
    }


basicOnHover : Palette
basicOnHover =
    { background = hex "#FFFFFF"
    , color = hoverColor
    }


basicOnFocus : Palette
basicOnFocus =
    basicOnHover



-- PRIMARY


colored : Palette
colored =
    { empty | color = hex "#FFFFFF" }


primary : Palette
primary =
    blue


primaryOnHover : Palette
primaryOnHover =
    blueOnHover


primaryOnFocus : Palette
primaryOnFocus =
    blueOnFocus


secondary : Palette
secondary =
    black


secondaryOnHover : Palette
secondaryOnHover =
    blackOnHover


secondaryOnFocus : Palette
secondaryOnFocus =
    blackOnFocus


red : Palette
red =
    { colored | background = hex "#DB2828" }


redOnHover : Palette
redOnHover =
    { red | background = hex "#d01919" }


redOnFocus : Palette
redOnFocus =
    { red | background = hex "#ca1010" }


orange : Palette
orange =
    { colored | background = hex "#F2711C" }


orangeOnHover : Palette
orangeOnHover =
    { orange | background = hex "#f26202" }


orangeOnFocus : Palette
orangeOnFocus =
    { orange | background = hex "#e55b00" }


yellow : Palette
yellow =
    { colored | background = hex "#FBBD08" }


yellowOnHover : Palette
yellowOnHover =
    { yellow | background = hex "#eaae00" }


yellowOnFocus : Palette
yellowOnFocus =
    { yellow | background = hex "#daa300" }


olive : Palette
olive =
    { colored | background = hex "#B5CC18" }


oliveOnHover : Palette
oliveOnHover =
    { olive | background = hex "#a7bd0d" }


oliveOnFocus : Palette
oliveOnFocus =
    { olive | background = hex "#a0b605" }


green : Palette
green =
    { colored | background = hex "#21BA45" }


greenOnHover : Palette
greenOnHover =
    { green | background = hex "#16ab39" }


greenOnFocus : Palette
greenOnFocus =
    { green | background = hex "#0ea432" }


teal : Palette
teal =
    { colored | background = hex "#00B5AD" }


tealOnHover : Palette
tealOnHover =
    { teal | background = hex "#009c95" }


tealOnFocus : Palette
tealOnFocus =
    { teal | background = hex "#008c86" }


blue : Palette
blue =
    { colored | background = hex "#2185D0" }


blueOnHover : Palette
blueOnHover =
    { blue | background = hex "#1678c2" }


blueOnFocus : Palette
blueOnFocus =
    { blue | background = hex "#0d71bb" }


violet : Palette
violet =
    { colored | background = hex "#6435C9" }


violetOnHover : Palette
violetOnHover =
    { violet | background = hex "#5829bb" }


violetOnFocus : Palette
violetOnFocus =
    { violet | background = hex "#4f20b5" }


purple : Palette
purple =
    { colored | background = hex "#A333C8" }


purpleOnHover : Palette
purpleOnHover =
    { purple | background = hex "#9627ba" }


purpleOnFocus : Palette
purpleOnFocus =
    { purple | background = hex "#8f1eb4" }


pink : Palette
pink =
    { colored | background = hex "#E03997" }


pinkOnHover : Palette
pinkOnHover =
    { pink | background = hex "#e61a8d" }


pinkOnFocus : Palette
pinkOnFocus =
    { pink | background = hex "#e10f85" }


brown : Palette
brown =
    { colored | background = hex "#A5673F" }


brownOnHover : Palette
brownOnHover =
    { brown | background = hex "#975b33" }


brownOnFocus : Palette
brownOnFocus =
    { brown | background = hex "#90532b" }


grey : Palette
grey =
    { colored | background = hex "#767676" }


greyOnHover : Palette
greyOnHover =
    { grey | background = hex "#838383" }


greyOnFocus : Palette
greyOnFocus =
    { grey | background = hex "#8a8a8a" }


black : Palette
black =
    { colored | background = hex "#1B1C1D" }


blackOnHover : Palette
blackOnHover =
    { black | background = hex "#27292a" }


blackOnFocus : Palette
blackOnFocus =
    { black | background = hex "#2f3032" }
