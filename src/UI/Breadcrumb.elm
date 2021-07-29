module UI.Breadcrumb exposing (BreadcrumbItem, breadcrumb)

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html, text)
import Html.Styled.Attributes exposing (href)
import Svg.Styled exposing (Attribute)


type alias BreadcrumbItem =
    { label : String
    , url : String
    }


basis : { inverted : Bool } -> List (Html msg) -> Html msg
basis { inverted } =
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

        -- Inverted
        , if inverted then
            -- .ui.inverted.breadcrumb
            color (hex "#DCDDDE")

          else
            batch []
        ]
        []


breadcrumb : { divider : Html msg, inverted : Bool } -> List BreadcrumbItem -> Html msg
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
            divider { inverted = options.inverted } [] [ options.divider ]
    in
    basis { inverted = options.inverted }
        (children
            |> List.indexedMap section_
            |> List.intersperse divider_
        )


divider : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
divider { inverted } =
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

        -- Inverted
        , if inverted then
            -- .ui.inverted.breadcrumb > .divider
            color (rgba 255 255 255 0.7)

          else
            color (rgba 0 0 0 0.4)

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
