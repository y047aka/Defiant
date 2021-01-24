module UI.Segment exposing (basicSegment, disabledSegment, paddedSegment, segment, verticalSegment, veryPaddedSegment)

import Css exposing (..)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)


basis : { borderAndShadows : Bool } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { borderAndShadows } additionalStyles =
    Html.styled Html.section <|
        [ -- .ui.segment
          position relative
        , margin2 (rem 1) zero
        , padding2 (em 1) (em 1)
        , batch <|
            if borderAndShadows then
                [ property "background" "#FFFFFF"
                , Prefix.boxShadow "0 1px 2px 0 rgba(34, 36, 38, 0.15)"
                , borderRadius (rem 0.28571429)
                , border3 (px 1) solid (rgba 34 36 38 0.15)
                ]

            else
                [ property "background" "none transparent"
                , Prefix.boxShadow "none"
                , property "border" "none"
                , borderRadius zero
                ]

        -- .ui.segment:first-child
        , pseudoClass "first-child"
            [ marginTop zero ]

        -- .ui.segment:last-child
        , pseudoClass "last-child"
            [ marginBottom zero ]
        ]
            ++ additionalStyles


segment : List (Attribute msg) -> List (Html msg) -> Html msg
segment =
    basis { borderAndShadows = True } []


verticalSegment : List (Attribute msg) -> List (Html msg) -> Html msg
verticalSegment =
    basis { borderAndShadows = False }
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
    basis { borderAndShadows = True }
        [ -- .ui.disabled.segment
          opacity (num 0.45)
        , color (rgba 40 40 40 0.3)
        ]


paddedSegment : List (Attribute msg) -> List (Html msg) -> Html msg
paddedSegment =
    basis { borderAndShadows = True }
        [ -- .ui.padded.segment
          padding (em 1.5)
        ]


veryPaddedSegment : List (Attribute msg) -> List (Html msg) -> Html msg
veryPaddedSegment =
    basis { borderAndShadows = True }
        [ -- .ui[class*="very padded"].segment
          padding (em 3)
        ]


basicSegment : List (Attribute msg) -> List (Html msg) -> Html msg
basicSegment =
    -- .ui.basic.segment
    -- .ui.segments .ui.basic.segment
    -- .ui.basic.segments
    basis { borderAndShadows = False } []
