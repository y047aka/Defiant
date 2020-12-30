module UI.Menu exposing
    ( menu, item, activeItem
    , leftMenu, rightMenu, centerMenu
    , secondaryMenu, secondaryMenuItem, secondaryMenuActiveItem
    , verticalMenu, verticalMenuItem, verticalMenuActiveItem, verticalMenuActiveItemLabel
    )

{-|

@docs menu, item, activeItem
@docs leftMenu, rightMenu, centerMenu
@docs secondaryMenu, secondaryMenuItem, secondaryMenuActiveItem
@docs verticalMenu, verticalMenuItem, verticalMenuActiveItem, verticalMenuActiveItemLabel

-}

import Css exposing (..)
import Css.Palette exposing (..)
import Css.Prefix as Prefix
import Css.Typography as Typography exposing (fomanticFont, init, typography)
import Html.Styled as Html exposing (Attribute, Html)
import UI.Label


menuBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
menuBasis additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.menu
          Prefix.displayFlex
        , margin2 (rem 1) zero
        , typography
            { init
                | fontFamilies = fomanticFont
                , fontWeight = Typography.normal
            }
        , backgroundColor (hex "#FFFFFF")
        , border3 (px 1) solid (rgba 34 36 38 0.15)
        , Prefix.boxShadow "0 1px 2px 0 rgba(34, 36, 38, 0.15)"
        , borderRadius (rem 0.28571429)
        , minHeight (em 2.85714286)

        -- .ui.menu:after
        , after
            [ property "content" (qt "")
            , display block
            , height zero
            , property "clear" "both"
            , visibility hidden
            ]

        -- .ui.menu:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.menu:last-child
        , lastChild
            [ marginBottom zero ]

        -- .ui.menu .menu
        , margin zero

        -- .ui.menu:not(.vertical) > .menu
        -- display: -webkit-box;
        -- display: -ms-flexbox;
        -- display: flex;
        --
        -- .ui.menu:not(.vertical) .item
        -- Prefix.displayFlex
        -- Prefix.alignItems "center"
        --
        -- .ui.menu
        , fontSize (rem 1)
        ]
            ++ additionalStyles


itemBasis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
itemBasis additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.menu .item
          position relative
        , typography
            { init
                | verticalAlign = Typography.middle
                , textTransform = Typography.none
                , fontWeight = Typography.normal
                , lineHeight = Typography.int 1
                , textDecoration = Typography.none
            }
        , property "-webkit-tap-highlight-color" "transparent"
        , Prefix.flex "0 0 auto"
        , Prefix.userSelect "none"
        , property "background" "none"
        , padding2 (em 0.92857143) (em 1.14285714)
        , color (rgba 0 0 0 0.87)
        , property "-webkit-transition" "background 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "background 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "background 0.1s ease, box-shadow 0.1s ease, color 0.1s ease"
        , property "transition" "background 0.1s ease, box-shadow 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"

        -- .ui.menu > .item:first-child
        , firstChild
            [ borderRadius4 (rem 0.28571429) zero zero (rem 0.28571429) ]

        -- .ui.menu .item:before
        , before
            [ position absolute
            , property "content" (qt "")
            , top zero
            , right zero
            , height (pct 100)
            , width (px 1)
            , backgroundColor (rgba 34 36 38 0.1)
            ]
        ]
            ++ additionalStyles


menu : List (Attribute msg) -> List (Html msg) -> Html msg
menu =
    menuBasis []


item : List (Attribute msg) -> List (Html msg) -> Html msg
item =
    itemBasis []


activeItem : List (Attribute msg) -> List (Html msg) -> Html msg
activeItem =
    itemBasis
        [ -- .ui.menu .active.item
          backgroundColor (rgba 0 0 0 0.05)
        , color (rgba 0 0 0 0.95)
        , fontWeight normal
        , Prefix.boxShadow "none"
        ]


leftMenu : List (Attribute msg) -> List (Html msg) -> Html msg
leftMenu =
    Html.styled Html.div
        [ -- .ui.menu:not(.vertical) .right.item
          -- .ui.menu:not(.vertical) .right.menu
          Prefix.displayFlex
        , marginRight auto |> important

        -- .ui.menu:not(.vertical) :not(.dropdown) > .left.menu
        -- .ui.menu:not(.vertical) :not(.dropdown) > .right.menu
        , display inherit
        ]


