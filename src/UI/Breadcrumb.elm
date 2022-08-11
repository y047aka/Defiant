module UI.Breadcrumb exposing
    ( breadcrumb
    , miniBreadCrumb, tinyBreadCrumb, smallBreadCrumb, mediumBreadCrumb, largeBreadCrumb, bigBreadCrumb, hugeBreadCrumb, massiveBreadCrumb
    , BreadcrumbItem
    )

{-|

@docs BreadcrumbIte
@docs breadcrumb

@docs miniBreadCrumb, tinyBreadCrumb, smallBreadCrumb, mediumBreadCrumb, largeBreadCrumb, bigBreadCrumb, hugeBreadCrumb, massiveBreadCrumb

-}

import Css exposing (..)
import Css.Extra exposing (orNone)
import Css.Palette as Palette exposing (darkPalette, palette, setColor)
import Data exposing (Size(..))
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Attribute, Html, text)
import Html.Styled.Attributes exposing (href)
import Svg.Styled exposing (Attribute)


type alias BreadcrumbItem =
    { label : String
    , url : String
    }


basis : { size : Maybe (FontSize a), theme : Theme } -> List (Html msg) -> Html msg
basis { size, theme } =
    let
        darkPalette_ =
            -- .ui.inverted.breadcrumb
            Palette.init |> setColor (hex "#DCDDDE")
    in
    Html.styled Html.div
        [ -- .ui.breadcrumb
          lineHeight (em 1.4285)
        , display inlineBlock
        , margin2 zero zero
        , verticalAlign middle

        -- .ui.breadcrumb:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.breadcrumb:last-child
        , lastChild
            [ marginBottom zero ]

        -- Variations
        , orNone size fontSize

        -- Inverted
        , darkPalette theme darkPalette_
        ]
        []


breadcrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
breadcrumb options children =
    let
        length =
            List.length children

        section_ index { label, url } =
            if index + 1 == length then
                activeSection [] [ text label ]

            else
                section [ href url ] [ text label ]

        divider_ =
            divider { theme = options.theme } [] [ options.divider ]
    in
    basis { size = Nothing, theme = options.theme }
        (children
            |> List.indexedMap section_
            |> List.intersperse divider_
        )


divider : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
divider { theme } =
    let
        defaultPalette =
            Palette.init |> setColor (rgba 0 0 0 0.4)

        darkPalette_ =
            -- .ui.inverted.breadcrumb > .divider
            Palette.init |> setColor (rgba 255 255 255 0.7)
    in
    Html.styled Html.div
        [ -- .ui.breadcrumb .divider
          display inlineBlock
        , opacity (num 0.7)
        , margin3 zero (rem 0.21428571) zero
        , fontSize (em 0.92857143)
        , verticalAlign baseline

        -- .ui.breadcrumb .icon.divider
        , fontSize (em 0.85714286)
        , verticalAlign baseline

        -- Palette
        , palette defaultPalette
        , darkPalette theme darkPalette_

        -- Override
        , margin3 zero (rem 0.71428571) zero
        ]


sectionBasis : { active : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
sectionBasis { active } =
    let
        tag =
            if active then
                Html.div

            else
                Html.a
    in
    Html.styled tag
        [ -- .ui.breadcrumb .section
          display inlineBlock
        , margin zero
        , padding zero

        -- Active
        , batch <|
            if active then
                [ -- .ui.breadcrumb .active.section
                  fontWeight bold
                ]

            else
                [ -- .ui.breadcrumb a
                  color (hex "#4183C4")

                -- .ui.breadcrumb a:hover
                , hover
                    [ color (hex "#1e70bf") ]

                -- .ui.breadcrumb a.section
                , cursor pointer
                ]
        ]


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    sectionBasis { active = False }


activeSection : List (Attribute msg) -> List (Html msg) -> Html msg
activeSection =
    sectionBasis { active = True }



-- Variations


sizedBreadCrumb : { divider : Html msg, theme : Theme } -> FontSize a -> List BreadcrumbItem -> Html msg
sizedBreadCrumb options size children =
    let
        length =
            List.length children

        section_ index { label, url } =
            if index + 1 == length then
                activeSection [] [ text label ]

            else
                section [ href url ] [ text label ]

        divider_ =
            divider { theme = options.theme } [] [ options.divider ]
    in
    basis { size = Just size, theme = options.theme }
        (children
            |> List.indexedMap section_
            |> List.intersperse divider_
        )


miniBreadCrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
miniBreadCrumb options =
    -- .ui.mini.breadcrumb
    sizedBreadCrumb options (sizeSelector Mini)


tinyBreadCrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
tinyBreadCrumb options =
    -- .ui.tiny.breadcrumb
    sizedBreadCrumb options (sizeSelector Tiny)


smallBreadCrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
smallBreadCrumb options =
    -- .ui.small.breadcrumb
    sizedBreadCrumb options (sizeSelector Small)


mediumBreadCrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
mediumBreadCrumb options =
    -- .ui.breadcrumb
    sizedBreadCrumb options (sizeSelector Medium)


largeBreadCrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
largeBreadCrumb options =
    -- .ui.large.breadcrumb
    sizedBreadCrumb options (sizeSelector Large)


bigBreadCrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
bigBreadCrumb options =
    -- .ui.big.breadcrumb
    sizedBreadCrumb options (sizeSelector Big)


hugeBreadCrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
hugeBreadCrumb options =
    -- .ui.huge.breadcrumb
    sizedBreadCrumb options (sizeSelector Huge)


massiveBreadCrumb : { divider : Html msg, theme : Theme } -> List BreadcrumbItem -> Html msg
massiveBreadCrumb options =
    -- .ui.massive.breadcrumb
    sizedBreadCrumb options (sizeSelector Massive)


sizeSelector : Size -> Css.Rem
sizeSelector size =
    case size of
        Massive ->
            rem 1.71428571

        Huge ->
            rem 1.42857143

        Big ->
            rem 1.28571429

        Large ->
            rem 1.14285714

        Medium ->
            rem 1

        Small ->
            rem 0.92857143

        Tiny ->
            rem 0.85714286

        Mini ->
            rem 0.78571429
