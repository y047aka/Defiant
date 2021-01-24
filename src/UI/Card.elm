module UI.Card exposing (card, cards, content, description, meta)

import Css exposing (..)
import Css.Global exposing (children, descendants, everything, selector)
import Css.Prefix as Prefix
import Css.Typography exposing (fomanticFont)
import Html.Styled as Html exposing (Attribute, Html)


cards : List (Attribute msg) -> List (Html msg) -> Html msg
cards =
    Html.styled Html.div <|
        [ -- .ui.cards
          Prefix.displayFlex
        , margin2 (em -0.875) (em -0.5)
        , Prefix.flexWrap "wrap"

        -- .ui.cards > .card
        , children
            [ Css.Global.div
                [ Prefix.displayFlex
                , margin2 (em 0.875) (em 0.5)
                , property "float" "none"
                ]
            ]

        -- /* Clearing */
        -- .ui.cards:after,
        -- .ui.card:after {
        --   display: block;
        --   content: ' ';
        --   height: 0;
        --   clear: both;
        --   overflow: hidden;
        --   visibility: hidden;
        ]


cardBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
cardBasis additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.cards > .card
          -- .ui.card
          maxWidth (pct 100)
        , position relative
        , Prefix.displayFlex
        , property "-webkit-box-orient" "vertical"
        , property "-webkit-box-direction" "normal"
        , Prefix.flexDirection "column"
        , width (px 290)
        , minHeight zero
        , property "background" "#FFFFFF"
        , padding zero
        , property "border" "none"
        , borderRadius (rem 0.28571429)
        , Prefix.boxShadow "0 1px 3px 0 #D4D4D5, 0 0 0 1px #D4D4D5"
        , property "-webkit-transition" "-webkit-box-shadow 0.1s ease, -webkit-transform 0.1s ease"
        , property "transition" "-webkit-box-shadow 0.1s ease, -webkit-transform 0.1s ease"
        , property "transition" "box-shadow 0.1s ease, transform 0.1s ease"
        , property "transition" "box-shadow 0.1s ease, transform 0.1s ease, -webkit-box-shadow 0.1s ease, -webkit-transform 0.1s ease"
        , property "z-index" "''"
        , property "word-wrap" "break-word"

        -- .ui.card
        , margin2 (em 1) zero

        -- .ui.cards > .card a
        -- .ui.card a
        , descendants
            [ Css.Global.a
                [ cursor pointer ]
            ]

        -- .ui.card:first-child
        -- , firstChild
        --     [ marginTop zero ]
        -- .ui.card:last-child
        -- , firstChild
        --     [ marginBottom zero ]
        --
        -- .ui.cards > .card
        , fontSize (em 1)

        -- .ui.cards > .card > :first-child
        -- .ui.card > :first-child
        , children
            [ selector ":first-child"
                [ borderRadius4 (rem 0.28571429) (rem 0.28571429) zero zero |> important
                , property "border-top" "none" |> important
                ]
            ]

        -- .ui.cards > .card > :last-child
        -- .ui.card > :last-child
        , children
            [ selector ":last-child"
                [ borderRadius4 zero zero (rem 0.28571429) (rem 0.28571429) |> important ]
            ]

        -- .ui.cards > .card > :only-child
        -- .ui.card > :only-child
        , children
            [ selector ":only-child"
                [ borderRadius (rem 0.28571429) |> important ]
            ]
        ]
            ++ additionalStyles


card : List (Attribute msg) -> List (Html msg) -> Html msg
card =
    cardBasis []


content : List (Attribute msg) -> List (Html msg) -> Html msg
content =
    Html.styled Html.div <|
        [ -- .ui.cards > .card > .content
          -- .ui.card > .content
          property "-webkit-box-flex" "1"
        , property "-ms-flex-positive" "1"
        , property "flex-grow" "1"
        , property "border" "none"
        , borderTop3 (px 1) solid (rgba 34 36 38 0.1)
        , property "background" "none"
        , margin zero
        , padding2 (em 1) (em 1)
        , Prefix.boxShadow "none"
        , fontSize (em 1)
        , borderRadius zero

        -- .ui.cards > .card > .content:after
        -- .ui.card > .content:after
        , after
            [ display block
            , property "content" (qt " ")
            , height zero
            , property "clear" "both"
            , overflow hidden
            , visibility hidden
            ]

        -- .ui.cards > .card > .content p
        -- .ui.card > .content p
        , descendants
            [ Css.Global.p
                [ margin3 zero zero (em 0.5)

                -- .ui.cards > .card > .content p:last-child,
                -- .ui.card > .content p:last-child {
                , lastChild
                    [ marginBottom zero ]
                ]

            -- .ui.cards > .card > .content a:not(.ui)
            -- .ui.card > .content a:not(.ui)
            , Css.Global.a
                [ property "color" "''"
                , property "-webkit-transition" "color 0.1s ease"
                , property "transition" "color 0.1s ease"

                -- .ui.cards > .card > .content a:not(.ui):hover
                -- .ui.card > .content a:not(.ui):hover
                , hover
                    [ property "color" "''" ]
                ]
            ]

        -- .ui.cards > .card > .content > .header
        -- .ui.card > .content > .header
        , children
            [ Css.Global.header
                [ display block
                , property "margin" "''"
                , fontFamilies fomanticFont
                , color (rgba 0 0 0 0.85)

                -- .ui.cards > .card > .content > .header:not(.ui)
                -- .ui.card > .content > .header:not(.ui)
                , fontWeight bold
                , fontSize (em 1.28571429)
                , marginTop (em -0.21425)
                , lineHeight (em 1.28571429)
                ]
            ]
        ]


meta : List (Attribute msg) -> List (Html msg) -> Html msg
meta =
    Html.styled Html.div <|
        [ -- .ui.cards > .card .meta
          -- .ui.card .meta
          fontSize (em 1)
        , color (rgba 0 0 0 0.4)

        -- .ui.cards > .card .meta *
        -- .ui.card .meta *
        , descendants
            [ everything
                [ marginRight (em 0.3) ]

            -- .ui.cards > .card .meta :last-child
            -- .ui.card .meta :last-child
            , selector ":last-child"
                [ marginRight zero
                ]
            ]

        -- .ui.cards > .card .meta > a:not(.ui)
        -- .ui.card .meta > a:not(.ui)
        , children
            [ Css.Global.a
                [ color (rgba 0 0 0 0.4)
                , hover
                    [ -- .ui.cards > .card .meta > a:not(.ui):hover
                      -- .ui.card .meta > a:not(.ui):hover
                      color (rgba 0 0 0 0.87)
                    ]
                ]
            ]
        ]


description : List (Attribute msg) -> List (Html msg) -> Html msg
description =
    Html.styled Html.div <|
        [ -- .ui.cards > .card > .content > .meta + .description
          -- .ui.cards > .card > .content > .header + .description
          -- .ui.card > .content > .meta + .description
          -- .ui.card > .content > .header + .description
          marginTop (em 0.5)

        -- .ui.cards > .card > .content > .description
        -- .ui.card > .content > .description
        , property "clear" "both"
        , color (rgba 0 0 0 0.68)
        ]
