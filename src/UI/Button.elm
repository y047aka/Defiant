module UI.Button exposing
    ( button, basicButton
    , labeledButton
    , primaryButton, secondaryButton
    , redButton, orangeButton, yellowButton, oliveButton, greenButton, tealButton, blueButton, violetButton, purpleButton, pinkButton, brownButton, greyButton, blackButton
    )

{-|

@docs button, basicButton
@docs labeledButton
@docs primaryButton, secondaryButton
@docs redButton, orangeButton, yellowButton, oliveButton, greenButton, tealButton, blueButton, violetButton, purpleButton, pinkButton, brownButton, greyButton, blackButton

-}

import Css exposing (..)
import Css.Global exposing (children, selector, typeSelector)
import Css.Layout as Layout exposing (layout)
import Css.Palette exposing (..)
import Css.Prefix as Prefix
import Css.Typography as Typography exposing (fomanticFont, init, typography)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)


basis :
    { palettes : PalettesByState, shadow : Bool }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
basis { palettes, shadow } additionalStyles =
    let
        defaultLayout =
            Layout.default
    in
    Html.styled Html.button <|
        [ -- .ui.button
          cursor pointer
        , display inlineBlock
        , minHeight (em 1)
        , outline none
        , borderStyle none
        , layout { defaultLayout | textAlign = Layout.center }
        , typography
            { init
                | fontFamilies = fomanticFont
                , textTransform = Typography.none
                , fontStyle = Typography.normal
                , fontWeight = Typography.bold
                , lineHeight = Typography.em 1
                , textDecoration = Typography.none
            }
        , margin4 zero (em 0.25) zero zero
        , padding3 (em 0.78571429) (em 1.5) (em 0.78571429)
        , textShadow none
        , borderRadius (rem 0.28571429)
        , Prefix.userSelect "none"
        , property "-webkit-transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "will-change" "auto"
        , property "-webkit-tap-highlight-color" "transparent"
        , palettesByState palettes
        , batch <|
            if shadow then
                [ Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.15) inset" -- .ui.basic.button
                , hover [ Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset" ] -- .ui.basic.button:hover
                , focus [ Prefix.boxShadow "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset" ] -- .ui.basic.button:focus
                , active [ Prefix.boxShadow "0 0 0 1px rgba(0, 0, 0, 0.15) inset, 0 1px 4px 0 rgba(34, 36, 38, 0.15) inset" ] -- .ui.basic.button:active
                ]

            else
                [ Prefix.boxShadow "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
                , hover [ Prefix.boxShadow "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset" ] -- .ui.button:hover
                , focus [ Prefix.boxShadow "" ] -- .ui.button:focus
                , active [ Prefix.boxShadow "0 0 0 1px transparent inset, none" ] -- .ui.button:active
                , disabled [ Prefix.boxShadow "none" ] -- .ui.button:disabled
                ]

        -- .ui.button:hover
        , hover
            [ backgroundImage none ]

        -- .ui.button:focus
        , focus
            [ backgroundImage none ]

        -- .ui.button:active
        , active
            [ backgroundImage none ]

        -- .ui.button:disabled
        , disabled
            [ cursor default
            , opacity (num 0.45) |> important
            , backgroundImage none
            , pointerEvents none |> important
            ]

        -- .ui.button
        , fontSize (rem 1)
        ]
            ++ additionalStyles


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    basis { palettes = defaultPalettes, shadow = False } []


basicButton : List (Attribute msg) -> List (Html msg) -> Html msg
basicButton =
    basis { palettes = basicPalettes, shadow = True }
        [ -- .ui.basic.button
          property "background" "transparent none"
        , typography
            { init
                | fontWeight = Typography.normal
                , textTransform = Typography.none
            }
        , borderRadius (rem 0.28571429)
        , textShadow none |> important
        ]


