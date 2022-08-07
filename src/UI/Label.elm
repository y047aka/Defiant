module UI.Label exposing
    ( basis
    , label, basicLabel
    , primaryLabel, secondaryLabel
    , redLabel, orangeLabel, yellowLabel, oliveLabel, greenLabel, tealLabel, blueLabel, violetLabel, purpleLabel, pinkLabel, brownLabel, greyLabel, blackLabel
    )

{-|

@docs basis
@docs label, basicLabel
@docs primaryLabel, secondaryLabel
@docs redLabel, orangeLabel, yellowLabel, oliveLabel, greenLabel, tealLabel, blueLabel, violetLabel, purpleLabel, pinkLabel, brownLabel, greyLabel, blackLabel

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children)
import Css.Layout as Layout exposing (layout)
import Css.Palette as Palette exposing (Palette, palette, setColor, textColor)
import Css.Typography as Typography exposing (typography)
import Data.PalettesByState exposing (..)
import Html.Styled as Html exposing (Attribute, Html)


basis : { border : Bool, palette : Maybe Palette } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis options additionalStyles =
    let
        initialTypography =
            Typography.init
    in
    Html.styled Html.div
        [ -- .ui.label
          display inlineBlock
        , layout Layout.default
        , typography
            { initialTypography
                | lineHeight = Typography.int 1
                , fontSize = Typography.rem 0.85714286
                , fontWeight = Typography.bold
                , textTransform = Typography.none
            }
        , margin2 zero (em 0.14285714)
        , backgroundImage none
        , palette <| Maybe.withDefault basis_ options.palette
        , batch <|
            if options.border then
                -- .ui.basic.label
                [ border3 (px 1) solid (rgba 34 36 38 0.15)
                , property "padding-top" "calc(0.5833em - 1px)"
                , property "padding-bottom" "calc(0.5833em - 1px)"
                , property "padding-right" "calc(0.833em - 1px)"

                -- .ui.basic.label:not(.tag):not(.image):not(.ribbon)
                , property "padding-left" "calc(0.833em - 1px)"
                ]

            else
                [ padding2 (em 0.5833) (em 0.833)
                , border3 zero solid transparent
                ]
        , borderRadius (rem 0.28571429)
        , property "-webkit-transition" "background 0.1s ease"
        , property "transition" "background 0.1s ease"

        -- .ui.label:first-child
        , firstChild
            [ marginLeft zero ]

        -- .ui.label:last-child
        , lastChild
            [ marginRight zero ]

        -- .ui.left.icon.label > .icon
        -- .ui.label > .icon
        , children
            [ Css.Global.i
                [ width auto
                , margin4 zero (em 0.75) zero zero
                ]
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    basis { border = False, palette = Nothing } []


basicLabel : List (Attribute msg) -> List (Html msg) -> Html msg
basicLabel =
    basis { border = True, palette = Just basic }
        [ -- .ui.basic.label
          prefixed [] "box-shadow" "none"
        ]


coloredLabel : Palette -> List (Attribute msg) -> List (Html msg) -> Html msg
coloredLabel palettes =
    basis { border = False, palette = Just palettes } []


primaryLabel : List (Attribute msg) -> List (Html msg) -> Html msg
primaryLabel =
    coloredLabel (blue.default |> setColor (rgba 255 255 255 0.9))


secondaryLabel : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryLabel =
    coloredLabel (black.default |> setColor (rgba 255 255 255 0.9))


redLabel : List (Attribute msg) -> List (Html msg) -> Html msg
redLabel =
    coloredLabel red.default


orangeLabel : List (Attribute msg) -> List (Html msg) -> Html msg
orangeLabel =
    coloredLabel orange.default


yellowLabel : List (Attribute msg) -> List (Html msg) -> Html msg
yellowLabel =
    coloredLabel yellow.default


oliveLabel : List (Attribute msg) -> List (Html msg) -> Html msg
oliveLabel =
    coloredLabel olive.default


greenLabel : List (Attribute msg) -> List (Html msg) -> Html msg
greenLabel =
    coloredLabel green.default


tealLabel : List (Attribute msg) -> List (Html msg) -> Html msg
tealLabel =
    coloredLabel teal.default


blueLabel : List (Attribute msg) -> List (Html msg) -> Html msg
blueLabel =
    coloredLabel blue.default


violetLabel : List (Attribute msg) -> List (Html msg) -> Html msg
violetLabel =
    coloredLabel violet.default


purpleLabel : List (Attribute msg) -> List (Html msg) -> Html msg
purpleLabel =
    coloredLabel purple.default


pinkLabel : List (Attribute msg) -> List (Html msg) -> Html msg
pinkLabel =
    coloredLabel pink.default


brownLabel : List (Attribute msg) -> List (Html msg) -> Html msg
brownLabel =
    coloredLabel brown.default


greyLabel : List (Attribute msg) -> List (Html msg) -> Html msg
greyLabel =
    coloredLabel grey.default


blackLabel : List (Attribute msg) -> List (Html msg) -> Html msg
blackLabel =
    coloredLabel black.default



-- PALETTE


basis_ : Palette
basis_ =
    { background = Just (hex "#E8E8E8")
    , color = Just textColor
    , border = Just Palette.transparent
    , shadow = Nothing
    }


basic : Palette
basic =
    { background = Just (hex "#FFFFFF")
    , color = Just (rgba 0 0 0 0.87)
    , border = Just Palette.transparent
    , shadow = Nothing
    }
