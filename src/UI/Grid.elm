module UI.Grid exposing
    ( grid
    , fiveColumnsGrid
    , column
    , fourWideColumn, twelveWideColumn
    )

{-|

@docs grid
@docs fiveColumnsGrid
@docs column
@docs fourWideColumn, twelveWideColumn

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
    let
        additionalStyles =
            case n of
                1 ->
                    -- .ui[class*="one column"].grid > .row > .column
                    -- .ui[class*="one column"].grid > .column:not(.row)
                    [ width (pct 100) ]

                2 ->
                    -- .ui[class*="two column"].grid > .row > .column
                    -- .ui[class*="two column"].grid > .column:not(.row)
                    [ width (pct 50) ]

                3 ->
                    -- .ui[class*="three column"].grid > .row > .column
                    -- .ui[class*="three column"].grid > .column:not(.row)
                    [ width (pct 33.33333333) ]

                4 ->
                    -- .ui[class*="four column"].grid > .row > .column
                    -- .ui[class*="four column"].grid > .column:not(.row)
                    [ width (pct 25) ]

                5 ->
                    -- .ui[class*="five column"].grid > .row > .column
                    -- .ui[class*="five column"].grid > .column:not(.row)
                    [ width (pct 20) ]

                6 ->
                    -- .ui[class*="six column"].grid > .row > .column
                    -- .ui[class*="six column"].grid > .column:not(.row)
                    [ width (pct 16.66666667) ]

                7 ->
                    -- .ui[class*="seven column"].grid > .row > .column
                    -- .ui[class*="seven column"].grid > .column:not(.row)
                    [ width (pct 14.28571429) ]

                8 ->
                    -- .ui[class*="eight column"].grid > .row > .column
                    -- .ui[class*="eight column"].grid > .column:not(.row)
                    [ width (pct 12.5) ]

                9 ->
                    -- .ui[class*="nine column"].grid > .row > .column,
                    -- .ui[class*="nine column"].grid > .column:not(.row)
                    [ width (pct 11.11111111) ]

                10 ->
                    -- .ui[class*="ten column"].grid > .row > .column
                    -- .ui[class*="ten column"].grid > .column:not(.row)
                    [ width (pct 10) ]

                11 ->
                    -- .ui[class*="eleven column"].grid > .row > .column
                    -- .ui[class*="eleven column"].grid > .column:not(.row)
                    [ width (pct 9.09090909) ]

                12 ->
                    -- .ui[class*="twelve column"].grid > .row > .column
                    -- .ui[class*="twelve column"].grid > .column:not(.row)
                    [ width (pct 8.33333333) ]

                13 ->
                    -- .ui[class*="thirteen column"].grid > .row > .column
                    -- .ui[class*="thirteen column"].grid > .column:not(.row)
                    [ width (pct 7.69230769) ]

                14 ->
                    -- .ui[class*="fourteen column"].grid > .row > .column
                    -- .ui[class*="fourteen column"].grid > .column:not(.row)
                    [ width (pct 7.14285714) ]

                15 ->
                    -- .ui[class*="fifteen column"].grid > .row > .column
                    -- .ui[class*="fifteen column"].grid > .column:not(.row)
                    [ width (pct 6.66666667) ]

                16 ->
                    -- .ui[class*="sixteen column"].grid > .row > .column
                    -- .ui[class*="sixteen column"].grid > .column:not(.row)
                    [ width (pct 6.25) ]

                _ ->
                    []
    in
    gridBasis
        [ children
            [ Css.Global.div additionalStyles ]
        ]


fiveColumnsGrid : List (Attribute msg) -> List (Html msg) -> Html msg
fiveColumnsGrid =
    nColumnsGrid 5


column : List (Attribute msg) -> List (Html msg) -> Html msg
column =
    columnBasis []


nWideColumn : Int -> List (Attribute msg) -> List (Html msg) -> Html msg
nWideColumn n =
    columnBasis <|
        case n of
            1 ->
                -- .ui.grid > .row > [class*="one wide mobile"].column
                -- .ui.grid > .column.row > [class*="one wide mobile"].column
                -- .ui.grid > [class*="one wide mobile"].column
                -- .ui.column.grid > [class*="one wide mobile"].column
                [ width (pct 6.25) |> important ]

            2 ->
                -- .ui.grid > .row > [class*="two wide mobile"].column
                -- .ui.grid > .column.row > [class*="two wide mobile"].column
                -- .ui.grid > [class*="two wide mobile"].column
                -- .ui.column.grid > [class*="two wide mobile"].column
                [ width (pct 12.5) |> important ]

            3 ->
                -- .ui.grid > .row > [class*="three wide mobile"].column
                -- .ui.grid > .column.row > [class*="three wide mobile"].column
                -- .ui.grid > [class*="three wide mobile"].column
                -- .ui.column.grid > [class*="three wide mobile"].column
                [ width (pct 18.75) |> important ]

            4 ->
                -- .ui.grid > .row > [class*="four wide mobile"].column
                -- .ui.grid > .column.row > [class*="four wide mobile"].column
                -- .ui.grid > [class*="four wide mobile"].column
                -- .ui.column.grid > [class*="four wide mobile"].column
                [ width (pct 25) |> important ]

            5 ->
                -- .ui.grid > .row > [class*="five wide mobile"].column
                -- .ui.grid > .column.row > [class*="five wide mobile"].column
                -- .ui.grid > [class*="five wide mobile"].column
                -- .ui.column.grid > [class*="five wide mobile"].column
                [ width (pct 31.25) |> important ]

            6 ->
                -- .ui.grid > .row > [class*="six wide mobile"].column
                -- .ui.grid > .column.row > [class*="six wide mobile"].column
                -- .ui.grid > [class*="six wide mobile"].column
                -- .ui.column.grid > [class*="six wide mobile"].column
                [ width (pct 37.5) |> important ]

            7 ->
                -- .ui.grid > .row > [class*="seven wide mobile"].column
                -- .ui.grid > .column.row > [class*="seven wide mobile"].column
                -- .ui.grid > [class*="seven wide mobile"].column
                -- .ui.column.grid > [class*="seven wide mobile"].column
                [ width (pct 43.75) |> important ]

            8 ->
                -- .ui.grid > .row > [class*="eight wide mobile"].column
                -- .ui.grid > .column.row > [class*="eight wide mobile"].column
                -- .ui.grid > [class*="eight wide mobile"].column
                -- .ui.column.grid > [class*="eight wide mobile"].column
                [ width (pct 50) |> important ]

            9 ->
                -- .ui.grid > .row > [class*="nine wide mobile"].column
                -- .ui.grid > .column.row > [class*="nine wide mobile"].column
                -- .ui.grid > [class*="nine wide mobile"].column
                -- .ui.column.grid > [class*="nine wide mobile"].column
                [ width (pct 56.25) |> important ]

            10 ->
                -- .ui.grid > .row > [class*="ten wide mobile"].column
                -- .ui.grid > .column.row > [class*="ten wide mobile"].column
                -- .ui.grid > [class*="ten wide mobile"].column
                -- .ui.column.grid > [class*="ten wide mobile"].column
                [ width (pct 62.5) |> important ]

            11 ->
                -- .ui.grid > .row > [class*="eleven wide mobile"].column
                -- .ui.grid > .column.row > [class*="eleven wide mobile"].column
                -- .ui.grid > [class*="eleven wide mobile"].column
                -- .ui.column.grid > [class*="eleven wide mobile"].column
                [ width (pct 68.75) |> important ]

            12 ->
                -- .ui.grid > .row > [class*="twelve wide mobile"].column
                -- .ui.grid > .column.row > [class*="twelve wide mobile"].column
                -- .ui.grid > [class*="twelve wide mobile"].column
                -- .ui.column.grid > [class*="twelve wide mobile"].column
                [ width (pct 75) |> important ]

            13 ->
                -- .ui.grid > .row > [class*="thirteen wide mobile"].column
                -- .ui.grid > .column.row > [class*="thirteen wide mobile"].column
                -- .ui.grid > [class*="thirteen wide mobile"].column
                -- .ui.column.grid > [class*="thirteen wide mobile"].column
                [ width (pct 81.25) |> important ]

            14 ->
                -- .ui.grid > .row > [class*="fourteen wide mobile"].column
                -- .ui.grid > .column.row > [class*="fourteen wide mobile"].column
                -- .ui.grid > [class*="fourteen wide mobile"].column
                -- .ui.column.grid > [class*="fourteen wide mobile"].column
                [ width (pct 87.5) |> important ]

            15 ->
                -- .ui.grid > .row > [class*="fifteen wide mobile"].column
                -- .ui.grid > .column.row > [class*="fifteen wide mobile"].column
                -- .ui.grid > [class*="fifteen wide mobile"].column
                -- .ui.column.grid > [class*="fifteen wide mobile"].column
                [ width (pct 93.75) |> important ]

            16 ->
                -- .ui.grid > .row > [class*="sixteen wide mobile"].column
                -- .ui.grid > .column.row > [class*="sixteen wide mobile"].column
                -- .ui.grid > [class*="sixteen wide mobile"].column
                -- .ui.column.grid > [class*="sixteen wide mobile"].column
                [ width (pct 100) |> important ]

            _ ->
                []


fourWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
fourWideColumn =
    nWideColumn 4


twelveWideColumn : List (Attribute msg) -> List (Html msg) -> Html msg
twelveWideColumn =
    nWideColumn 12
