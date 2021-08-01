module UI.Menu exposing
    ( menu, item, activeItem, linkItem
    , leftMenu, rightMenu, centerMenu
    , secondaryMenu, secondaryMenuItem, secondaryMenuActiveItem
    , verticalMenu, verticalMenuItem, verticalMenuLinkItem, verticalMenuActiveItem, verticalMenuActiveItemLabel
    )

{-|

@docs menu, item, activeItem, linkItem
@docs leftMenu, rightMenu, centerMenu
@docs secondaryMenu, secondaryMenuItem, secondaryMenuActiveItem
@docs verticalMenu, verticalMenuItem, verticalMenuLinkItem, verticalMenuActiveItem, verticalMenuActiveItemLabel

-}

import Css exposing (..)
import Css.Extra exposing (prefixed, when)
import Css.Layout as Layout exposing (layout)
import Css.Typography as Typography exposing (init, typography)
import Html.Styled as Html exposing (Attribute, Html)
import UI.Internal exposing (styledBlock)
import UI.Label


menuBasis : { vertical : Bool, border : Bool, shadow : Bool, inverted : Bool } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
menuBasis { vertical, border, shadow, inverted } additionalStyles =
    let
        defaultTypography =
            Typography.default

        defaultPalette =
            { background =
                if shadow then
                    Just (hex "#FFF")

                else
                    Nothing
            , color = Nothing
            , border =
                if border then
                    Just (rgba 34 36 38 0.15)

                else
                    Nothing
            }

        invertedPalette =
            { defaultPalette
                | background = Just (hex "#1B1C1D")
                , border = Nothing
            }
    in
    styledBlock
        { tag = Html.div
        , position = Nothing
        , margin = Just <| margin2 (rem 1) zero
        , padding = Nothing
        , borderRadius =
            if shadow then
                Just (rem 0.28571429)

            else
                Nothing
        , palette =
            if inverted then
                invertedPalette

            else
                defaultPalette
        , boxShadow =
            case ( shadow, inverted ) of
                ( True, False ) ->
                    Just "0 1px 2px 0 rgba(34, 36, 38, 0.15)"

                _ ->
                    Nothing
        }
    <|
        [ -- .ui.menu
          prefixed [] "display" "flex"
        , typography { defaultTypography | fontWeight = Typography.normal }
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
        -- , margin zero
        --
        -- .ui.menu:not(.vertical) > .menu
        -- display: -webkit-box;
        -- display: -ms-flexbox;
        -- display: flex;
        --
        -- .ui.menu:not(.vertical) .item
        -- prefixed [] "display" "flex"
        -- prefixed [] "align-items" "center"
        --
        -- .ui.menu
        , fontSize (rem 1)

        -- Vertical
        , batch <|
            if vertical then
                [ -- .ui.vertical.menu
                  display block
                , property "-webkit-box-orient" "vertical"
                , property "-webkit-box-direction" "normal"
                , prefixed [] "flex-direction" "column"

                -- .ui.vertical.menu
                , width (rem 15)
                ]

            else
                []

        -- Shadow
        , batch <|
            if shadow then
                []

            else
                [ -- .ui.secondary.menu
                  marginLeft (em -0.35714286)
                , marginRight (em -0.35714286)
                ]
        ]
            ++ additionalStyles


itemBasis :
    { tag : List (Attribute msg) -> List (Html msg) -> Html msg
    , vertical : Bool
    , borderAndShadows : Bool
    , inverted : Bool
    }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