rightMenu : List (Attribute msg) -> List (Html msg) -> Html msg
rightMenu =
    Html.styled Html.div
        [ -- .ui.menu:not(.vertical) .right.item
          -- .ui.menu:not(.vertical) .right.menu
          Prefix.displayFlex
        , marginLeft auto |> important

        -- .ui.menu:not(.vertical) :not(.dropdown) > .left.menu,
        -- .ui.menu:not(.vertical) :not(.dropdown) > .right.menu
        , display inherit

        -- .ui.menu .right.item::before
        -- .ui.menu .right.menu > .item::before
        -- right: auto;
        -- left: 0;
        ]


centerMenu : List (Attribute msg) -> List (Html msg) -> Html msg
centerMenu =
    Html.styled Html.div
        [ -- .ui.menu:not(.vertical) .center.item
          -- .ui.menu:not(.vertical) .center.menu
          Prefix.displayFlex
        , marginLeft auto |> important
        , marginRight auto |> important
        ]


secondaryMenu : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenu =
    menuBasis
        [ -- .ui.secondary.menu
          property "background" "none"
        , marginLeft (em -0.35714286)
        , marginRight (em -0.35714286)
        , borderRadius zero
        , property "border" "none"
        , Prefix.boxShadow "none"
        ]


secondaryMenuItem : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenuItem additionalStyles =
    itemBasis <|
        [ -- .ui.secondary.menu .item
          Prefix.alignSelf "center"
        , Prefix.boxShadow "none"
        , property "border" "none"
        , padding2 (em 0.78571429) (em 0.92857143)
        , margin2 zero (em 0.35714286)
        , property "background" "none"
        , property "-webkit-transition" "color 0.1s ease"
        , property "transition" "color 0.1s ease"
        , borderRadius (rem 0.28571429)

        -- .ui.secondary.menu .item:before
        , before
            [ display none |> important ]
        ]
            ++ additionalStyles


secondaryMenuActiveItem : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenuActiveItem =
    secondaryMenuItem
        [ -- .ui.secondary.menu .active.item
          Prefix.boxShadow "none"
        , backgroundColor (rgba 0 0 0 0.05)
        , color (rgba 0 0 0 0.95)
        , borderRadius (rem 0.28571429)
        ]


verticalMenu : List (Attribute msg) -> List (Html msg) -> Html msg
verticalMenu =
    menuBasis
        [ -- .ui.vertical.menu
          display block
        , property "-webkit-box-orient" "vertical"
        , property "-webkit-box-direction" "normal"
        , Prefix.flexDirection "column"
        , backgroundColor (hex "#FFFFFF")
        , Prefix.boxShadow "0 1px 2px 0 rgba(34, 36, 38, 0.15)"

        -- .ui.vertical.menu
        , width (rem 15)
        ]


verticalMenuItem : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
verticalMenuItem additionalStyles =
    itemBasis <|
        [ -- .ui.vertical.menu .item
          display block
        , property "background" "none"
        , property "border-top" "none"
        , property "border-right" "none"

        -- .ui.vertical.menu > .item:first-child
        , firstChild
            [ borderRadius4 (rem 0.28571429) (rem 0.28571429) zero zero ]

        -- .ui.vertical.menu > .item:last-child
        , lastChild
            [ borderRadius4 zero zero (rem 0.28571429) (rem 0.28571429) ]

        -- .ui.vertical.menu .item:before
        , before
            [ position absolute
            , property "content" (qt "")
            , top zero
            , left zero
            , width (pct 100)
            , height (px 1)
            , backgroundColor (rgba 34 36 38 0.1)
            ]

        -- .ui.vertical.menu .item:first-child:before
        , firstChild
            [ before
                [ display none |> important ]
            ]
        ]
            ++ additionalStyles


verticalMenuActiveItem : List (Attribute msg) -> List (Html msg) -> Html msg
verticalMenuActiveItem =
    verticalMenuItem
        [ -- .ui.vertical.menu .active.item
          backgroundColor (rgba 0 0 0 0.05)
        , borderRadius zero
        , Prefix.boxShadow "none"
        ]


verticalMenuActiveItemLabel : List (Attribute msg) -> List (Html msg) -> Html msg
verticalMenuActiveItemLabel =
    UI.Label.basis Nothing
        [ -- .ui.menu .item > .label:not(.floating)
          marginLeft (em 1)
        , padding2 (em 0.3) (em 0.78571429)

        -- .ui.vertical.menu .item > .label
        , marginTop (em -0.15)
        , marginBottom (em -0.15)
        , padding2 (em 0.3) (em 0.78571429)

        -- .ui.menu .item > .label
        , backgroundColor (hex "#999999")
        , color (hex "#FFFFFF")

        -- .ui.vertical.menu .item > .label
        , float right
        , textAlign center
        ]
