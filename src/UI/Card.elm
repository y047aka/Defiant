module UI.Card exposing
    ( cards, card
    , content, extraContent
    )

{-|

@docs cards, card
@docs content, extraContent

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, descendants, everything, selector)
import Css.Palette exposing (paletteWith)
import Css.Typography exposing (fomanticFontFamilies)
import Data.Theme exposing (Theme, isDark)
import Html.Styled as Html exposing (Attribute, Html, text)


cards : List (Attribute msg) -> List (Html msg) -> Html msg
cards =
    Html.styled Html.div <|
        [ -- .ui.cards
          prefixed [] "display" "flex"
        , margin2 (em -0.875) (em -0.5)
        , prefixed [] "flex-wrap" "wrap"

        -- .ui.cards > .card
        , children
            [ Css.Global.div
                [ prefixed [] "display" "flex"
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


cardBasis : { border : Bool, shadow : Bool, theme : Theme } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
cardBasis { border, shadow, theme } additionalStyles =
    let
        paletteBasis =
            { background = Just (hex "#FFF")
            , color = Nothing
            , border = Nothing
            }
    in
    Html.styled Html.div
        [ position relative
        , margin2 (em 1) zero
        , padding zero
        , borderRadius (rem 0.28571429)
        , paletteWith { border = border3 (px 1) solid } <|
            case ( border, isDark theme ) of
                ( False, False ) ->
                    paletteBasis

                ( True, False ) ->
                    { paletteBasis | border = Just (hex "#D4D4D5") }

                ( False, True ) ->
                    { paletteBasis | background = Just (hex "#1B1C1D") }

                ( True, True ) ->
                    { paletteBasis | background = Just (hex "#1B1C1D"), border = Just (hex "#D4D4D5") }
        , case ( shadow, isDark theme ) of
            ( True, False ) ->
                prefixed [] "box-shadow" "0 1px 2px 0 #D4D4D5"

            ( True, True ) ->
                -- .ui.inverted.cards > .card
                -- .ui.inverted.card
                prefixed [] "box-shadow" "0 1px 3px 0 #555555, 0 0 0 1px #555555"

            ( False, _ ) ->
                batch []

        -- .ui.cards > .card
        -- .ui.card
        , maxWidth (pct 100)
        , prefixed [] "display" "flex"
        , property "-webkit-box-orient" "vertical"
        , property "-webkit-box-direction" "normal"
        , prefixed [] "flex-direction" "column"
        , width (px 290)
        , minHeight zero
        , property "-webkit-transition" "-webkit-box-shadow 0.1s ease, -webkit-transform 0.1s ease"
        , property "transition" "-webkit-box-shadow 0.1s ease, -webkit-transform 0.1s ease"
        , property "transition" "box-shadow 0.1s ease, transform 0.1s ease"
        , property "transition" "box-shadow 0.1s ease, transform 0.1s ease, -webkit-box-shadow 0.1s ease, -webkit-transform 0.1s ease"
        , property "z-index" "''"
        , property "word-wrap" "break-word"

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

        -- AdditionalStyles
        , batch additionalStyles
        ]


card : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
card { theme } =
    cardBasis { border = True, shadow = True, theme = theme } []


contentBasis : { theme : Theme, additionalStyles : List Style } -> List (Attribute msg) -> List (Html msg) -> Html msg
contentBasis { theme, additionalStyles } =
    Html.styled Html.div
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
        , prefixed [] "box-shadow" "none"
        , fontSize (em 1)
        , borderRadius zero

        -- Inverted
        , if isDark theme then
            -- .ui.inverted.cards > .card > .content
            -- .ui.inverted.card > .content
            borderTop3 (px 1) solid (rgba 255 255 255 0.15)

          else
            borderTop3 (px 1) solid (rgba 34 36 38 0.1)

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

        -- AdditionalStyles
        , batch additionalStyles
        ]


content :
    { theme : Theme }
    -> List (Attribute msg)
    ->
        { header : List (Html msg)
        , meta : List (Html msg)
        , description : List (Html msg)
        }
    -> Html msg
content { theme } attributes hmd =
    let
        has list f =
            case list of
                [] ->
                    text ""

                nonEmpty ->
                    f nonEmpty

        options =
            { theme = theme }
    in
    contentBasis { theme = theme, additionalStyles = [] }
        attributes
        [ has hmd.header (header options [])
        , has hmd.meta (meta options [])
        , has hmd.description (description options [])
        ]


header : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
header { theme } =
    Html.styled Html.header
        [ -- .ui.cards > .card > .content > .header
          -- .ui.card > .content > .header
          display block
        , property "margin" "''"
        , fontFamilies fomanticFontFamilies

        -- .ui.cards > .card > .content > .header:not(.ui)
        -- .ui.card > .content > .header:not(.ui)
        , fontWeight bold
        , fontSize (em 1.28571429)
        , marginTop (em -0.21425)
        , lineHeight (em 1.28571429)

        -- Inverted
        , if isDark theme then
            -- .ui.inverted.cards > .card > .content > .header
            -- .ui.inverted.card > .content > .header
            color (rgba 255 255 255 0.9)

          else
            color (rgba 0 0 0 0.85)
        ]


description : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
description { theme } =
    Html.styled Html.div <|
        [ -- .ui.cards > .card > .content > .meta + .description
          -- .ui.cards > .card > .content > .header + .description
          -- .ui.card > .content > .meta + .description
          -- .ui.card > .content > .header + .description
          marginTop (em 0.5)

        -- .ui.cards > .card > .content > .description
        -- .ui.card > .content > .description
        , property "clear" "both"

        -- Inverted
        , if isDark theme then
            -- .ui.inverted.cards > .card > .content > .description,
            -- .ui.inverted.card > .content > .description {
            color (rgba 255 255 255 0.8)

          else
            color (rgba 0 0 0 0.68)
        ]


meta : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
meta { theme } =
    Html.styled Html.div <|
        [ -- .ui.cards > .card .meta
          -- .ui.card .meta
          fontSize (em 1)

        -- Inverted
        , if isDark theme then
            -- .ui.inverted.cards > .card .meta
            -- .ui.inverted.card .meta
            color (rgba 255 255 255 0.7)

          else
            color (rgba 0 0 0 0.4)

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


extraContent : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
extraContent { theme } =
    contentBasis
        { theme = theme
        , additionalStyles =
            [ -- .ui.cards > .card > .extra
              -- .ui.card > .extra
              maxWidth (pct 100)
            , minHeight zero |> important
            , property "-webkit-box-flex" "0"
            , property "-ms-flex-positive" "0"
            , property "flex-grow" "0"
            , position static
            , property "background" "none"
            , width auto
            , margin2 zero zero
            , padding2 (em 0.75) (em 1)
            , top zero
            , left zero

            -- Inverted
            , if isDark theme then
                -- .ui.inverted.cards > .card > .extra
                -- .ui.inverted.card > .extra
                batch
                    [ color (rgba 255 255 255 0.7)
                    , borderTop3 (px 1) solid (rgba 255 255 255 0.15) |> important
                    ]

              else
                batch
                    [ color (rgba 0 0 0 0.4)
                    , borderTop3 (px 1) solid (rgba 0 0 0 0.05) |> important
                    ]
            , prefixed [] "box-shadow" "none"
            , property "-webkit-transition" "color 0.1s ease"
            , property "transition" "color 0.1s ease"
            ]
        }
