module UI.Header exposing (header)

import Css exposing (..)
import Css.Global exposing (adjacentSiblings, typeSelector)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)
import UI.Modifier as Modifier


header : List (Attribute msg) -> List (Html msg) -> Html msg
header attributes =
    Html.h1 <|
        css
            [ -- .ui.header
              borderStyle none
            , margin3 (calc (rem 2) minus (em 0.1428571428571429)) zero (rem 1)
            , padding2 zero zero
            , fontFamilies Modifier.fontFamilies
            , fontWeight bold
            , lineHeight (em 1.28571429)
            , textTransform none
            , color (rgba 0 0 0 0.87)

            -- .ui.header:first-child
            , firstChild
                [ marginTop (em -0.14285714) ]

            --  .ui.header:last-child
            , lastChild
                [ marginBottom zero ]

            -- .ui.header + p
            , adjacentSiblings
                [ typeSelector "p"
                    [ marginTop zero ]
                ]

            -- .ui.header:not(h1):not(h2):not(h3):not(h4):not(h5):not(h6)
            , fontSize (em 1.28571429)
            ]
            :: attributes
