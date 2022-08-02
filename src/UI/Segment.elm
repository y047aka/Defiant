module UI.Segment exposing
    ( segment, basicSegment
    , disabledSegment
    , verticalSegment
    , paddedSegment, veryPaddedSegment
    , invertedSegment
    )

{-|

@docs segment, basicSegment
@docs disabledSegment
@docs verticalSegment
@docs paddedSegment, veryPaddedSegment
@docs invertedSegment

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Media exposing (withMediaQuery)
import Css.Palette as Palette exposing (paletteWith, setBackground, setBackgroundIf, setBorderIf, setColor)
import Data.Theme exposing (Theme(..), isDark)
import Html.Styled as Html exposing (Attribute, Html)


basis : { border : Bool, shadow : Bool, theme : Theme } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { border, shadow, theme } additionalStyles =
    let
        defaultPalette =
            Palette.init
                |> setBackgroundIf shadow (hex "#FFF")
                |> setBorderIf border (rgba 34 36 38 0.15)

        invertedPalette =
            Palette.init
                |> setBackground (hex "#1B1C1D")
                |> setColor (rgba 255 255 255 0.9)
    in
    Html.styled Html.section
        [ position relative
        , margin2 (rem 1) zero
        , padding2 (em 1) (em 1)
        , if shadow then
            borderRadius (rem 0.28571429)

          else
            batch []
        , paletteWith { border = border3 (px 1) solid } <|
            if isDark theme then
                invertedPalette

            else
                defaultPalette
        , withMediaQuery [ "(prefers-color-scheme: dark)" ]
            [ paletteWith { border = border3 (px 1) solid } invertedPalette ]
        , case ( shadow, isDark theme ) of
            ( True, False ) ->
                prefixed [] "box-shadow" "0 1px 2px 0 rgba(34, 36, 38, 0.15)"

            _ ->
                batch []

        -- .ui.segment:first-child
        , pseudoClass "first-child"
            [ marginTop zero ]

        -- .ui.segment:last-child
        , pseudoClass "last-child"
            [ marginBottom zero ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


segment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
segment { theme } =
    basis { border = True, shadow = True, theme = theme } []


verticalSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
verticalSegment { theme } =
    basis { border = False, shadow = False, theme = theme }
        [ -- .ui.vertical.segment
          margin zero
        , paddingLeft zero
        , paddingRight zero
        , borderBottom3 (px 1) solid (rgba 34 36 38 0.15)

        -- .ui.vertical.segment:last-child
        , lastChild
            [ property "border-bottom" "none" ]
        ]


disabledSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
disabledSegment { theme } =
    basis { border = True, shadow = True, theme = theme }
        [ -- .ui.disabled.segment
          opacity (num 0.45)
        , color (rgba 40 40 40 0.3)
        ]


paddedSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
paddedSegment { theme } =
    basis { border = True, shadow = True, theme = theme }
        [ -- .ui.padded.segment
          padding (em 1.5)
        ]


veryPaddedSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
veryPaddedSegment { theme } =
    basis { border = True, shadow = True, theme = theme }
        [ -- .ui[class*="very padded"].segment
          padding (em 3)
        ]


basicSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
basicSegment { theme } =
    -- .ui.basic.segment
    -- .ui.segments .ui.basic.segment
    -- .ui.basic.segments
    basis { border = False, shadow = False, theme = theme } []


invertedSegment : List (Attribute msg) -> List (Html msg) -> Html msg
invertedSegment =
    basis { border = True, shadow = True, theme = Dark } []
