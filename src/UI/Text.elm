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
import Css.Extra exposing (orNone)
import Html.Styled as Html exposing (Html, text)


basis :
    { size : Maybe (FontSize a)
    , color : Maybe Color
    , disabled : Bool
    , additionalStyles : List Style
    }
    -> String
    -> Html msg
basis options str =
    Html.styled Html.span
        [ orNone options.size fontSize
        , orNone options.color color
        , if options.disabled then
            opacity (num 0.45)

          else
            batch []

        -- AdditionalStyles
        , batch options.additionalStyles
        ]
        []
        [ text str ]


disabledText : String -> Html msg
disabledText =
    -- span.ui.disabled.text
    basis
        { size = Nothing
        , color = Nothing
        , disabled = True
        , additionalStyles = []
        }


type PresetColor
    = Red
    | Orange
    | Yellow
    | Olive
    | Green
    | Teal
    | Blue
    | Violet
    | Purple
    | Pink
    | Brown
    | Grey
    | Black


coloredText : Color -> String -> Html msg
coloredText color_ =
    basis
        { size = Nothing
        , color = Just color_
        , disabled = False
        , additionalStyles = []
        }


primaryText : { inverted : Bool } -> String -> Html msg
primaryText =
    blueText


secondaryText : { inverted : Bool } -> String -> Html msg
secondaryText =
    blackText


redText : { inverted : Bool } -> String -> Html msg
redText { inverted } =
    coloredText (colorSelector Red inverted)


orangeText : { inverted : Bool } -> String -> Html msg
orangeText { inverted } =
    coloredText (colorSelector Orange inverted)


yellowText : { inverted : Bool } -> String -> Html msg
yellowText { inverted } =
    coloredText (colorSelector Yellow inverted)


oliveText : { inverted : Bool } -> String -> Html msg
oliveText { inverted } =
    coloredText (colorSelector Olive inverted)


greenText : { inverted : Bool } -> String -> Html msg
greenText { inverted } =
    coloredText (colorSelector Green inverted)


tealText : { inverted : Bool } -> String -> Html msg
tealText { inverted } =
    coloredText (colorSelector Teal inverted)


blueText : { inverted : Bool } -> String -> Html msg
blueText { inverted } =
    coloredText (colorSelector Blue inverted)


violetText : { inverted : Bool } -> String -> Html msg
violetText { inverted } =
    coloredText (colorSelector Violet inverted)


purpleText : { inverted : Bool } -> String -> Html msg
purpleText { inverted } =
    coloredText (colorSelector Purple inverted)


pinkText : { inverted : Bool } -> String -> Html msg
pinkText { inverted } =
    coloredText (colorSelector Pink inverted)


brownText : { inverted : Bool } -> String -> Html msg
brownText { inverted } =
    coloredText (colorSelector Brown inverted)


greyText : { inverted : Bool } -> String -> Html msg
greyText { inverted } =
    coloredText (colorSelector Grey inverted)


blackText : { inverted : Bool } -> String -> Html msg
blackText { inverted } =
    coloredText (colorSelector Black inverted)


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


colorSelector : PresetColor -> Bool -> Color
colorSelector presetColor isInverted =
    let
        ( default, inverted ) =
            case presetColor of
                Red ->
                    ( red, hex "#FF695E" )

                Orange ->
                    ( orange, hex "#FF851B" )

                Yellow ->
                    ( yellow, hex "#FFE21F" )

                Olive ->
                    ( olive, hex "#D9E778" )

                Green ->
                    ( green, hex "#2ECC40" )

                Teal ->
                    ( teal, hex "#6DFFFF" )

                Blue ->
                    ( blue, hex "#54C8FF" )

                Violet ->
                    ( violet, hex "#A291FB" )

                Purple ->
                    ( purple, hex "#DC73FF" )

                Pink ->
                    ( pink, hex "#FF8EDF" )

                Brown ->
                    ( brown, hex "#D67C1C" )

                Grey ->
                    ( grey, hex "#DCDDDE" )

                Black ->
                    ( black, hex "#545454" )
    in
    if isInverted then
        inverted

    else
        default


type Size
    = Massive
    | Huge
    | Big
    | Large
    | Medium
    | Small
    | Tiny
    | Mini


sizedText : FontSize a -> String -> Html msg
sizedText size =
    basis
        { size = Just size
        , color = Nothing
        , disabled = False
        , additionalStyles = []
        }


miniText : String -> Html msg
miniText =
    -- span.ui.mini.text
    sizedText (sizeSelector Mini)


tinyText : String -> Html msg
tinyText =
    -- span.ui.tiny.text
    sizedText (sizeSelector Tiny)


smallText : String -> Html msg
smallText =
    -- span.ui.small.text
    sizedText (sizeSelector Small)


mediumText : String -> Html msg
mediumText =
    -- span.ui.medium.text
    sizedText (sizeSelector Medium)


largeText : String -> Html msg
largeText =
    -- span.ui.large.text
    sizedText (sizeSelector Large)


bigText : String -> Html msg
bigText =
    -- span.ui.big.text
    sizedText (sizeSelector Big)


hugeText : String -> Html msg
hugeText =
    -- span.ui.huge.text
    sizedText (sizeSelector Huge)


massiveText : String -> Html msg
massiveText =
    -- span.ui.massive.text
    sizedText (sizeSelector Massive)


sizeSelector : Size -> Css.Em
sizeSelector size =
    case size of
        Massive ->
            em 8

        Huge ->
            em 4

        Big ->
            em 2

        Large ->
            em 1.5

        Medium ->
            em 1

        Small ->
            em 0.75

        Tiny ->
            em 0.5

        Mini ->
            em 0.4
