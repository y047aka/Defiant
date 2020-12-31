module UI.Grid exposing (fourWideColumn, grid)

import Css exposing (..)
import Css.Global exposing (children, everything)
import Css.Palette exposing (..)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)


gridBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
gridBasis additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.grid
          Prefix.displayFlex
        , property "-webkit-box-orient" "horizontal"
        , property "-webkit-box-direction" "normal"
        , Prefix.flexDirection "row"
        , Prefix.flexWrap "wrap"
        , Prefix.alignItems "stretch"
        , padding zero

        -- .ui.grid
        , marginTop (rem -1)
        , marginBottom (rem -1)
        , marginLeft (rem -1)
        , marginRight (rem -1)

        -- .ui.grid > *
        , children
            [ everything
                [ paddingLeft (rem 1)
                , paddingRight (rem 1)
                ]
            ]
        ]
            ++ additionalStyles


columnBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
columnBasis additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.grid > .column:not(.row)
          -- .ui.grid > .row > .column
          position relative
        , display inlineBlock
        , width (pct 6.25)
        , paddingLeft (rem 1)
        , paddingRight (rem 1)
        , verticalAlign top

        -- .ui.grid > .column:not(.row)
        , paddingTop (rem 1)
        , paddingBottom (rem 1)
        ]
            ++ additionalStyles


grid : List (Attribute msg) -> List (Html msg) -> Html msg
grid =
    gridBasis []


fourWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
fourWideColumn =
    columnBasis <|
        [ -- .ui[class*="four column"].grid > .row > .column
          -- .ui[class*="four column"].grid > .column:not(.row)
          width (pct 25)

        -- override
        , boxSizing borderBox
        ]
