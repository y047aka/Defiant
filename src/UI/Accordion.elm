module UI.Accordion exposing (accordion)

import Css exposing (..)
import Css.Global exposing (children)
import Css.Typography exposing (fomanticFont)
import Html.Styled as Html exposing (Attribute, Html)
import UI.Internal exposing (styledBlock)


type alias AccordionItem msg =
    { title : List (Html msg)
    , content : List (Html msg)
    }


basis : List (Attribute msg) -> List (Html msg) -> Html msg
basis =
    styledBlock
        { tag = Html.div
        , position = Nothing
        , margin = Nothing
        , padding = Nothing
        , borderRadius = Nothing
        , palette =
            { background = Nothing
            , color = Nothing
            , border = Nothing
            }
        , boxShadow = Nothing
        }
        [ -- .ui.accordion,
          -- .ui.accordion .accordion
          maxWidth (pct 100)
        ]


accordion : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion options attributes items =
    basis attributes <|
        List.map (accordionItem options []) items


itemBasis : List (Attribute msg) -> List (Html msg) -> Html msg
itemBasis =
    styledBlock
        { tag = Html.details
        , position = Nothing
        , margin = Nothing
        , padding = Nothing
        , borderRadius = Nothing
        , palette =
            { background = Nothing
            , color = Nothing
            , border = Nothing
            }
        , boxShadow = Nothing
        }
        [ -- .ui.accordion:not(.styled) .title ~ .content:not(.ui):last-child
          lastChild
            [ children
                [ Css.Global.div
                    [ paddingBottom zero ]
                ]
            ]
        ]


accordionItem : { inverted : Bool } -> List (Attribute msg) -> AccordionItem msg -> Html msg
accordionItem options attributes children =
    itemBasis attributes
        [ title options [] children.title
        , content [] children.content
        ]


title : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
title { inverted } =
    Html.styled Html.summary
        [ -- .ui.accordion .title,
          -- .ui.accordion .accordion .title
          cursor pointer

        -- .ui.accordion .title:not(.ui)
        , padding2 (em 0.5) zero
        , fontFamilies fomanticFont
        , fontSize (em 1)

        -- Inverted
        , if inverted then
            -- .ui.inverted.accordion .title:not(.ui)
            color (rgba 255 255 255 0.9)

          else
            color (rgba 0 0 0 0.87)
        ]


content : List (Attribute msg) -> List (Html msg) -> Html msg
content =
    Html.styled Html.div
        [ -- .ui.accordion:not(.styled) .title ~ .content:not(.ui)
          -- .ui.accordion:not(.styled) .accordion .title ~ .content:not(.ui)
          property "margin" "''"
        , padding3 (em 0.5) zero (em 1)
        ]
