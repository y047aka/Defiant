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
import Css.Extra exposing (when)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)
import UI.Internal exposing (chassis)


basis : { border : Bool, shadow : Bool, inverted : Bool } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { border, shadow, inverted } additionalStyles =
    chassis
        { tag = Html.section
        , position_ = Just <| position relative
        , margin_ = Just <| margin2 (rem 1) zero
        , padding_ = Just <| padding2 (em 1) (em 1)
        , borderRadius_ =
            if shadow then
                Just (rem 0.28571429)

            else
                Nothing
        , border = border
        , palette_ =
            { background =
                if shadow then
                    Just (hex "#FFF")

                else
                    Nothing
            , color = Nothing
            , border = rgba 34 36 38 0.15
            }
        }
    <|
        [ -- .ui.segment
          if shadow then
            Prefix.boxShadow "0 1px 2px 0 rgba(34, 36, 38, 0.15)"

          else
            Prefix.boxShadow "none"

        -- .ui.segment:first-child
        , pseudoClass "first-child"
            [ marginTop zero ]

        -- .ui.segment:last-child
        , pseudoClass "last-child"
            [ marginBottom zero ]

        -- .ui.inverted.segment
        , when inverted <|
            batch
                [ property "border" "none"
                , Prefix.boxShadow "none"

                -- .ui.inverted.segment
                -- .ui.primary.inverted.segment
                , property "background" "#1B1C1D"
                , color (rgba 255 255 255 0.9)
                ]
        ]
            ++ additionalStyles


segment : List (Attribute msg) -> List (Html msg) -> Html msg
segment =
    basis { border = True, shadow = True, inverted = False } []


verticalSegment : List (Attribute msg) -> List (Html msg) -> Html msg
verticalSegment =
    basis { border = False, shadow = False, inverted = False }
        [ -- .ui.vertical.segment
          margin zero
        , paddingLeft zero
        , paddingRight zero
        , borderBottom3 (px 1) solid (rgba 34 36 38 0.15)

        -- .ui.vertical.segment:last-child
        , lastChild
            [ property "border-bottom" "none" ]
        ]


disabledSegment : List (Attribute msg) -> List (Html msg) -> Html msg
disabledSegment =
    basis { border = True, shadow = True, inverted = False }
        [ -- .ui.disabled.segment
          opacity (num 0.45)
        , color (rgba 40 40 40 0.3)
        ]


paddedSegment : List (Attribute msg) -> List (Html msg) -> Html msg
paddedSegment =
    basis { border = True, shadow = True, inverted = False }
        [ -- .ui.padded.segment
          padding (em 1.5)
        ]


veryPaddedSegment : List (Attribute msg) -> List (Html msg) -> Html msg
veryPaddedSegment =
    basis { border = True, shadow = True, inverted = False }
        [ -- .ui[class*="very padded"].segment
          padding (em 3)
        ]


basicSegment : List (Attribute msg) -> List (Html msg) -> Html msg
basicSegment =
    -- .ui.basic.segment
    -- .ui.segments .ui.basic.segment
    -- .ui.basic.segments
    basis { border = False, shadow = False, inverted = False } []


invertedSegment : List (Attribute msg) -> List (Html msg) -> Html msg
invertedSegment =
    basis { border = True, shadow = True, inverted = True } []
