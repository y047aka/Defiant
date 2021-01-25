module UI.Text exposing
    ( primaryText, secondaryText
    , redText, orangeText, yellowText, oliveText, greenText, tealText, blueText, violetText, purpleText, pinkText, brownText, greyText, blackText
    , errorText, infoText, successText, warningText, disabledText
    , miniText, tinyText, smallText, mediumText, largeText, bigText, hugeText, massiveText
    )

{-|

@docs primaryText, secondaryText
@docs redText, orangeText, yellowText, oliveText, greenText, tealText, blueText, violetText, purpleText, pinkText, brownText, greyText, blackText
@docs errorText, infoText, successText, warningText, disabledText
@docs miniText, tinyText, smallText, mediumText, largeText, bigText, hugeText, massiveText

-}

import Css exposing (..)
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (css)


coloredText : Color -> String -> Html msg
coloredText color_ str =
    Html.span
        [ css [ color color_ ] ]
        [ text str ]


primaryText : String -> Html msg
primaryText =
    blueText


secondaryText : String -> Html msg
secondaryText =
    blackText


redText : String -> Html msg
redText =
    coloredText red


orangeText : String -> Html msg
orangeText =
    coloredText orange


yellowText : String -> Html msg
yellowText =
    coloredText yellow


oliveText : String -> Html msg
oliveText =
    coloredText olive


greenText : String -> Html msg
greenText =
    coloredText green


tealText : String -> Html msg
tealText =
    coloredText teal


blueText : String -> Html msg
blueText =
    coloredText blue


violetText : String -> Html msg
violetText =
    coloredText violet


purpleText : String -> Html msg
purpleText =
    coloredText purple


pinkText : String -> Html msg
pinkText =
    coloredText pink


brownText : String -> Html msg
brownText =
    coloredText brown


greyText : String -> Html msg
greyText =
    coloredText grey


blackText : String -> Html msg
blackText =
    coloredText black


errorText : String -> Html msg
errorText =
    coloredText error


infoText : String -> Html msg
infoText =
    coloredText info


successText : String -> Html msg
successText =
    coloredText success


warningText : String -> Html msg
warningText =
    coloredText warning


disabledText : String -> Html msg
disabledText str =
    -- span.ui.disabled.text
    Html.span [ css [ opacity (num 0.45) ] ] [ text str ]


miniText : String -> Html msg
miniText str =
    -- span.ui.mini.text
    Html.span [ css [ fontSize (em 0.4) ] ] [ text str ]


tinyText : String -> Html msg
tinyText str =
    -- span.ui.tiny.text
    Html.span [ css [ fontSize (em 0.5) ] ] [ text str ]


smallText : String -> Html msg
smallText str =
    -- span.ui.small.text
    Html.span [ css [ fontSize (em 0.75) ] ] [ text str ]


mediumText : String -> Html msg
mediumText str =
    -- span.ui.medium.text
    Html.span [ css [ fontSize (em 1) ] ] [ text str ]


largeText : String -> Html msg
largeText str =
    -- span.ui.large.text
    Html.span [ css [ fontSize (em 1.5) ] ] [ text str ]


bigText : String -> Html msg
bigText str =
    -- span.ui.big.text
    Html.span [ css [ fontSize (em 2) ] ] [ text str ]


hugeText : String -> Html msg
hugeText str =
    -- span.ui.huge.text
    Html.span [ css [ fontSize (em 4) ] ] [ text str ]


massiveText : String -> Html msg
massiveText str =
    -- span.ui.massive.text
    Html.span [ css [ fontSize (em 8) ] ] [ text str ]



-- COLOR


red : Color
red =
    -- span.ui.red.text
    hex "#DB2828"


orange : Color
orange =
    -- span.ui.orange.text
    hex "#F2711C"


yellow : Color
yellow =
    -- span.ui.yellow.text
    hex "#FBBD08"


olive : Color
olive =
    -- span.ui.olive.text
    hex "#B5CC18"


green : Color
green =
    -- span.ui.green.text
    hex "#21BA45"


teal : Color
teal =
    -- span.ui.teal.text
    hex "#00B5AD"


blue : Color
blue =
    -- span.ui.blue.text
    hex "#2185D0"


violet : Color
violet =
    -- span.ui.violet.text
    hex "#6435C9"


purple : Color
purple =
    -- span.ui.purple.text
    hex "#A333C8"


pink : Color
pink =
    -- span.ui.pink.text
    hex "#E03997"


brown : Color
brown =
    -- span.ui.brown.text
    hex "#A5673F"


grey : Color
grey =
    -- span.ui.grey.text
    hex "#767676"


black : Color
black =
    -- span.ui.black.text
    hex "#1B1C1D"


error : Color
error =
    red


info : Color
info =
    -- span.ui.info.text
    hex "#31CCEC"


success : Color
success =
    green


warning : Color
warning =
    -- span.ui.warning.text
    hex "#F2C037"
