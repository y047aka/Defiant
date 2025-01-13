module UI.Divider exposing (divider)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Typography as Typography exposing (setFontWeight, setLetterSpacing, setLineHeight, setTextTransform, typography)
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.div
        [ -- .ui.divider
          margin2 (rem 1) zero
        , height zero
        , typography
            (Typography.init
                |> setFontWeight bold
                |> setLineHeight (num 1)
                |> setTextTransform uppercase
                |> setLetterSpacing (em 0.05)
            )
        , color (rgba 0 0 0 0.85)
        , prefixed [] "user-select" "none"
        , property "-webkit-tap-highlight-color" "rgba(0, 0, 0, 0)"

        -- AdditionalStyles
        , batch additionalStyles
        ]


divider : List (Attribute msg) -> List (Html msg) -> Html msg
divider =
    basis
        [ -- .ui.divider:not(.vertical):not(.horizontal)
          borderTop3 (px 1) solid (rgba 34 36 38 0.15)
        , borderBottom3 (px 1) solid (rgba 255 255 255 0.1)
        ]
