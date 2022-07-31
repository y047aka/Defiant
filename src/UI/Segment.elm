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
import Css.Palette as Palette exposing (paletteWith, setBackground, setBackgroundIf, setBorderIf, setColor)
import Html.Styled as Html exposing (Attribute, Html)


basis : { border : Bool, shadow : Bool, inverted : Bool } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { border, shadow, inverted } additionalStyles =
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
            if inverted then
                invertedPalette

            else
                defaultPalette
        , case ( shadow, inverted ) of
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


segment : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
segment { inverted } =
    basis { border = True, shadow = True, inverted = inverted } []


verticalSegment : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
verticalSegment { inverted } =
    basis { border = False, shadow = False, inverted = inverted }
        [ -- .ui.vertical.segment
          margin zero
        , paddingLeft zero
        , paddingRight zero
        , borderBottom3 (px 1) solid (rgba 34 36 38 0.15)

        -- .ui.vertical.segment:last-child
        , lastChild
            [ property "border-bottom" "none" ]
        ]


disabledSegment : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
disabledSegment { inverted } =
    basis { border = True, shadow = True, inverted = inverted }
        [ -- .ui.disabled.segment
          opacity (num 0.45)
        , color (rgba 40 40 40 0.3)
        ]


paddedSegment : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
paddedSegment { inverted } =
    basis { border = True, shadow = True, inverted = inverted }
        [ -- .ui.padded.segment
          padding (em 1.5)
        ]


veryPaddedSegment : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
veryPaddedSegment { inverted } =
    basis { border = True, shadow = True, inverted = inverted }
        [ -- .ui[class*="very padded"].segment
          padding (em 3)
        ]


basicSegment : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
basicSegment { inverted } =
    -- .ui.basic.segment
    -- .ui.segments .ui.basic.segment
    -- .ui.basic.segments
    basis { border = False, shadow = False, inverted = inverted } []


invertedSegment : List (Attribute msg) -> List (Html msg) -> Html msg
invertedSegment =
    basis { border = True, shadow = True, inverted = True } []
