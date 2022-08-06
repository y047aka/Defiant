module UI.Header exposing
    ( header
    , massiveHeader, hugeHeader, bigHeader, largeHeader, mediumHeader, smallHeader, tinyHeader, miniHeader
    , subHeader
    , iconHeader, iconHeaderContent
    )

{-|

@docs header
@docs massiveHeader, hugeHeader, bigHeader, largeHeader, mediumHeader, smallHeader, tinyHeader, miniHeader
@docs subHeader
@docs iconHeader, iconHeaderContent

-}

import Css exposing (..)
import Css.Global exposing (adjacentSiblings, children, typeSelector)
import Css.Palette as Palette exposing (darkPalette, palette, setColor)
import Css.Typography as Typography exposing (typography)
import Data exposing (Size(..))
import Data.Theme exposing (Theme)
import Html.Styled as Html exposing (Attribute, Html)


basis : { theme : Theme } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { theme } additionalStyles =
    let
        headingTypography =
            Typography.heading

        defaultPalette =
            Palette.init |> setColor (rgba 0 0 0 0.87)

        darkPalette_ =
            -- .ui.inverted.header
            Palette.init |> setColor (hex "#FFFFFF")
    in
    Html.styled Html.header
        [ -- .ui.header
          borderStyle none
        , margin3 (calc (rem 2) minus (em 0.1428571428571429)) zero (rem 1)
        , padding2 zero zero
        , typography
            { headingTypography
                | fontSize = ""
                , textTransform = Typography.none
            }

        -- Palette
        , palette defaultPalette
        , darkPalette theme darkPalette_

        -- .ui.header:first-child
        , firstChild
            [ marginTop (em -0.14285714) ]

        --  .ui.header:last-child
        , lastChild
            [ marginBottom zero ]

        -- .ui.header + p
        , adjacentSiblings
            [ typeSelector "p"
                [ marginTop zero ]
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


header : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
header props =
    basis props []


miniHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
miniHeader props =
    basis props (sizeSelector Mini)


tinyHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
tinyHeader props =
    basis props (sizeSelector Tiny)


smallHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
smallHeader props =
    basis props (sizeSelector Small)


mediumHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
mediumHeader props =
    basis props []


largeHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
largeHeader props =
    basis props (sizeSelector Large)


bigHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
bigHeader props =
    basis props (sizeSelector Big)


hugeHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
hugeHeader props =
    basis props (sizeSelector Huge)


massiveHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
massiveHeader props =
    basis props (sizeSelector Massive)


sizeSelector : Size -> List Style
sizeSelector size =
    case size of
        Massive ->
            -- .ui.massive.header
            [ fontSize (em 2.28571429)
            , minHeight (em 1)
            ]

        Huge ->
            -- .ui.huge.header
            [ fontSize (em 2)
            , minHeight (em 1)
            ]

        Big ->
            -- .ui.big.header
            [ fontSize (em 1.85714286) ]

        Large ->
            -- .ui.large.header
            [ fontSize (em 1.71428571) ]

        Medium ->
            []

        Small ->
            -- .ui.small.header
            [ fontSize (em 1.07142857) ]

        Tiny ->
            -- .ui.tiny.header
            [ fontSize (em 1) ]

        Mini ->
            -- .ui.mini.header
            [ fontSize (em 0.85714286) ]


subHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
subHeader { theme } =
    let
        defaultPalette =
            Palette.init |> setColor (rgba 0 0 0 0.6)

        darkPalette_ =
            -- .ui.inverted.header .sub.header
            Palette.init |> setColor (rgba 255 255 255 0.8)
    in
    Html.styled Html.div
        [ -- .ui.header .sub.header
          display block
        , fontWeight normal
        , padding zero
        , margin zero
        , fontSize (rem 1)
        , lineHeight (em 1.2)

        -- Palette
        , palette defaultPalette
        , darkPalette theme darkPalette_
        ]


iconHeader : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
iconHeader props =
    basis props
        [ -- .ui.icon.header
          display inlineBlock
        , textAlign center
        , margin3 (rem 2) zero (rem 1)

        -- .ui.icon.header:after
        , after
            [ property "content" "''"
            , display block
            , height zero
            , property "clear" "both"
            , visibility hidden
            ]

        -- .ui.icon.header:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.icon.header > i.icon
        , children
            [ Css.Global.i
                [ property "float" "none"
                , display block
                , width auto
                , height auto
                , lineHeight (int 1)
                , padding zero
                , fontSize (em 3)
                , margin3 zero auto (rem 0.5)
                , opacity (int 1)
                ]
            ]
        ]


iconHeaderContent : List (Attribute msg) -> List (Html msg) -> Html msg
iconHeaderContent =
    Html.styled Html.div
        [ -- .ui.icon.header .content
          display block
        , padding zero
        ]
