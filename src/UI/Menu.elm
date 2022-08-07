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
import Css.Extra exposing (prefixed)
import Css.Layout as Layout exposing (layout)
import Css.Palette as Palette exposing (darkPalette, palette, paletteWith, setBackground, setBackgroundIf, setBorderIf, setColor, setShadowIf)
import Css.Typography as Typography exposing (init, typography)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Attribute, Html)
import UI.Label


menuBasis : { vertical : Bool, border : Bool, shadow : Bool, theme : Theme } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
menuBasis { vertical, border, shadow, theme } additionalStyles =
    let
        defaultTypography =
            Typography.default

        defaultPalette =
            Palette.init
                |> setBackgroundIf shadow (hex "#FFF")
                |> setBorderIf border (rgba 34 36 38 0.15)

        darkPalette_ =
            Palette.init |> setBackground (hex "#1B1C1D")
    in
    Html.styled Html.div
        [ margin2 (rem 1) zero
        , if shadow then
            borderRadius (rem 0.28571429)

          else
            batch []

        -- Palette
        , paletteWith { border = border3 (px 1) solid }
            (defaultPalette |> setShadowIf shadow (prefixed [] "box-shadow" "0 1px 2px 0 rgba(34, 36, 38, 0.15)"))
        , darkPalette theme darkPalette_

        -- .ui.menu
        , prefixed [] "display" "flex"
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

        -- AdditionalStyles
        , batch additionalStyles
        ]


itemBasis :
    { tag : List (Attribute msg) -> List (Html msg) -> Html msg
    , vertical : Bool
    , borderAndShadows : Bool
    , theme : Theme
    }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
itemBasis { tag, vertical, borderAndShadows, theme } additionalStyles =
    let
        initialLayout =
            Layout.init
    in
    Html.styled tag
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
        , let
            defaultPaletteOnHover =
                Palette.init
                    |> setBackground (rgba 0 0 0 0.03)
                    |> setColor (rgba 0 0 0 0.95)

            darkPaletteOnHover =
                -- .ui.link.inverted.menu .item:hover
                -- .ui.inverted.menu .dropdown.item:hover
                -- .ui.inverted.menu .link.item:hover
                -- .ui.inverted.menu a.item:hover
                Palette.init
                    |> setBackground (rgba 255 255 255 0.08)
                    |> setColor (hex "#ffffff")
          in
          batch <|
            if tag [] [] == Html.a [] [] then
                [ -- .ui.link.menu .item:hover
                  -- .ui.menu .dropdown.item:hover
                  -- .ui.menu .link.item:hover
                  -- .ui.menu a.item:hover
                  hover
                    [ cursor pointer
                    , palette defaultPaletteOnHover
                    , darkPalette theme darkPaletteOnHover
                    ]

                -- .ui.link.menu .item:active
                -- .ui.menu .link.item:active
                -- .ui.menu a.item:active
                , active
                    [ palette
                        (Palette.init
                            |> setBackground (rgba 0 0 0 0.03)
                            |> setColor (rgba 0 0 0 0.95)
                        )
                    ]
                ]

            else
                []

        -- Vertical
        , let
            defaultPalette =
                Palette.init |> setBackground (rgba 34 36 38 0.1)

            darkPalette_ =
                -- .ui.vertical.inverted.menu .item:before
                Palette.init |> setBackground (rgba 255 255 255 0.08)
          in
          batch <|
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
                    , palette defaultPalette
                    , darkPalette theme darkPalette_
                    ]

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
        , let
            transparent =
                rgba 0 0 0 0

            darkPalette_ =
                -- .ui.inverted.menu .item
                -- .ui.inverted.menu .item > a:not(.ui)
                Palette.init
                    |> setBackground transparent
                    |> setColor (rgba 255 255 255 0.9)
          in
          darkPalette theme darkPalette_

        -- AdditionalStyles
        , batch additionalStyles
        ]


menu : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
menu { theme } =
    menuBasis { vertical = False, border = True, shadow = True, theme = theme } []


item : List (Attribute msg) -> List (Html msg) -> Html msg
item =
    itemBasis { tag = Html.div, vertical = False, borderAndShadows = True, theme = Light } []


activeItem : List (Attribute msg) -> List (Html msg) -> Html msg
activeItem =
    itemBasis { tag = Html.div, vertical = False, borderAndShadows = True, theme = Light }
        [ -- .ui.menu .active.item
          palette
            (Palette.init
                |> setBackground (rgba 0 0 0 0.05)
                |> setColor (rgba 0 0 0 0.95)
            )
        , fontWeight normal
        , prefixed [] "box-shadow" "none"
        ]


linkItem : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
linkItem { theme } =
    itemBasis { tag = Html.a, vertical = False, borderAndShadows = True, theme = theme } []


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


secondaryMenu : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenu { theme } =
    menuBasis { vertical = False, border = False, shadow = False, theme = theme } []


secondaryMenuItem : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenuItem additionalStyles =
    itemBasis
        { tag = Html.div
        , vertical = False
        , borderAndShadows = False
        , theme = Light
        }
        additionalStyles


secondaryMenuActiveItem : List (Attribute msg) -> List (Html msg) -> Html msg
secondaryMenuActiveItem =
    secondaryMenuItem
        [ -- .ui.secondary.menu .active.item
          prefixed [] "box-shadow" "none"
        , palette
            (Palette.init
                |> setBackground (rgba 0 0 0 0.05)
                |> setColor (rgba 0 0 0 0.95)
            )
        , borderRadius (rem 0.28571429)
        ]


verticalMenu :
    { theme : Theme, additionalStyles : List Style }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
verticalMenu { theme, additionalStyles } =
    menuBasis { vertical = True, border = True, shadow = True, theme = theme } additionalStyles


verticalMenuItem :
    { theme : Theme, additionalStyles : List Style }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
verticalMenuItem { theme, additionalStyles } =
    itemBasis
        { tag = Html.div
        , vertical = True
        , borderAndShadows = True
        , theme = theme
        }
        additionalStyles


verticalMenuLinkItem :
    { theme : Theme, additionalStyles : List Style }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
verticalMenuLinkItem { theme, additionalStyles } =
    itemBasis
        { tag = Html.a
        , vertical = True
        , borderAndShadows = True
        , theme = theme
        }
        additionalStyles


verticalMenuActiveItem : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
verticalMenuActiveItem { theme } =
    verticalMenuItem
        { theme = theme
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
        , palette
            (Palette.init
                |> setBackground (hex "#999999")
                |> setColor (hex "#FFFFFF")
            )

        -- .ui.vertical.menu .item > .label
        , float right
        , textAlign center
        ]
