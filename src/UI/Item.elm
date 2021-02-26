module UI.Item exposing (dividedItems, item, items)

import Css exposing (..)
import Css.Global exposing (children)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)
import UI.Internal exposing (styledBlock)


itemsBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
itemsBasis additionalStyles =
    styledBlock
        { tag = Html.div
        , position = Nothing
        , margin = Just <| margin2 (em 1.5) zero
        , padding = Nothing
        , borderRadius = Nothing
        , palette =
            { background = Nothing
            , color = Nothing
            , border = Nothing
            }
        , boxShadow = Nothing
        }
    <|
        [ -- .ui.items:first-child
          firstChild
            [ marginTop zero |> important ]

        -- .ui.items:last-child
        , lastChild
            [ marginBottom zero |> important ]
        ]
            ++ additionalStyles


items : List (Attribute msg) -> List (Html msg) -> Html msg
items =
    itemsBasis []


dividedItems : List (Attribute msg) -> List (Html msg) -> Html msg
dividedItems =
    itemsBasis
        [ -- .ui.divided.items > .item
          children
            [ Css.Global.div
                [ borderTop3 (px 1) solid (rgba 34 36 38 0.15)
                , margin zero
                , padding2 (em 1) zero

                -- .ui.divided.items > .item:first-child
                , firstChild
                    [ property "border-top" "none"
                    , marginTop zero |> important
                    , paddingTop zero |> important
                    ]

                -- .ui.divided.items > .item:last-child
                , lastChild
                    [ marginBottom zero |> important
                    , paddingBottom zero |> important
                    ]
                ]
            ]
        ]


item : List (Attribute msg) -> List (Html msg) -> Html msg
item =
    styledBlock
        { tag = Html.div
        , position = Nothing
        , margin = Just <| margin2 (em 1) zero
        , padding = Just <| padding zero
        , borderRadius = Nothing
        , palette =
            { background = Nothing
            , color = Nothing
            , border = Nothing
            }
        , boxShadow = Nothing
        }
    <|
        [ -- .ui.items > .item
          Prefix.displayFlex
        , width (pct 100)
        , minHeight zero
        , property "background" "transparent"
        , property "border" "none"
        , property "-webkit-transition" "-webkit-box-shadow 0.1s ease"
        , property "transition" "-webkit-box-shadow 0.1s ease"
        , property "transition" "box-shadow 0.1s ease"
        , property "transition" "box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "z-index" "''"

        -- .ui.items > .item a
        -- cursor: pointer;
        --
        -- .ui.items > .item:after
        , after
            [ display block
            , property "content" "''"
            , height zero
            , property "clear" "both"
            , overflow hidden
            , visibility hidden
            ]

        -- .ui.items > .item:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.items > .item:last-child
        , lastChild
            [ marginBottom zero ]

        -- .ui.items > .item > .image
        , children
            [ Css.Global.img
                [ position relative
                , Prefix.flex "0 0 auto"
                , display block
                , property "float" "none"
                , margin zero
                , padding zero
                , property "max-height" "''"
                , Prefix.alignSelf "start"

                -- .ui.items > .item > .image > img
                , display block
                , width (pct 100)
                , height auto
                , borderRadius (rem 0.125)
                , property "border" "none"

                -- .ui.items > .item > .image:only-child > img
                , borderRadius zero

                -- .ui.items > .item > .image:not(.ui)
                , width (px 175)
                ]
            ]
        ]