labeledButton : List (Attribute msg) -> List (Html msg) -> Html msg
labeledButton attributes =
    let
        defaultLayout =
            Layout.default
    in
    Html.div <|
        css
            [ -- .ui.button
              cursor pointer
            , minHeight (em 1)
            , outline none
            , borderStyle none
            , layout { defaultLayout | textAlign = Layout.center }
            , typography
                { init
                    | fontFamilies = fomanticFont
                    , textTransform = Typography.none
                    , fontStyle = Typography.normal
                    , fontWeight = Typography.bold
                    , lineHeight = Typography.em 1
                    , textDecoration = Typography.none
                }
            , color (rgba 0 0 0 0.6)
            , margin4 zero (em 0.25) zero zero
            , textShadow none
            , borderRadius (rem 0.28571429)
            , Prefix.userSelect "none"
            , property "-webkit-tap-highlight-color" "transparent"

            -- .ui.labeled.button:not(.icon)
            , property "display" "-webkit-inline-box"
            , property "display" "-ms-inline-flexbox"
            , display inlineFlex
            , property "-webkit-box-orient" "horizontal"
            , property "-webkit-box-direction" "normal"
            , Prefix.flexDirection "row"
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


coloredButton :
    PalettesByState
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
coloredButton palettes =
    basis { palettes = palettes, shadow = False }
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


primaryButton : List (Attribute msg) -> List (Html msg) -> Html msg
primaryButton =
    coloredButton <| PalettesByState primary primaryOnHover primaryOnFocus primaryOnActive


secondaryButton : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryButton =
    coloredButton <| PalettesByState secondary secondaryOnHover secondaryOnFocus secondaryOnActive


redButton : List (Attribute msg) -> List (Html msg) -> Html msg
redButton =
    coloredButton <| PalettesByState red redOnHover redOnFocus redOnActive


orangeButton : List (Attribute msg) -> List (Html msg) -> Html msg
orangeButton =
    coloredButton <| PalettesByState orange orangeOnHover orangeOnFocus orangeOnActive


yellowButton : List (Attribute msg) -> List (Html msg) -> Html msg
yellowButton =
    coloredButton <| PalettesByState yellow yellowOnHover yellowOnFocus yellowOnActive


oliveButton : List (Attribute msg) -> List (Html msg) -> Html msg
oliveButton =
    coloredButton <| PalettesByState olive oliveOnHover oliveOnFocus oliveOnActive


greenButton : List (Attribute msg) -> List (Html msg) -> Html msg
greenButton =
    coloredButton <| PalettesByState green greenOnHover greenOnFocus greenOnActive


tealButton : List (Attribute msg) -> List (Html msg) -> Html msg
tealButton =
    coloredButton <| PalettesByState teal tealOnHover tealOnFocus tealOnActive


blueButton : List (Attribute msg) -> List (Html msg) -> Html msg
blueButton =
    coloredButton <| PalettesByState blue blueOnHover blueOnFocus blueOnActive


violetButton : List (Attribute msg) -> List (Html msg) -> Html msg
violetButton =
    coloredButton <| PalettesByState violet violetOnHover violetOnFocus violetOnActive


purpleButton : List (Attribute msg) -> List (Html msg) -> Html msg
purpleButton =
    coloredButton <| PalettesByState purple purpleOnHover purpleOnFocus purpleOnActive


pinkButton : List (Attribute msg) -> List (Html msg) -> Html msg
pinkButton =
    coloredButton <| PalettesByState purple purpleOnHover purpleOnFocus purpleOnActive


brownButton : List (Attribute msg) -> List (Html msg) -> Html msg
brownButton =
    coloredButton <| PalettesByState brown brownOnHover brownOnFocus brownOnActive


greyButton : List (Attribute msg) -> List (Html msg) -> Html msg
greyButton =
    coloredButton <| PalettesByState grey greyOnHover greyOnFocus greyOnActive


blackButton : List (Attribute msg) -> List (Html msg) -> Html msg
blackButton =
    coloredButton <| PalettesByState black blackOnHover blackOnFocus blackOnActive



-- PALETTES BY STATE


type alias PalettesByState =
    { default : Palette
    , onHover : Palette
    , onFocus : Palette
    , onActive : Palette
    }


palettesByState : PalettesByState -> Style
palettesByState { default, onHover, onFocus, onActive } =
    batch
        [ palette default
        , hover [ palette onHover ]
        , focus [ palette onFocus ]
        , active [ palette onActive ]
        ]


defaultPalettes : PalettesByState
defaultPalettes =
    PalettesByState basisDefault basisOnHover basisOnFocus basisOnActive


basicPalettes : PalettesByState
basicPalettes =
    PalettesByState basic basicOnHover basicOnFocus basicOnActive



-- PALETTE


basisDefault : Palette
basisDefault =
    { background = hex "#E0E1E2"
    , color = textColor
    , border = transparent_
    }


basisOnHover : Palette
basisOnHover =
    { basisDefault
        | background = hex "#CACBCD"
        , color = hoverColor
    }


basisOnFocus : Palette
basisOnFocus =
    basisOnHover


basisOnActive : Palette
basisOnActive =
    { basisDefault
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


basicOnActive : Palette
basicOnActive =
    { basic
        | background = hex "#F8F8F8"
        , color = rgba 0 0 0 0.9
    }
