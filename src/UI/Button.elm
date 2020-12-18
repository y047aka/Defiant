module UI.Button exposing (basicButton, button, buttonWithOption, labeledButton)

import Css exposing (..)
import Css.Extra exposing (palette)
import Css.Global exposing (children, selector, typeSelector)
import Css.Palette exposing (..)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)
import Maybe.Extra as Maybe
import UI.Modifier as Modifier


basis :
    Maybe { default : Palette, onHover : Palette, onFocus : Palette }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
basis maybeOptions additionalStyles =
    Html.styled Html.button <|
        [ -- .ui.button
          cursor pointer
        , display inlineBlock
        , minHeight (em 1)
        , outline none
        , borderStyle none
        , verticalAlign baseline
        , palette <| Maybe.unwrap basis_ .default maybeOptions
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
            [ palette <| Maybe.unwrap basisOnHover .onHover maybeOptions
            , backgroundImage none
            , Prefix.boxShadow "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
            ]

        -- .ui.button:focus
        , focus
            [ palette <| Maybe.unwrap basisOnFocus .onFocus maybeOptions
            , backgroundImage none
            , Prefix.boxShadow ""
            ]

        -- .ui.button:active
        , active
            [ Maybe.withDefault (palette basisOnActive) <| Maybe.map (\_ -> Css.Extra.none) maybeOptions
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
    basis Nothing []


basicButton : List (Attribute msg) -> List (Html msg) -> Html msg
basicButton =
    basis (Just { default = basic, onHover = basicOnHover, onFocus = basicOnFocus })
        [ -- .ui.basic.button
          property "background" "transparent none"
        , fontWeight normal
        , borderRadius (rem 0.28571429)
        , textTransform none
        , textShadow none |> important
        , Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.15) inset"

        -- .ui.basic.button:hover
        , Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"

        -- .ui.basic.button:focus
        , Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
        ]


type alias Options =
    { palette : Modifier.Palette }


buttonWithOption : Options -> List (Attribute msg) -> List (Html msg) -> Html msg
buttonWithOption options =
    let
        palette_ =
            case options.palette of
                Modifier.Primary ->
                    { default = primary, onHover = primaryOnHover, onFocus = primaryOnFocus }

                Modifier.Secondary ->
                    { default = secondary, onHover = secondaryOnHover, onFocus = secondaryOnFocus }

                Modifier.Red ->
                    { default = red, onHover = redOnHover, onFocus = redOnFocus }

                Modifier.Orange ->
                    { default = orange, onHover = orangeOnHover, onFocus = orangeOnFocus }

                Modifier.Yellow ->
                    { default = yellow, onHover = yellowOnHover, onFocus = yellowOnFocus }

                Modifier.Olive ->
                    { default = olive, onHover = oliveOnHover, onFocus = oliveOnFocus }

                Modifier.Green ->
                    { default = green, onHover = greenOnHover, onFocus = greenOnFocus }

                Modifier.Teal ->
                    { default = teal, onHover = tealOnHover, onFocus = tealOnFocus }

                Modifier.Blue ->
                    { default = blue, onHover = blueOnHover, onFocus = blueOnFocus }

                Modifier.Violet ->
                    { default = violet, onHover = violetOnHover, onFocus = violetOnFocus }

                Modifier.Purple ->
                    { default = purple, onHover = purpleOnHover, onFocus = purpleOnFocus }

                Modifier.Pink ->
                    { default = pink, onHover = pinkOnHover, onFocus = pinkOnFocus }

                Modifier.Brown ->
                    { default = brown, onHover = brownOnHover, onFocus = brownOnFocus }

                Modifier.Grey ->
                    { default = grey, onHover = greyOnHover, onFocus = greyOnFocus }

                Modifier.Black ->
                    { default = black, onHover = blackOnHover, onFocus = blackOnFocus }
    in
    basis (Just palette_)
        [ -- .ui.xxx.button
          textShadow none
        , backgroundImage none

        -- .ui.xxx.button
        , Prefix.boxShadow "0 0 0 0 rgba(34, 36, 38, 0.15) inset"

        -- .ui.xxx.button:hover
        , hover
            [ textShadow none ]

        -- .ui.xxx.button:focus
        , focus
            [ textShadow none ]
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


basis_ : Palette
basis_ =
    { background = hex "#E0E1E2"
    , color = textColor
    , border = transparent_
    }


basisOnHover : Palette
basisOnHover =
    { basis_
        | background = hex "#CACBCD"
        , color = hoverColor
    }


basisOnFocus : Palette
basisOnFocus =
    basisOnHover


basisOnActive : Palette
basisOnActive =
    { basis_
        | background = hex "#BABBBC"
        , color = rgba 0 0 0 0.9
    }


basic : Palette
basic =
    { background = rgba 0 0 0 0
    , color = textColor
    , border = transparent_
    }


basicOnHover : Palette
basicOnHover =
    { basic
        | background = hex "#FFFFFF"
        , color = hoverColor
    }


basicOnFocus : Palette
basicOnFocus =
    basicOnHover
