module UI.Table exposing
    ( table, stripedTable, celledTable, basicTable, veryBasicTable
    , thead, tbody, tfoot, tr, td, th
    )

{-|

@docs table, stripedTable, celledTable, basicTable, veryBasicTable
@docs thead, tbody, tfoot, tr, td, th

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, descendants, each)
import Css.Layout as Layout exposing (layout)
import Css.Palette as Palette exposing (paletteWith, setBackground, setBorderIf, setColor)
import Css.Typography as Typography exposing (init, typography)
import Html.Styled as Html exposing (Attribute, Html)


basis :
    { border : Bool, striped : Bool, celled : Bool, thead : Bool }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
basis options additionalStyles =
    let
        initialLayout =
            Layout.init
    in
    Html.styled Html.table
        [ margin2 (em 1) zero
        , paletteWith { border = border3 (px 1) solid, shadow = batch [] }
            (Palette.init
                |> setBackground (hex "#FFF")
                |> setColor (rgba 0 0 0 0.87)
                |> setBorderIf options.border (rgba 34 36 38 0.15)
            )
        , borderRadius (rem 0.28571429)

        -- .ui.table
        , width (pct 100)
        , layout
            { initialLayout
                | textAlign = Layout.left
                , verticalAlign = Layout.middle
            }
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
                [ layout
                    { initialLayout
                        | textAlign = Typography.inherit
                        , verticalAlign = Typography.inherit
                    }
                ]

            -- .ui.table > thead
            , Css.Global.thead
                [ prefixed [] "box-shadow" "none" ]
            ]
        , descendants
            [ -- .ui.table th
              -- .ui.table td
              each [ Css.Global.th, Css.Global.td ]
                [ property "-webkit-transition" "background 0.1s ease, color 0.1s ease"
                , property "transition" "background 0.1s ease, color 0.1s ease"
                ]
            ]

        -- Striped
        , batch <|
            if options.striped then
                [ descendants
                    [ -- .ui.striped.table > tr:nth-child(2n)
                      -- .ui.striped.table > tbody > tr:nth-child(2n)
                      Css.Global.tr
                        [ nthChild "2n"
                            [ backgroundColor (rgba 0 0 50 0.02) ]
                        ]
                    ]
                ]

            else
                []

        -- Celled
        , batch <|
            if options.celled then
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

            else
                []

        -- Table Header
        , batch <|
            if options.thead then
                [ descendants
                    [ -- .ui.table > thead > tr > th
                      Css.Global.th
                        [ backgroundColor (hex "#F9FAFB") ]
                    ]
                ]

            else
                []

        -- AdditionalStyles
        , batch additionalStyles
        ]


table : List (Attribute msg) -> List (Html msg) -> Html msg
table =
    basis
        { border = True
        , striped = False
        , celled = False
        , thead = True
        }
        []


stripedTable : List (Attribute msg) -> List (Html msg) -> Html msg
stripedTable =
    basis
        { border = True
        , striped = True
        , celled = False
        , thead = True
        }
        []


celledTable : List (Attribute msg) -> List (Html msg) -> Html msg
celledTable =
    basis
        { border = True
        , striped = False
        , celled = True
        , thead = True
        }
        []


basicTable : List (Attribute msg) -> List (Html msg) -> Html msg
basicTable =
    basis
        { border = True
        , striped = False
        , celled = False
        , thead = False
        }
        []


veryBasicTable : List (Attribute msg) -> List (Html msg) -> Html msg
veryBasicTable =
    basis
        { border = False
        , striped = False
        , celled = False
        , thead = False
        }
        []


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
    let
        initialLayout =
            Layout.init
    in
    Html.styled Html.td
        [ -- .ui.table > tbody > tr > td
          -- .ui.table > tr > td
          padding2 (em 0.78571429) (em 0.78571429)
        , layout { initialLayout | textAlign = Typography.inherit }
        ]


th : List (Attribute msg) -> List (Html msg) -> Html msg
th =
    let
        initialLayout =
            Layout.init
    in
    Html.styled Html.th
        [ -- .ui.table > thead > tr > th
          cursor auto
        , layout
            { initialLayout
                | textAlign = Typography.inherit
                , verticalAlign = Typography.inherit
            }
        , typography
            { init
                | fontStyle = Typography.none
                , fontWeight = Typography.bold
                , textTransform = Typography.none
            }
        , color (rgba 0 0 0 0.87)
        , padding2 (em 0.92857143) (em 0.78571429)
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
