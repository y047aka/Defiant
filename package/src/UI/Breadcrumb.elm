module UI.Breadcrumb exposing
    ( breadcrumb, breadcrumbWithProps
    , Divider(..), dividerFromString, dividerToString
    , miniBreadCrumb, tinyBreadCrumb, smallBreadCrumb, mediumBreadCrumb, largeBreadCrumb, bigBreadCrumb, hugeBreadCrumb, massiveBreadCrumb
    , BreadcrumbItem
    )

{-|

@docs BreadcrumbIte
@docs breadcrumb, breadcrumbWithProps
@docs Divider, dividerFromString, dividerToString

@docs miniBreadCrumb, tinyBreadCrumb, smallBreadCrumb, mediumBreadCrumb, largeBreadCrumb, bigBreadCrumb, hugeBreadCrumb, massiveBreadCrumb

-}

import Css exposing (..)
import Css.Extra exposing (orNone)
import Css.Palette as Palette exposing (setColor)
import Css.Palette.Extra exposing (darkPalette)
import Css.Typography as Typography exposing (setFontWeight, typography)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (href)
import Svg.Styled exposing (Attribute)
import Types exposing (Size(..))


type alias BreadcrumbItem =
    { label : String
    , url : String
    }


breadcrumb : List BreadcrumbItem -> Html msg
breadcrumb children =
    breadcrumbWithProps { divider = Slash, size = Nothing, theme = System } children


breadcrumbWithProps : { divider : Divider, size : Maybe (FontSize a), theme : Theme } -> List BreadcrumbItem -> Html msg
breadcrumbWithProps { divider, size, theme } children =
    let
        itemOption =
            { divider = divider, theme = theme }
    in
    breadcrumbInternal
        { wrapper = breadcrumbBasis { size = size, theme = theme }
        , item = item itemOption
        , activeItem = activeItem itemOption
        }
        children


breadcrumbInternal :
    { wrapper : List (Attribute msg) -> List (Html msg) -> Html msg
    , item : List (Attribute msg) -> List (Html msg) -> Html msg
    , activeItem : List (Attribute msg) -> List (Html msg) -> Html msg
    }
    -> List BreadcrumbItem
    -> Html msg
breadcrumbInternal options items =
    let
        section_ index { label, url } =
            if index + 1 == List.length items then
                options.activeItem [] [ text label ]

            else
                options.item [ href url ] [ text label ]
    in
    options.wrapper [] (List.indexedMap section_ items)


breadcrumbBasis : { size : Maybe (FontSize a), theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
breadcrumbBasis { size, theme } =
    Html.styled Html.ul
        [ margin zero
        , padding zero
        , listStyle none

        --
        , displayFlex
        , alignItems center

        -- .ui.breadcrumb
        , lineHeight (em 1.4285)

        -- Variations
        , orNone size fontSize

        -- Inverted
        , darkPalette theme
            -- .ui.inverted.breadcrumb
            (Palette.init |> setColor (hex "#DCDDDE"))
        ]


item : { divider : Divider, theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
item options attributes children =
    itemBasis options [] <|
        [ Html.styled Html.a
            [ cursor pointer
            , color (hex "#4183C4")
            , hover
                [ color (hex "#1e70bf") ]
            ]
            attributes
            children
        ]


activeItem : { divider : Divider, theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
activeItem options attributes children =
    itemBasis options [] <|
        [ Html.styled Html.span
            [ -- .ui.breadcrumb .active.section
              typography (Typography.init |> setFontWeight bold)
            ]
            attributes
            children
        ]


itemBasis : { divider : Divider, theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
itemBasis { divider } =
    let
        svg path =
            "url('data:image/svg+xml;utf-8,<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 10 10\"><g fill=\"none\" stroke-width=\"1\" stroke=\"hsl(0, 0%, 65%)\">" ++ path ++ "</g></svg>')"

        svgIcon =
            case divider of
                Slash ->
                    svg "<path d=\"M7 1L3 9\"></path>"

                RightChevron ->
                    svg "<path d=\"M3 1L7 5L3 9\"></path>"
    in
    Html.styled Html.li
        [ margin zero
        , padding zero
        , displayFlex
        , alignItems center
        , nthChild "n+2"
            [ before
                [ property "content" (qt "")
                , property "background-image" svgIcon
                , backgroundSize contain
                , backgroundPosition center
                , backgroundRepeat noRepeat
                , width (em 0.8)
                , height (em 0.8)

                -- .ui.breadcrumb .divider
                , opacity (num 0.7)
                , margin3 zero (rem 0.21428571) zero

                -- Override
                , margin3 zero (rem 0.71428571) zero
                ]
            ]
        ]



-- Variations


sizedBreadCrumb : Size -> { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
sizedBreadCrumb size { divider, theme } children =
    breadcrumbWithProps { divider = divider, size = Just (sizeSelector size), theme = theme } children


miniBreadCrumb : { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
miniBreadCrumb =
    sizedBreadCrumb Mini


tinyBreadCrumb : { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
tinyBreadCrumb =
    sizedBreadCrumb Tiny


smallBreadCrumb : { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
smallBreadCrumb =
    sizedBreadCrumb Small


mediumBreadCrumb : { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
mediumBreadCrumb =
    sizedBreadCrumb Medium


largeBreadCrumb : { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
largeBreadCrumb =
    sizedBreadCrumb Large


bigBreadCrumb : { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
bigBreadCrumb =
    sizedBreadCrumb Big


hugeBreadCrumb : { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
hugeBreadCrumb =
    sizedBreadCrumb Huge


massiveBreadCrumb : { divider : Divider, theme : Theme } -> List BreadcrumbItem -> Html msg
massiveBreadCrumb =
    sizedBreadCrumb Massive


sizeSelector : Size -> Css.Rem
sizeSelector size =
    case size of
        Massive ->
            -- .ui.massive.breadcrumb
            rem 1.71428571

        Huge ->
            -- .ui.huge.breadcrumb
            rem 1.42857143

        Big ->
            -- .ui.big.breadcrumb
            rem 1.28571429

        Large ->
            -- .ui.large.breadcrumb
            rem 1.14285714

        Medium ->
            -- .ui.breadcrumb
            rem 1

        Small ->
            -- .ui.small.breadcrumb
            rem 0.92857143

        Tiny ->
            -- .ui.tiny.breadcrumb
            rem 0.85714286

        Mini ->
            -- .ui.mini.breadcrumb
            rem 0.78571429



-- HELPER


type Divider
    = Slash
    | RightChevron


dividerFromString : String -> Maybe Divider
dividerFromString string =
    case string of
        "Slash" ->
            Just Slash

        "RightChevron" ->
            Just RightChevron

        _ ->
            Nothing


dividerToString : Divider -> String
dividerToString divider =
    case divider of
        Slash ->
            "Slash"

        RightChevron ->
            "RightChevron"
