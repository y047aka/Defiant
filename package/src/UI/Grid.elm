module UI.Grid exposing
    ( grid
    , oneColumnsGrid, twoColumnsGrid, threeColumnsGrid, fourColumnsGrid, fiveColumnsGrid, sixColumnsGrid, sevenColumnsGrid, eightColumnsGrid, nineColumnsGrid, tenColumnsGrid, elevenColumnsGrid, twelveColumnsGrid, thirteenColumnsGrid, fourteenColumnsGrid, fifteenColumnsGrid, sixteenColumnsGrid
    , column
    , oneWideColumn, twoWideColumn, threeWideColumn, fourWideColumn, fiveWideColumn, sixWideColumn, sevenWideColumn, eightWideColumn, nineWideColumn, tenWideColumn, elevenWideColumn, twelveWideColumn, thirteenWideColumn, fourteenWideColumn, fifteenWideColumn, sixteenWideColumn
    )

{-|

@docs grid
@docs oneColumnsGrid, twoColumnsGrid, threeColumnsGrid, fourColumnsGrid, fiveColumnsGrid, sixColumnsGrid, sevenColumnsGrid, eightColumnsGrid, nineColumnsGrid, tenColumnsGrid, elevenColumnsGrid, twelveColumnsGrid, thirteenColumnsGrid, fourteenColumnsGrid, fifteenColumnsGrid, sixteenColumnsGrid
@docs column
@docs oneWideColumn, twoWideColumn, threeWideColumn, fourWideColumn, fiveWideColumn, sixWideColumn, sevenWideColumn, eightWideColumn, nineWideColumn, tenWideColumn, elevenWideColumn, twelveWideColumn, thirteenWideColumn, fourteenWideColumn, fifteenWideColumn, sixteenWideColumn

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, everything)
import Html.Styled as Html exposing (Attribute, Html)


gridBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
gridBasis additionalStyles =
    Html.styled Html.div
        [ -- .ui.grid
          prefixed [] "display" "flex"
        , property "-webkit-box-orient" "horizontal"
        , property "-webkit-box-direction" "normal"
        , prefixed [] "flex-direction" "row"
        , prefixed [] "flex-wrap" "wrap"
        , prefixed [] "align-items" "stretch"
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

        -- AdditionalStyles
        , batch additionalStyles
        ]


columnBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
columnBasis additionalStyles =
    Html.styled Html.div
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

        -- AdditionalStyles
        , batch additionalStyles
        ]


grid : List (Attribute msg) -> List (Html msg) -> Html msg
grid =
    gridBasis []


nColumnsGrid : Int -> List (Attribute msg) -> List (Html msg) -> Html msg
nColumnsGrid n =
    gridBasis
        [ children
            [ -- .ui[class*="one column"].grid > .row > .column
              -- .ui[class*="one column"].grid > .column:not(.row)
              Css.Global.div
                [ width (pct (100 / toFloat n)) ]
            ]
        ]


oneColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
oneColumnsGrid =
    nColumnsGrid 1


twoColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
twoColumnsGrid =
    nColumnsGrid 2


threeColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
threeColumnsGrid =
    nColumnsGrid 3


fourColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
fourColumnsGrid =
    nColumnsGrid 4


fiveColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
fiveColumnsGrid =
    nColumnsGrid 5


sixColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
sixColumnsGrid =
    nColumnsGrid 6


sevenColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
sevenColumnsGrid =
    nColumnsGrid 7


eightColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
eightColumnsGrid =
    nColumnsGrid 8


nineColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
nineColumnsGrid =
    nColumnsGrid 9


tenColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
tenColumnsGrid =
    nColumnsGrid 10


elevenColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
elevenColumnsGrid =
    nColumnsGrid 11


twelveColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
twelveColumnsGrid =
    nColumnsGrid 12


thirteenColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
thirteenColumnsGrid =
    nColumnsGrid 13


fourteenColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
fourteenColumnsGrid =
    nColumnsGrid 14


fifteenColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
fifteenColumnsGrid =
    nColumnsGrid 15


sixteenColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
sixteenColumnsGrid =
    nColumnsGrid 16


column : List (Attribute msg) -> List (Html msg) -> Html msg
column =
    columnBasis []


nWideColumn : Int -> List (Attribute msg) -> List (Html msg) -> Html msg
nWideColumn n =
    columnBasis
        -- .ui.grid > .row > [class*="number wide mobile"].column
        -- .ui.grid > .column.row > [class*="number wide mobile"].column
        -- .ui.grid > [class*="number wide mobile"].column
        -- .ui.column.grid > [class*="number wide mobile"].column
        [ width (pct <| 100 * toFloat n / 16) |> important ]


oneWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
oneWideColumn =
    nWideColumn 1


twoWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
twoWideColumn =
    nWideColumn 2


threeWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
threeWideColumn =
    nWideColumn 3


fourWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
fourWideColumn =
    nWideColumn 4


fiveWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
fiveWideColumn =
    nWideColumn 5


sixWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
sixWideColumn =
    nWideColumn 6


sevenWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
sevenWideColumn =
    nWideColumn 7


eightWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
eightWideColumn =
    nWideColumn 8


nineWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
nineWideColumn =
    nWideColumn 9


tenWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
tenWideColumn =
    nWideColumn 10


elevenWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
elevenWideColumn =
    nWideColumn 11


twelveWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
twelveWideColumn =
    nWideColumn 12


thirteenWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
thirteenWideColumn =
    nWideColumn 13


fourteenWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
fourteenWideColumn =
    nWideColumn 14


fifteenWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
fifteenWideColumn =
    nWideColumn 15


sixteenWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
sixteenWideColumn =
    nWideColumn 16
