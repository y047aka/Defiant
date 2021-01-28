module UI.Breadcrumb exposing (activeSection, breadcrumb, divider, section)

import Css exposing (..)
import Css.Color exposing (..)
import Css.Extra exposing (when)
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
        ]


sectionBasis : { active : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
sectionBasis { active } =
    Html.styled Html.div <|
        [ -- .ui.breadcrumb .section
          display inlineBlock
        , margin zero
        , padding zero

        -- .ui.breadcrumb .active.section
        , when active <| fontWeight bold
        ]


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    sectionBasis { active = False }


activeSection : List (Attribute msg) -> List (Html msg) -> Html msg
activeSection =
    sectionBasis { active = True }
