module UI.Segment exposing
    ( segment, segmentWithProps
    , disabledSegment
    , verticalSegment
    , invertedSegment, paddedSegment, veryPaddedSegment, basicSegment
    , Padding(..), paddingFromString, paddingToString
    )

{-|

@docs segment, segmentWithProps
@docs disabledSegment
@docs verticalSegment
@docs invertedSegment, paddedSegment, veryPaddedSegment, basicSegment

@docs Padding, paddingFromString, paddingToString

-}

import Css exposing (..)
import Css.Palette as Palette exposing (paletteWithBorder, setBackground, setColor)
import Css.Palette.Extra exposing (darkPalette, setBackgroundIf, setBorderIf)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Attribute, Html)


type alias Props =
    { padding : Padding
    , border : Bool
    , shadow : Bool
    , theme : Theme
    , disabled : Bool
    , additionalStyles : List Style
    }


segmentWithProps : Props -> List (Attribute msg) -> List (Html msg) -> Html msg
segmentWithProps ({ border, shadow, theme, disabled, additionalStyles } as props) =
    basis { border = border, shadow = shadow, theme = theme }
        [ case props.padding of
            Default ->
                batch []

            Padded ->
                -- .ui.padded.segment
                padding (em 1.5)

            VeryPadded ->
                -- .ui[class*="very padded"].segment
                padding (em 3)

        -- .ui.disabled.segment
        , if disabled then
            batch
                [ opacity (num 0.45)
                , color (rgba 40 40 40 0.3)
                ]

          else
            batch []

        -- AdditionalStyles
        , batch additionalStyles
        ]


segment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
segment { theme } =
    segmentWithProps { defaultProps | theme = theme }


defaultProps : Props
defaultProps =
    { padding = Default
    , border = True
    , shadow = True
    , theme = System
    , disabled = False
    , additionalStyles = []
    }


basis : { border : Bool, shadow : Bool, theme : Theme } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { border, shadow, theme } additionalStyles =
    Html.styled Html.section
        [ position relative
        , margin2 (rem 1) zero
        , padding2 (em 1) (em 1)
        , if shadow then
            borderRadius (rem 0.28571429)

          else
            batch []
        , paletteWithBorder (border3 (px 1) solid)
            (Palette.init
                |> setBackgroundIf shadow (hex "#FFF")
                |> setBorderIf border (rgba 34 36 38 0.15)
            )
        , if shadow then
            boxShadow5 zero (px 1) (px 2) zero (rgba 34 36 38 0.15)

          else
            batch []
        , darkPalette theme
            (Palette.init
                |> setBackground (hex "#1B1C1D")
                |> setColor (rgba 255 255 255 0.9)
            )

        -- .ui.segment:first-child
        , pseudoClass "first-child"
            [ marginTop zero ]

        -- .ui.segment:last-child
        , pseudoClass "last-child"
            [ marginBottom zero ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


verticalSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
verticalSegment { theme } =
    segmentWithProps
        { defaultProps
            | border = False
            , shadow = False
            , theme = theme
            , additionalStyles =
                [ -- .ui.vertical.segment
                  margin zero
                , paddingLeft zero
                , paddingRight zero
                , borderBottom3 (px 1) solid (rgba 34 36 38 0.15)

                -- .ui.vertical.segment:last-child
                , lastChild
                    [ property "border-bottom" "none" ]
                ]
        }


disabledSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
disabledSegment { theme } =
    segmentWithProps { defaultProps | theme = theme, disabled = True }


paddedSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
paddedSegment { theme } =
    segmentWithProps { defaultProps | padding = Padded, theme = theme }


veryPaddedSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
veryPaddedSegment { theme } =
    segmentWithProps { defaultProps | padding = VeryPadded, theme = theme }


basicSegment : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
basicSegment { theme } =
    -- .ui.basic.segment
    -- .ui.segments .ui.basic.segment
    -- .ui.basic.segments
    segmentWithProps { defaultProps | border = False, shadow = False, theme = theme }


invertedSegment : List (Attribute msg) -> List (Html msg) -> Html msg
invertedSegment =
    segmentWithProps { defaultProps | theme = Dark }



-- HELPER


type Padding
    = Default
    | Padded
    | VeryPadded


paddingFromString : String -> Maybe Padding
paddingFromString string =
    case string of
        "Default" ->
            Just Default

        "Padded" ->
            Just Padded

        "VeryPadded" ->
            Just VeryPadded

        _ ->
            Nothing


paddingToString : Padding -> String
paddingToString padding =
    case padding of
        Default ->
            "Default"

        Padded ->
            "Padded"

        VeryPadded ->
            "VeryPadded"
