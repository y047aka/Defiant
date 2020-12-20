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
redText str =
    -- span.ui.red.text
    coloredText (hex "#DB2828") str


orangeText : String -> Html msg
orangeText str =
    -- span.ui.orange.text
    coloredText (hex "#F2711C") str


yellowText : String -> Html msg
yellowText str =
    -- span.ui.yellow.text
    coloredText (hex "#FBBD08") str


oliveText : String -> Html msg
oliveText str =
    -- span.ui.olive.text
    coloredText (hex "#B5CC18") str


greenText : String -> Html msg
greenText str =
    -- span.ui.green.text
    coloredText (hex "#21BA45") str


tealText : String -> Html msg
tealText str =
    -- span.ui.teal.text
    coloredText (hex "#00B5AD") str


blueText : String -> Html msg
blueText str =
    -- span.ui.blue.text
    coloredText (hex "#2185D0") str


violetText : String -> Html msg
violetText str =
    -- span.ui.violet.text
    coloredText (hex "#6435C9") str


purpleText : String -> Html msg
purpleText str =
    -- span.ui.purple.text
    coloredText (hex "#A333C8") str


pinkText : String -> Html msg
pinkText str =
    -- span.ui.pink.text
    coloredText (hex "#E03997") str


brownText : String -> Html msg
brownText str =
    -- span.ui.brown.text
    coloredText (hex "#A5673F") str


greyText : String -> Html msg
greyText str =
    -- span.ui.grey.text
    coloredText (hex "#767676") str


blackText : String -> Html msg
blackText str =
    -- span.ui.black.text
    coloredText (hex "#1B1C1D") str


errorText : String -> Html msg
errorText =
    redText


infoText : String -> Html msg
infoText str =
    -- span.ui.info.text
    coloredText (hex "#31CCEC") str


successText : String -> Html msg
successText =
    greenText


warningText : String -> Html msg
warningText str =
    -- span.ui.warning.text
    coloredText (hex "#F2C037") str


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
