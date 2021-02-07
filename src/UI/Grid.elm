module UI.Grid exposing
    ( grid, fiveColumnsGrid
    , column, fourWideColumn, twelveWideColumn
    )

{-|

@docs grid, fiveColumnsGrid
@docs column, fourWideColumn, twelveWideColumn

-}

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


fiveColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
fiveColumnsGrid =
    gridBasis
        [ -- .ui[class*="five column"].grid > .row > .column
          -- .ui[class*="five column"].grid > .column:not(.row)
          children
            [ Css.Global.div
                [ width (pct 20) ]
            ]
        ]


column : List (Attribute msg) -> List (Html msg) -> Html msg
column =
    columnBasis []


fourWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
fourWideColumn =
    columnBasis <|
        [ -- .ui.grid > .row > [class*="four wide mobile"].column
          -- .ui.grid > .column.row > [class*="four wide mobile"].column
          -- .ui.grid > [class*="four wide mobile"].column
          -- .ui.column.grid > [class*="four wide mobile"].column
          width (pct 25) |> important
        ]


twelveWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
twelveWideColumn =
    columnBasis <|
        [ -- .ui.grid > .row > [class*="twelve wide"].column
          -- .ui.grid > .column.row > [class*="twelve wide"].column
          -- .ui.grid > [class*="twelve wide"].column
          -- .ui.column.grid > [class*="twelve wide"].column
          width (pct 75) |> important
        ]
