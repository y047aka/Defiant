module UI.Label exposing (Options, basicLabel, label, labelWithOption)

import Css exposing (..)
import Css.Extra exposing (palette)
import Css.Palette exposing (..)
import Html.Styled as Html exposing (Attribute, Html)
import UI.Modifier as Modifier


basis : Maybe Palette -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis maybePalette additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.label
          display inlineBlock
        , lineHeight (int 1)
        , verticalAlign baseline
        , margin2 zero (em 0.14285714)
        , backgroundImage none
        , palette <| Maybe.withDefault basis_ maybePalette
        , padding2 (em 0.5833) (em 0.833)
        , textTransform none
        , fontWeight bold
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

        -- .ui.label
        , fontSize (rem 0.85714286)
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


type alias Options =
    { palette : Modifier.Palette }


labelWithOption : Options -> List (Attribute msg) -> List (Html msg) -> Html msg
labelWithOption options =
    let
        palette_ =
            case options.palette of
                Modifier.Primary ->
                    { primary | color = rgba 255 255 255 0.9 }

                Modifier.Secondary ->
                    { secondary | color = rgba 255 255 255 0.9 }

                Modifier.Red ->
                    red

                Modifier.Orange ->
                    orange

                Modifier.Yellow ->
                    yellow

                Modifier.Olive ->
                    olive

                Modifier.Green ->
                    green

                Modifier.Teal ->
                    teal

                Modifier.Blue ->
                    blue

                Modifier.Violet ->
                    violet

                Modifier.Purple ->
                    purple

                Modifier.Pink ->
                    pink

                Modifier.Brown ->
                    brown

                Modifier.Grey ->
                    grey

                Modifier.Black ->
                    black
    in
    basis (Just palette_) []



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
