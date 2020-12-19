module UI.Table exposing
    ( table, celledTable, stripedTable
    , thead, tbody, tfoot, tr, td, th
    )

{-|

@docs table, celledTable, stripedTable
@docs thead, tbody, tfoot, tr, td, th

-}

import Css exposing (..)
import Css.Global exposing (children, descendants, each)
import Css.Palette exposing (..)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.table <|
        [ -- .ui.table
          width (pct 100)
        , backgroundColor (hex "#FFFFFF")
        , margin2 (em 1) zero
        , border3 (px 1) solid (rgba 34 36 38 0.15)
        , Prefix.boxShadow "none"
        , borderRadius (rem 0.28571429)
        , textAlign left
        , verticalAlign middle
        , color (rgba 0 0 0 0.87)
        , borderCollapse separate
        , borderSpacing zero

        -- .ui.table:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.table:last-child
        , lastChild
            [ marginBottom zero ]
        , children
            [ -- .ui.table > thead
              -- .ui.table > tbody
              each [ Css.Global.thead, Css.Global.tbody ]
                [ property "text-align" "inherit"
                , property "vertical-align" "inherit"
                ]

            -- .ui.table > thead
            , Css.Global.thead
                [ Prefix.boxShadow "none" ]
            ]
        , descendants
            [ -- .ui.table th
              -- .ui.table td
              each [ Css.Global.th, Css.Global.td ]
                [ property "-webkit-transition" "background 0.1s ease, color 0.1s ease"
                , property "transition" "background 0.1s ease, color 0.1s ease"
                ]
            ]
        ]
            ++ additionalStyles


table : List (Attribute msg) -> List (Html msg) -> Html msg
table =
    basis []


celledTable : List (Attribute msg) -> List (Html msg) -> Html msg
celledTable =
    basis
        [ descendants
            [ each [ Css.Global.th, Css.Global.td ]
                [ -- .ui.celled.table > tr > th
                  -- .ui.celled.table > thead > tr > th
                  -- .ui.celled.table > tbody > tr > th
                  -- .ui.celled.table > tfoot > tr > th
                  -- .ui.celled.table > tr > td
                  -- .ui.celled.table > tbody > tr > td
                  -- .ui.celled.table > tfoot > tr > td
                  borderLeft3 (px 1) solid (rgba 34 36 38 0.1)

                -- .ui.celled.table > tr > th:first-child
                -- .ui.celled.table > thead > tr > th:first-child
                -- .ui.celled.table > tbody > tr > th:first-child
                -- .ui.celled.table > tfoot > tr > th:first-child
                -- .ui.celled.table > tr > td:first-child
                -- .ui.celled.table > tbody > tr > td:first-child
                -- .ui.celled.table > tfoot > tr > td:first-child
                , firstChild
                    [ property "border-left" "none" ]
                ]
            ]
        ]


stripedTable : List (Attribute msg) -> List (Html msg) -> Html msg
stripedTable =
    basis
        [ descendants
            [ -- .ui.striped.table > tr:nth-child(2n)
              -- .ui.striped.table > tbody > tr:nth-child(2n)
              Css.Global.tr
                [ nthChild "2n"
                    [ backgroundColor (rgba 0 0 50 0.02) ]
                ]
            ]
        ]


thead : List (Attribute msg) -> List (Html msg) -> Html msg
thead =
    Html.thead


tbody : List (Attribute msg) -> List (Html msg) -> Html msg
tbody =
    Html.tbody


tfoot : List (Attribute msg) -> List (Html msg) -> Html msg
tfoot =
    Html.tfoot


tr : List (Attribute msg) -> List (Html msg) -> Html msg
tr =
    Html.styled Html.tr
        [ -- .ui.table > tr > td
          -- .ui.table > tbody > tr > td
          children
            [ Css.Global.td
                [ borderTop3 (px 1) solid (rgba 34 36 38 0.1) ]
            ]

        -- .ui.table > tr:first-child > td
        -- .ui.table > tbody > tr:first-child > td
        , firstChild
            [ children
                [ Css.Global.td
                    [ property "border-top" "none" ]
                ]
            ]
        ]


td : List (Attribute msg) -> List (Html msg) -> Html msg
td =
    Html.styled Html.td
        [ -- .ui.table > tbody > tr > td
          -- .ui.table > tr > td
          padding2 (em 0.78571429) (em 0.78571429)
        , property "text-align" "inherit"
        ]


th : List (Attribute msg) -> List (Html msg) -> Html msg
th =
    Html.styled Html.th
        [ -- .ui.table > thead > tr > th
          cursor auto
        , backgroundColor (hex "#F9FAFB")
        , property "text-align" "inherit"
        , color (rgba 0 0 0 0.87)
        , padding2 (em 0.92857143) (em 0.78571429)
        , property "vertical-align" "inherit"
        , property "font-style" "none"
        , fontWeight bold
        , textTransform none
        , borderBottom3 (px 1) solid (rgba 34 36 38 0.1)
        , property "border-left" "none"

        -- .ui.table > thead > tr > th:first-child
        , firstChild
            [ property "border-left" "none" ]

        -- .ui.table > thead > tr:first-child > th:first-child
        , firstChild
            [ borderRadius4 (rem 0.28571429) zero zero zero ]

        -- .ui.table > thead > tr:first-child > th:last-child
        , lastChild
            [ borderRadius4 zero (rem 0.28571429) zero zero ]

        -- .ui.table > thead > tr:first-child > th:only-child
        , onlyChild
            [ borderRadius4 (rem 0.28571429) (rem 0.28571429) zero zero ]
        ]
