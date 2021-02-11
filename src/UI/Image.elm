module UI.Image exposing (..)

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.img <|
        [ -- .ui.image
          position relative
        , display inlineBlock
        , verticalAlign middle
        , maxWidth (pct 100)
        , backgroundColor transparent

        -- img.ui.image
        , display block
        ]
            ++ additionalStyles


image : List (Attribute msg) -> List (Html msg) -> Html msg
image =
    basis []


smallImage : List (Attribute msg) -> List (Html msg) -> Html msg
smallImage =
    basis
        [ -- .ui.small.images .image
          -- .ui.small.images img
          -- .ui.small.images svg
          -- .ui.small.image
          width (px 150)
        , height auto
        , fontSize (rem 0.92857143)
        ]
