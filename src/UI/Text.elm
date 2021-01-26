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
import Css.Color as Color exposing (..)
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (css)


coloredText : Color -> String -> Html msg
coloredText color_ str =
    Html.span
        [ css [ color color_ ] ]
        [ text str ]


primaryText : { inverted : Bool } -> String -> Html msg
primaryText =
    blueText


secondaryText : { inverted : Bool } -> String -> Html msg
secondaryText =
    blackText


redText : { inverted : Bool } -> String -> Html msg
redText { inverted } =
    coloredText <| colorSelector inverted ( red, hex "#FF695E" )


orangeText : { inverted : Bool } -> String -> Html msg
orangeText { inverted } =
    coloredText <| colorSelector inverted ( orange, hex "#FF851B" )


yellowText : { inverted : Bool } -> String -> Html msg
yellowText { inverted } =
    coloredText <| colorSelector inverted ( yellow, hex "#FFE21F" )


oliveText : { inverted : Bool } -> String -> Html msg
oliveText { inverted } =
    coloredText <| colorSelector inverted ( olive, hex "#D9E778" )


greenText : { inverted : Bool } -> String -> Html msg
greenText { inverted } =
    coloredText <| colorSelector inverted ( green, hex "#2ECC40" )


tealText : { inverted : Bool } -> String -> Html msg
tealText { inverted } =
    coloredText <| colorSelector inverted ( teal, hex "#6DFFFF" )


blueText : { inverted : Bool } -> String -> Html msg
blueText { inverted } =
    coloredText <| colorSelector inverted ( blue, hex "#54C8FF" )


violetText : { inverted : Bool } -> String -> Html msg
violetText { inverted } =
    coloredText <| colorSelector inverted ( violet, hex "#A291FB" )


purpleText : { inverted : Bool } -> String -> Html msg
purpleText { inverted } =
    coloredText <| colorSelector inverted ( purple, hex "#DC73FF" )


pinkText : { inverted : Bool } -> String -> Html msg
pinkText { inverted } =
    coloredText <| colorSelector inverted ( pink, hex "#FF8EDF" )


brownText : { inverted : Bool } -> String -> Html msg
brownText { inverted } =
    coloredText <| colorSelector inverted ( brown, hex "#D67C1C" )


greyText : { inverted : Bool } -> String -> Html msg
greyText { inverted } =
    coloredText <| colorSelector inverted ( grey, hex "#DCDDDE" )


blackText : { inverted : Bool } -> String -> Html msg
blackText { inverted } =
    coloredText <| colorSelector inverted ( black, hex "#545454" )


colorSelector : Bool -> ( Color, Color ) -> Color
colorSelector isInverted ( default, inverted ) =
    if isInverted then
        inverted

    else
        default


infoText : String -> Html msg
infoText =
    coloredText Color.info


successText : String -> Html msg
successText =
    coloredText Color.success


warningText : String -> Html msg
warningText =
    coloredText Color.warning


errorText : String -> Html msg
errorText =
    coloredText Color.error


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
