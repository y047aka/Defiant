module UI.Item exposing
    ( items
    , item, dividedItems
    , content, middleAlignedContent
    , header
    )

{-|

@docs items
@docs item, dividedItems
@docs content, middleAlignedContent
@docs header

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, everything)
import Css.Typography_Outdated exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html, text)


itemsBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
itemsBasis additionalStyles =
    Html.styled Html.div
        [ margin2 (em 1.5) zero

        -- .ui.items:first-child
        , firstChild
            [ marginTop zero |> important ]

        -- .ui.items:last-child
        , lastChild
            [ marginBottom zero |> important ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


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
    Html.styled Html.div
        [ margin2 (em 1) zero
        , padding zero

        -- .ui.items > .item
        , prefixed [] "display" "flex"
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
                , prefixed [] "flex" "0 0 auto"
                , display block
                , property "float" "none"
                , margin zero
                , padding zero
                , property "max-height" "''"
                , prefixed [] "align-self" "start"

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


contentBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
contentBasis additionalStyles =
    Html.styled Html.div
        [ -- .ui.items > .item > .content
          display block
        , prefixed [] "flex" "1 1 auto"
        , property "background" "none"
        , color (rgba 0 0 0 0.87)
        , margin zero
        , padding zero
        , prefixed [] "box-shadow" "none"
        , fontSize (em 1)
        , property "border" "none"
        , borderRadius zero

        -- .ui.items > .item > .content:after
        , after
            [ display block
            , property "content" "''"
            , height zero
            , property "clear" "both"
            , overflow hidden
            , visibility hidden
            ]

        -- .ui.items > .item > .image + .content
        , nthChild "2"
            [ minWidth zero
            , width auto
            , display block
            , marginLeft zero
            , prefixed [] "align-self" "start"
            , paddingLeft (em 1.5)
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


content :
    List (Attribute msg)
    ->
        { header : List (Html msg)
        , meta : List (Html msg)
        , description : List (Html msg)
        , extra : List (Html msg)
        }
    -> Html msg
content attributes hmde =
    let
        has list f =
            case list of
                [] ->
                    text ""

                nonEmpty ->
                    f nonEmpty
    in
    contentBasis []
        attributes
        [ has hmde.header (header [])
        , has hmde.meta (meta [])
        , has hmde.description (description [])
        , has hmde.extra (extra [])
        ]


middleAlignedContent : List (Attribute msg) -> List (Html msg) -> Html msg
middleAlignedContent =
    contentBasis
        [ -- .ui.items > .item > .image + [class*="middle aligned"].content
          nthChild "2"
            [ prefixed [] "align-self" "center" ]
        ]


header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    Html.styled Html.header
        [ -- .ui.items > .item > .content > .header
          display inlineBlock
        , margin3 (em -0.21425) zero zero
        , fontFamilies fomanticFontFamilies
        , fontWeight bold
        , color (rgba 0 0 0 0.85)

        -- .ui.items > .item > .content > .header:not(.ui)
        , fontSize (em 1.28571429)
        ]


meta : List (Attribute msg) -> List (Html msg) -> Html msg
meta =
    Html.styled Html.div
        [ -- .ui.items > .item .meta
          margin3 (em 0.5) zero (em 0.5)
        , fontSize (em 1)
        , lineHeight (em 1)
        , color (rgba 0 0 0 0.6)

        -- .ui.items > .item .meta *
        , children
            [ everything
                [ marginRight (em 0.3)

                -- .ui.items > .item .meta :last-child
                , lastChild
                    [ marginRight zero ]
                ]
            ]
        ]


description : List (Attribute msg) -> List (Html msg) -> Html msg
description =
    Html.styled Html.div
        [ -- .ui.items > .item > .content > .description
          marginTop (em 0.6)
        , property "max-width" "auto"
        , fontSize (em 1)
        , lineHeight (em 1.4285)
        , color (rgba 0 0 0 0.87)
        ]


extra : List (Attribute msg) -> List (Html msg) -> Html msg
extra =
    Html.styled Html.div
        [ -- .ui.items > .item .extra
          display block
        , position relative
        , property "background" "none"
        , margin3 (rem 0.5) zero zero
        , width (pct 100)
        , padding3 zero zero zero
        , top zero
        , left zero
        , color (rgba 0 0 0 0.4)
        , prefixed [] "box-shadow" "none"
        , property "-webkit-transition" "color 0.1s ease"
        , property "transition" "color 0.1s ease"
        , property "border-top" "none"
        ]
