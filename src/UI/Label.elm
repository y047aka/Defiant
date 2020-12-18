module UI.Label exposing (Options, basicLabel, label, labelWithOption)

import Css exposing (..)
import Css.Extra exposing (palette)
import Css.Palette exposing (..)
import Html.Styled as Html exposing (Attribute, Html)
import UI.Modifier exposing (Palette(..))


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.label
          display inlineBlock
        , lineHeight (int 1)
        , verticalAlign baseline
        , margin2 zero (em 0.14285714)
        , backgroundColor (hex "#E8E8E8")
        , backgroundImage none
        , padding2 (em 0.5833) (em 0.833)
        , color (rgba 0 0 0 0.6)
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
    basis []


basicLabel : List (Attribute msg) -> List (Html msg) -> Html msg
basicLabel =
    basis
        [ -- .ui.basic.label
          backgroundColor (hex "#FFFFFF")
        , border3 (px 1) solid (rgba 34 36 38 0.15)
        , color (rgba 0 0 0 0.87)
        , property "-webkit-box-shadow" "none"
        , boxShadow none
        , paddingTop <| em 0.5833
        , paddingBottom <| em 0.5833
        , paddingRight <| em 0.833

        -- .ui.basic.label:not(.tag):not(.image):not(.ribbon)
        , paddingLeft <| em 0.833
        ]


type alias Options =
    { palette : Palette }


labelWithOption : Options -> List (Attribute msg) -> List (Html msg) -> Html msg
labelWithOption options =
    basis
        [ -- .ui.xxx.label
          palette <|
            case options.palette of
                Primary ->
                    { primary | color = rgba 255 255 255 0.9 }

                Secondary ->
                    { secondary | color = rgba 255 255 255 0.9 }

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
                    pink

                Brown ->
                    brown

                Grey ->
                    grey

                Black ->
                    black
        ]
