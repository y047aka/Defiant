module UI.Label exposing (Options, basicLabel, label, labelWithOption)

import Css exposing (..)
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
labelWithOption { palette } =
    basis <|
        case palette of
            Primary ->
                [ -- .ui.primary.label
                  backgroundColor (hex "#2185D0")
                , borderColor (hex "#2185D0")
                , color (rgba 255 255 255 0.9)
                ]

            Secondary ->
                [ -- .ui.secondary.label
                  backgroundColor (hex "#1B1C1D")
                , borderColor (hex "#1B1C1D")
                , color (rgba 255 255 255 0.9)
                ]

            Red ->
                [ -- .ui.red.label
                  backgroundColor (hex "#DB2828")
                , borderColor (hex "#DB2828")
                , color (hex "#FFFFFF")
                ]

            Orange ->
                [ -- .ui.red.label
                  backgroundColor (hex "#F2711C")
                , borderColor (hex "#F2711C")
                , color (hex "#FFFFFF")
                ]

            Yellow ->
                [ -- .ui.yellow.label
                  backgroundColor (hex "#FBBD08")
                , borderColor (hex "#FBBD08")
                , color (hex "#FFFFFF")
                ]

            Olive ->
                [ -- .ui.olive.label
                  backgroundColor (hex "#B5CC18")
                , borderColor (hex "#B5CC18")
                , color (hex "#FFFFFF")
                ]

            Green ->
                [ -- .ui.green.label
                  backgroundColor (hex "#21BA45")
                , borderColor (hex "#21BA45")
                , color (hex "#FFFFFF")
                ]

            Teal ->
                [ -- .ui.teal.label
                  backgroundColor (hex "#00B5AD")
                , borderColor (hex "#00B5AD")
                , color (hex "#FFFFFF")
                ]

            Blue ->
                [ -- .ui.blue.label
                  backgroundColor (hex "#2185D0")
                , borderColor (hex "#2185D0")
                , color (hex "#FFFFFF")
                ]

            Violet ->
                [ -- .ui.violet.label
                  backgroundColor (hex "#6435C9")
                , borderColor (hex "#6435C9")
                , color (hex "#FFFFFF")
                ]

            Purple ->
                [ -- .ui.purple.label
                  backgroundColor (hex "#A333C8")
                , borderColor (hex "#A333C8")
                , color (hex "#FFFFFF")
                ]

            Pink ->
                [ -- .ui.pink.label
                  backgroundColor (hex "#E03997")
                , borderColor (hex "#E03997")
                , color (hex "#FFFFFF")
                ]

            Brown ->
                [ -- .ui.brown.label
                  backgroundColor (hex "#A5673F")
                , borderColor (hex "#A5673F")
                , color (hex "#FFFFFF")
                ]

            Grey ->
                [ -- .ui.grey.label
                  backgroundColor (hex "#767676")
                , borderColor (hex "#767676")
                , color (hex "#FFFFFF")
                ]

            Black ->
                [ -- .ui.black.label
                  backgroundColor (hex "#1B1C1D")
                , borderColor (hex "#1B1C1D")
                , color (hex "#FFFFFF")
                ]
