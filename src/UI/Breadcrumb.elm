module UI.Breadcrumb exposing (activeSection, breadcrumb, divider, section)

import Css exposing (..)
import Css.Color exposing (..)
import Html.Styled as Html exposing (Attribute, Html)


breadcrumb : List (Html msg) -> Html msg
breadcrumb =
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
        ]
        []


divider : List (Attribute msg) -> List (Html msg) -> Html msg
divider =
    Html.styled Html.div
        [ -- .ui.breadcrumb .divider
          display inlineBlock
        , opacity (num 0.7)
        , margin3 zero (rem 0.21428571) zero
        , fontSize (em 0.92857143)
        , color (rgba 0 0 0 0.4)
        , verticalAlign baseline

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
