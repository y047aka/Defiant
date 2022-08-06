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
import Css.Palette as Palette exposing (Palette, darkPalette, palette, setColor)
import Data exposing (PresetColor(..), Size(..))
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, text)


basis :
    { size : Maybe (FontSize a)
    , disabled : Bool
    , additionalStyles : List Style
    }
    -> String
    -> Html msg
basis options str =
    Html.styled Html.span
        [ orNone options.size fontSize
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
        , disabled = True
        , additionalStyles = []
        }


coloredText : Theme -> { defaultPalette : Palette, darkPalette_ : Palette } -> String -> Html msg
coloredText theme { defaultPalette, darkPalette_ } =
    basis
        { size = Nothing
        , disabled = False
        , additionalStyles =
            [ palette defaultPalette
            , darkPalette theme darkPalette_
            ]
        }


primaryText : { theme : Theme } -> String -> Html msg
primaryText =
    blueText


secondaryText : { theme : Theme } -> String -> Html msg
secondaryText =
    blackText


redText : { theme : Theme } -> String -> Html msg
redText { theme } =
    coloredText theme (colorSelector Red)


orangeText : { theme : Theme } -> String -> Html msg
orangeText { theme } =
    coloredText theme (colorSelector Orange)


yellowText : { theme : Theme } -> String -> Html msg
yellowText { theme } =
    coloredText theme (colorSelector Yellow)


oliveText : { theme : Theme } -> String -> Html msg
oliveText { theme } =
    coloredText theme (colorSelector Olive)


greenText : { theme : Theme } -> String -> Html msg
greenText { theme } =
    coloredText theme (colorSelector Green)


tealText : { theme : Theme } -> String -> Html msg
tealText { theme } =
    coloredText theme (colorSelector Teal)


blueText : { theme : Theme } -> String -> Html msg
blueText { theme } =
    coloredText theme (colorSelector Blue)


violetText : { theme : Theme } -> String -> Html msg
violetText { theme } =
    coloredText theme (colorSelector Violet)


purpleText : { theme : Theme } -> String -> Html msg
purpleText { theme } =
    coloredText theme (colorSelector Purple)


pinkText : { theme : Theme } -> String -> Html msg
pinkText { theme } =
    coloredText theme (colorSelector Pink)


brownText : { theme : Theme } -> String -> Html msg
brownText { theme } =
    coloredText theme (colorSelector Brown)


greyText : { theme : Theme } -> String -> Html msg
greyText { theme } =
    coloredText theme (colorSelector Grey)


blackText : { theme : Theme } -> String -> Html msg
blackText { theme } =
    coloredText theme (colorSelector Black)


infoText : String -> Html msg
infoText =
    coloredText Light { defaultPalette = Palette.init |> setColor Color.info, darkPalette_ = Palette.init }


successText : String -> Html msg
successText =
    coloredText Light { defaultPalette = Palette.init |> setColor Color.success, darkPalette_ = Palette.init }


warningText : String -> Html msg
warningText =
    coloredText Light { defaultPalette = Palette.init |> setColor Color.warning, darkPalette_ = Palette.init }


errorText : String -> Html msg
errorText =
    coloredText Light { defaultPalette = Palette.init |> setColor Color.error, darkPalette_ = Palette.init }


colorSelector : PresetColor -> { defaultPalette : Palette, darkPalette_ : Palette }
colorSelector presetColor =
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
    { defaultPalette = Palette.init |> setColor default
    , darkPalette_ = Palette.init |> setColor inverted
    }


sizedText : FontSize a -> String -> Html msg
sizedText size =
    basis
        { size = Just size
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
