module UI.Label exposing
    ( label, basicLabel
    , primaryLabel, secondaryLabel
    , redLabel, orangeLabel, yellowLabel, oliveLabel, greenLabel, tealLabel, blueLabel, violetLabel, purpleLabel, pinkLabel, brownLabel, greyLabel, blackLabel
    )

{-|

@docs label, basicLabel
@docs primaryLabel, secondaryLabel
@docs redLabel, orangeLabel, yellowLabel, oliveLabel, greenLabel, tealLabel, blueLabel, violetLabel, purpleLabel, pinkLabel, brownLabel, greyLabel, blackLabel

-}

import Css exposing (..)
import Css.Palette exposing (..)
import Css.Typography as Typography exposing (init, typography)
import Html.Styled as Html exposing (Attribute, Html)


basis : Maybe Palette -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis maybePalette additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.label
          display inlineBlock
        , typography
            { init
                | lineHeight = Typography.int 1
                , verticalAlign = Typography.baseline
                , fontSize = Typography.rem 0.85714286
                , fontWeight = Typography.bold
                , textTransform = Typography.none
            }
        , margin2 zero (em 0.14285714)
        , backgroundImage none
        , palette <| Maybe.withDefault basis_ maybePalette
        , padding2 (em 0.5833) (em 0.833)
        , border3 zero solid transparent
        , borderRadius (rem 0.28571429)
        , property "-webkit-transition" "background 0.1s ease"
        , property "transition" "background 0.1s ease"

        -- .ui.label:first-child
        , firstChild
            [ marginLeft zero ]

        -- .ui.label:last-child
        , lastChild
            [ marginRight zero ]
        ]
            ++ additionalStyles


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    basis Nothing []


basicLabel : List (Attribute msg) -> List (Html msg) -> Html msg
basicLabel =
    basis (Just basic)
        [ -- .ui.basic.label
          border3 (px 1) solid (rgba 34 36 38 0.15)
        , property "-webkit-box-shadow" "none"
        , boxShadow none
        , paddingTop <| em 0.5833
        , paddingBottom <| em 0.5833
        , paddingRight <| em 0.833

        -- .ui.basic.label:not(.tag):not(.image):not(.ribbon)
        , paddingLeft <| em 0.833
        ]


coloredLabel : Palette -> List (Attribute msg) -> List (Html msg) -> Html msg
coloredLabel palettes =
    basis (Just palettes) []


primaryLabel : List (Attribute msg) -> List (Html msg) -> Html msg
primaryLabel =
    coloredLabel { primary | color = rgba 255 255 255 0.9 }


secondaryLabel : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryLabel =
    coloredLabel { secondary | color = rgba 255 255 255 0.9 }


redLabel : List (Attribute msg) -> List (Html msg) -> Html msg
redLabel =
    coloredLabel red


orangeLabel : List (Attribute msg) -> List (Html msg) -> Html msg
orangeLabel =
    coloredLabel orange


yellowLabel : List (Attribute msg) -> List (Html msg) -> Html msg
yellowLabel =
    coloredLabel yellow


oliveLabel : List (Attribute msg) -> List (Html msg) -> Html msg
oliveLabel =
    coloredLabel olive


greenLabel : List (Attribute msg) -> List (Html msg) -> Html msg
greenLabel =
    coloredLabel green


tealLabel : List (Attribute msg) -> List (Html msg) -> Html msg
tealLabel =
    coloredLabel teal


blueLabel : List (Attribute msg) -> List (Html msg) -> Html msg
blueLabel =
    coloredLabel blue


violetLabel : List (Attribute msg) -> List (Html msg) -> Html msg
violetLabel =
    coloredLabel violet


purpleLabel : List (Attribute msg) -> List (Html msg) -> Html msg
purpleLabel =
    coloredLabel purple


pinkLabel : List (Attribute msg) -> List (Html msg) -> Html msg
pinkLabel =
    coloredLabel pink


brownLabel : List (Attribute msg) -> List (Html msg) -> Html msg
brownLabel =
    coloredLabel brown


greyLabel : List (Attribute msg) -> List (Html msg) -> Html msg
greyLabel =
    coloredLabel grey


blackLabel : List (Attribute msg) -> List (Html msg) -> Html msg
blackLabel =
    coloredLabel black



-- PALETTE


basis_ : Palette
basis_ =
    { background = hex "#E8E8E8"
    , color = textColor
    , border = transparent_
    }


basic : Palette
basic =
    { background = hex "#FFFFFF"
    , color = rgba 0 0 0 0.87
    , border = transparent_
    }
