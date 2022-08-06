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
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, descendants, selector, typeSelector)
import Css.Layout as Layout exposing (layout)
import Css.Palette exposing (..)
import Css.Typography as Typography exposing (fomanticFontFamilies, typography)
import Data exposing (PresetColor(..))
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

        initialTypography =
            Typography.init
    in
    Html.styled Html.button
        [ -- .ui.button
          cursor pointer
        , display inlineBlock
        , minHeight (em 1)
        , outline none
        , borderStyle none
        , layout { defaultLayout | textAlign = Layout.center }
        , typography
            { initialTypography
                | fontFamilies = fomanticFontFamilies
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
        , prefixed [] "user-select" "none"
        , property "-webkit-transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease"
        , property "transition" "opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "will-change" "auto"
        , property "-webkit-tap-highlight-color" "transparent"
        , palettesByState palettes
        , batch <|
            if shadow then
                [ prefixed [] "box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.15) inset" -- .ui.basic.button
                , hover [ prefixed [] "box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset" ] -- .ui.basic.button:hover
                , focus [ prefixed [] "box-shadow" "0 0 0 1px rgba(34, 36, 38, 0.35) inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset" ] -- .ui.basic.button:focus
                , active [ prefixed [] "box-shadow" "0 0 0 1px rgba(0, 0, 0, 0.15) inset, 0 1px 4px 0 rgba(34, 36, 38, 0.15) inset" ] -- .ui.basic.button:active
                ]

            else
                [ prefixed [] "box-shadow" "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset"
                , hover [ prefixed [] "box-shadow" "0 0 0 1px transparent inset, 0 0 0 0 rgba(34, 36, 38, 0.15) inset" ] -- .ui.button:hover
                , focus [ prefixed [] "box-shadow" "" ] -- .ui.button:focus
                , active [ prefixed [] "box-shadow" "0 0 0 1px transparent inset, none" ] -- .ui.button:active
                , disabled [ prefixed [] "box-shadow" "none" ] -- .ui.button:disabled
                ]

        -- .ui.button:hover
        , hover
            [ backgroundImage none

            -- .ui.button:hover .icon
            , descendants
                [ Css.Global.i
                    [ opacity (num 0.85) ]
                ]
            ]

        -- .ui.button:focus
        , focus
            [ backgroundImage none

            -- .ui.button:focus .icon
            , descendants
                [ Css.Global.i
                    [ opacity (num 0.85) ]
                ]
            ]

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

        -- .ui.button > .icon:not(.button)
        , children
            [ Css.Global.i
                [ height auto
                , opacity (num 0.8)
                , property "-webkit-transition" "opacity 0.1s ease"
                , property "transition" "opacity 0.1s ease"
                , property "color" "''"

                -- .ui.button:not(.icon) > .icon:not(.button):not(.dropdown)
                -- .ui.button:not(.icon) > .icons:not(.button):not(.dropdown)
                , margin4 zero (em 0.42857143) zero (em -0.21428571)
                , verticalAlign baseline
                ]
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    basis { palettes = defaultPalettes, shadow = False } []


basicButton : List (Attribute msg) -> List (Html msg) -> Html msg
basicButton =
    let
        initialTypography =
            Typography.init
    in
    basis { palettes = basicPalettes, shadow = True }
        [ -- .ui.basic.button
          property "background" "transparent none"
        , typography
            { initialTypography
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

        initialTypography =
            Typography.init
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
                { initialTypography
                    | fontFamilies = fomanticFontFamilies
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
            , prefixed [] "user-select" "none"
            , property "-webkit-tap-highlight-color" "transparent"

            -- .ui.labeled.button:not(.icon)
            , property "display" "-webkit-inline-box"
            , property "display" "-ms-inline-flexbox"
            , display inlineFlex
            , property "-webkit-box-orient" "horizontal"
            , property "-webkit-box-direction" "normal"
            , prefixed [] "flex-direction" "row"
            , backgroundColor transparent
            , padding zero |> important
            , borderStyle none
            , prefixed [] "box-shadow" "none"
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
        , prefixed [] "box-shadow" "0 0 0 0 rgba(34, 36, 38, 0.15) inset"

        -- .ui.xxx.button:hover
        , hover
            [ textShadow none ]

        -- .ui.xxx.button:focus
        , focus
            [ textShadow none ]
        ]


primaryButton : List (Attribute msg) -> List (Html msg) -> Html msg
primaryButton =
    blueButton


secondaryButton : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryButton =
    blackButton


redButton : List (Attribute msg) -> List (Html msg) -> Html msg
redButton =
    coloredButton (paletteSelector Red)


orangeButton : List (Attribute msg) -> List (Html msg) -> Html msg
orangeButton =
    coloredButton (paletteSelector Orange)


yellowButton : List (Attribute msg) -> List (Html msg) -> Html msg
yellowButton =
    coloredButton (paletteSelector Yellow)


oliveButton : List (Attribute msg) -> List (Html msg) -> Html msg
oliveButton =
    coloredButton (paletteSelector Olive)


greenButton : List (Attribute msg) -> List (Html msg) -> Html msg
greenButton =
    coloredButton (paletteSelector Green)


tealButton : List (Attribute msg) -> List (Html msg) -> Html msg
tealButton =
    coloredButton (paletteSelector Teal)


blueButton : List (Attribute msg) -> List (Html msg) -> Html msg
blueButton =
    coloredButton (paletteSelector Blue)


violetButton : List (Attribute msg) -> List (Html msg) -> Html msg
violetButton =
    coloredButton (paletteSelector Violet)


purpleButton : List (Attribute msg) -> List (Html msg) -> Html msg
purpleButton =
    coloredButton (paletteSelector Purple)


pinkButton : List (Attribute msg) -> List (Html msg) -> Html msg
pinkButton =
    coloredButton (paletteSelector Purple)


brownButton : List (Attribute msg) -> List (Html msg) -> Html msg
brownButton =
    coloredButton (paletteSelector Brown)


greyButton : List (Attribute msg) -> List (Html msg) -> Html msg
greyButton =
    coloredButton (paletteSelector Grey)


blackButton : List (Attribute msg) -> List (Html msg) -> Html msg
blackButton =
    coloredButton (paletteSelector Black)



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


paletteSelector : PresetColor -> PalettesByState
paletteSelector presetColor =
    case presetColor of
        Red ->
            red

        Orange ->
            orange

        Yellow ->
            yellow

        Olive ->
            olive

        Green ->
            green

        Teal ->
            teal

        Blue ->
            blue

        Violet ->
            violet

        Purple ->
            purple

        Pink ->
            purple

        Brown ->
            brown

        Grey ->
            grey

        Black ->
            black



-- PALETTE


basisDefault : Palette
basisDefault =
    { background = Just (hex "#E0E1E2")
    , color = Just textColor
    , border = Just transparent_
    }


basisOnHover : Palette
basisOnHover =
    { basisDefault
        | background = Just (hex "#CACBCD")
        , color = Just hoverColor
    }


basisOnFocus : Palette
basisOnFocus =
    basisOnHover


basisOnActive : Palette
basisOnActive =
    { basisDefault
        | background = Just (hex "#BABBBC")
        , color = Just (rgba 0 0 0 0.9)
    }


basic : Palette
basic =
    { background = Just (rgba 0 0 0 0)
    , color = Just textColor
    , border = Just transparent_
    }


basicOnHover : Palette
basicOnHover =
    { basic
        | background = Just (hex "#FFFFFF")
        , color = Just hoverColor
    }


basicOnFocus : Palette
basicOnFocus =
    basicOnHover


basicOnActive : Palette
basicOnActive =
    { basic
        | background = Just (hex "#F8F8F8")
        , color = Just (rgba 0 0 0 0.9)
    }
