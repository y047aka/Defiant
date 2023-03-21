module UI.Rail exposing (leftRail, rightRail)

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.div
        [ -- .ui.rail
          position absolute
        , top zero
        , width (px 300)
        , height (pct 100)

        -- AdditionalStyles
        , batch additionalStyles
        ]


leftRail : List (Attribute msg) -> List (Html msg) -> Html msg
leftRail =
    basis
        [ -- .ui.left.rail
          left auto
        , right (pct 100)
        , padding4 zero (rem 2) zero zero
        , margin4 zero (rem 2) zero zero
        ]


rightRail : List (Attribute msg) -> List (Html msg) -> Html msg
rightRail =
    basis
        [ -- .ui.right.rail
          left (pct 100)
        , right auto
        , padding4 zero zero zero (rem 2)
        , margin4 zero zero zero (rem 2)
        ]
