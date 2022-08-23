module UI.Label exposing
    ( basis
    , label, labelWithProps, basicLabel
    , primaryLabel, secondaryLabel
    , redLabel, orangeLabel, yellowLabel, oliveLabel, greenLabel, tealLabel, blueLabel, violetLabel, purpleLabel, pinkLabel, brownLabel, greyLabel, blackLabel
    )

{-|

@docs basis
@docs label, labelWithProps, basicLabel
@docs primaryLabel, secondaryLabel
@docs redLabel, orangeLabel, yellowLabel, oliveLabel, greenLabel, tealLabel, blueLabel, violetLabel, purpleLabel, pinkLabel, brownLabel, greyLabel, blackLabel

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children)
import Css.Layout as Layout exposing (layout)
import Css.Palette as Palette exposing (Palette, palette, setBackground, setColor, textColor)
import Css.Typography as Typography exposing (setFontSize, setFontWeight, setLineHeight, setTextTransform, typography)
import Data exposing (PresetColor(..))
import Data.PalettesByState as PalettesByState exposing (black, blue)
import Html.Styled as Html exposing (Attribute, Html)


type alias Props =
    { border : Bool
    , palette : Maybe Palette
    , additionalStyles : List Style
    }


labelWithProps : Props -> List (Attribute msg) -> List (Html msg) -> Html msg
labelWithProps { border, palette, additionalStyles } =
    basis { border = border, palette = palette } additionalStyles


basis : { border : Bool, palette : Maybe Palette } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis options additionalStyles =
    Html.styled Html.div
        [ -- .ui.label
          display inlineBlock
        , layout Layout.default
        , typography
            (Typography.init
                |> setFontSize (rem 0.85714286)
                |> setFontWeight bold
                |> setLineHeight (int 1)
                |> setTextTransform none
            )
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
    labelWithProps defaultProps


defaultProps : Props
defaultProps =
    { border = False, palette = Nothing, additionalStyles = [] }


basicLabel : List (Attribute msg) -> List (Html msg) -> Html msg
basicLabel =
    labelWithProps
        { border = True
        , palette =
            basis_
                |> setBackground (hex "#FFFFFF")
                |> setColor (rgba 0 0 0 0.87)
                |> Just
        , additionalStyles =
            [ -- .ui.basic.label
              prefixed [] "box-shadow" "none"
            ]
        }


primaryLabel : List (Attribute msg) -> List (Html msg) -> Html msg
primaryLabel =
    labelWithProps { defaultProps | palette = Just (blue.default |> setColor (rgba 255 255 255 0.9)) }


secondaryLabel : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryLabel =
    labelWithProps { defaultProps | palette = Just (black.default |> setColor (rgba 255 255 255 0.9)) }


coloredLabel : PresetColor -> List (Attribute msg) -> List (Html msg) -> Html msg
coloredLabel color =
    labelWithProps { defaultProps | palette = Just (PalettesByState.fromPresetColor color |> .default) }


redLabel : List (Attribute msg) -> List (Html msg) -> Html msg
redLabel =
    coloredLabel Red


orangeLabel : List (Attribute msg) -> List (Html msg) -> Html msg
orangeLabel =
    coloredLabel Orange


yellowLabel : List (Attribute msg) -> List (Html msg) -> Html msg
yellowLabel =
    coloredLabel Yellow


oliveLabel : List (Attribute msg) -> List (Html msg) -> Html msg
oliveLabel =
    coloredLabel Olive


greenLabel : List (Attribute msg) -> List (Html msg) -> Html msg
greenLabel =
    coloredLabel Green


tealLabel : List (Attribute msg) -> List (Html msg) -> Html msg
tealLabel =
    coloredLabel Teal


blueLabel : List (Attribute msg) -> List (Html msg) -> Html msg
blueLabel =
    coloredLabel Blue


violetLabel : List (Attribute msg) -> List (Html msg) -> Html msg
violetLabel =
    coloredLabel Violet


purpleLabel : List (Attribute msg) -> List (Html msg) -> Html msg
purpleLabel =
    coloredLabel Purple


pinkLabel : List (Attribute msg) -> List (Html msg) -> Html msg
pinkLabel =
    coloredLabel Pink


brownLabel : List (Attribute msg) -> List (Html msg) -> Html msg
brownLabel =
    coloredLabel Brown


greyLabel : List (Attribute msg) -> List (Html msg) -> Html msg
greyLabel =
    coloredLabel Grey


blackLabel : List (Attribute msg) -> List (Html msg) -> Html msg
blackLabel =
    coloredLabel Black



-- PALETTE


basis_ : Palette
basis_ =
    { background = Just (hex "#E8E8E8")
    , color = Just textColor
    , border = Just Palette.transparent
    , shadow = Nothing
    }