itemBasis { tag, vertical, borderAndShadows, inverted } additionalStyles =
    let
        initialLayout =
            Layout.init
    in
    Html.styled tag <|
        [ -- .ui.menu .item
          position relative
        , layout { initialLayout | verticalAlign = Layout.middle }
        , typography
            { init
                | textTransform = Typography.none
                , fontWeight = Typography.normal
                , lineHeight = Typography.int 1
                , textDecoration = Typography.none
            }
        , property "-webkit-tap-highlight-color" "transparent"
        , prefixed [] "flex" "0 0 auto"
        , prefixed [] "user-select" "none"
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

        -- Link
        , batch <|
            if tag [] [] == Html.a [] [] then
                [ -- .ui.link.menu .item:hover
                  -- .ui.menu .dropdown.item:hover
                  -- .ui.menu .link.item:hover
                  -- .ui.menu a.item:hover
                  hover
                    [ cursor pointer
                    , backgroundColor (rgba 0 0 0 0.03)
                    , color (rgba 0 0 0 0.95)
                    ]

                -- .ui.link.inverted.menu .item:hover
                -- .ui.inverted.menu .dropdown.item:hover
                -- .ui.inverted.menu .link.item:hover
                -- .ui.inverted.menu a.item:hover
                , when inverted <|
                    hover
                        [ property "background" "rgba(255, 255, 255, 0.08)"
                        , color (hex "#ffffff")
                        ]

                -- .ui.link.menu .item:active
                -- .ui.menu .link.item:active
                -- .ui.menu a.item:active
                , active
                    [ backgroundColor (rgba 0 0 0 0.03)
                    , color (rgba 0 0 0 0.95)
                    ]
                ]

            else
                []

        -- Vertical
        , batch <|
            if vertical then
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

                -- .ui.vertical.inverted.menu .item:before
                , when inverted <|
                    before
                        [ backgroundColor (rgba 255 255 255 0.08) ]

                -- .ui.vertical.menu .item:first-child:before
                , firstChild
                    [ before
                        [ display none |> important ]
                    ]
                ]

            else
                []

        -- Border And Shadows
        , batch <|
            if borderAndShadows then
                []

            else
                [ -- .ui.secondary.menu .item
                  prefixed [] "align-self" "center"
                , prefixed [] "box-shadow" "none"
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

        -- Inverted
        , when inverted <|
            batch
                [ -- .ui.inverted.menu .item
                  -- .ui.inverted.menu .item > a:not(.ui)
                  property "background" "transparent"
                , color (rgba 255 255 255 0.9)
                ]
        ]
            ++ additionalStyles


menu : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
menu { inverted } =
    menuBasis { vertical = False, border = True, shadow = True, inverted = inverted } []


item : List (Attribute msg) -> List (Html msg) -> Html msg
item =
    itemBasis { tag = Html.div, vertical = False, borderAndShadows = True, inverted = False } []


activeItem : List (Attribute msg) -> List (Html msg) -> Html msg
activeItem =
    itemBasis { tag = Html.div, vertical = False, borderAndShadows = True, inverted = False }
        [ -- .ui.menu .active.item
          backgroundColor (rgba 0 0 0 0.05)
        , color (rgba 0 0 0 0.95)
        , fontWeight normal
        , prefixed [] "box-shadow" "none"
        ]


linkItem : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
linkItem { inverted } =
    itemBasis { tag = Html.a, vertical = False, borderAndShadows = True, inverted = inverted } []


leftMenu : List (Attribute msg) -> List (Html msg) -> Html msg
leftMenu =
    Html.styled Html.div
        [ -- .ui.menu:not(.vertical) .right.item
          -- .ui.menu:not(.vertical) .right.menu
          prefixed [] "display" "flex"
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
          prefixed [] "display" "flex"
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
          prefixed [] "display" "flex"
        , marginLeft auto |> important
        , marginRight auto |> important
        ]


secondaryMenu : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenu { inverted } =
    menuBasis { vertical = False, border = False, shadow = False, inverted = inverted } []


secondaryMenuItem : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenuItem additionalStyles =
    itemBasis
        { tag = Html.div
        , vertical = False
        , borderAndShadows = False
        , inverted = False
        }
        additionalStyles


secondaryMenuActiveItem : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenuActiveItem =
    secondaryMenuItem
        [ -- .ui.secondary.menu .active.item
          prefixed [] "box-shadow" "none"
        , backgroundColor (rgba 0 0 0 0.05)
        , color (rgba 0 0 0 0.95)
        , borderRadius (rem 0.28571429)
        ]


verticalMenu :
    { inverted : Bool, additionalStyles : List Style }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
verticalMenu { inverted, additionalStyles } =
    menuBasis { vertical = True, border = True, shadow = True, inverted = inverted } additionalStyles


verticalMenuItem :
    { inverted : Bool, additionalStyles : List Style }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
verticalMenuItem { inverted, additionalStyles } =
    itemBasis
        { tag = Html.div
        , vertical = True
        , borderAndShadows = True
        , inverted = inverted
        }
        additionalStyles


verticalMenuLinkItem :
    { inverted : Bool, additionalStyles : List Style }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
verticalMenuLinkItem { inverted, additionalStyles } =
    itemBasis
        { tag = Html.a
        , vertical = True
        , borderAndShadows = True
        , inverted = inverted
        }
        additionalStyles


verticalMenuActiveItem : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
verticalMenuActiveItem { inverted } =
    verticalMenuItem
        { inverted = inverted
        , additionalStyles =
            [ -- .ui.vertical.menu .active.item
              backgroundColor (rgba 0 0 0 0.05)
            , borderRadius zero
            , prefixed [] "box-shadow" "none"
            ]
        }


verticalMenuActiveItemLabel : List (Attribute msg) -> List (Html msg) -> Html msg
verticalMenuActiveItemLabel =
    UI.Label.basis { border = False, palette = Nothing } <|
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
