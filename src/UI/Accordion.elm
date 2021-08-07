module UI.Accordion exposing (accordion_Checkbox, accordion_Radio, accordion_SummaryDetails)

import Css exposing (..)
import Css.Global exposing (children, generalSiblings)
import Css.Typography exposing (fomanticFont)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css, for, id, name, type_, value)
import UI.Internal exposing (styledBlock)


type ToggleMethod
    = Checkbox
    | Radio
    | SummaryDetails


type alias AccordionItem msg =
    { id : String
    , title : List (Html msg)
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


accordion : { toggleMethod : ToggleMethod, inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion options attributes items =
    basis attributes <|
        List.map (accordionItem options []) items


accordion_Checkbox : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_Checkbox { inverted } =
    accordion { toggleMethod = Checkbox, inverted = inverted }


accordion_Radio : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_Radio { inverted } =
    accordion { toggleMethod = Radio, inverted = inverted }


accordion_SummaryDetails : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_SummaryDetails { inverted } =
    accordion { toggleMethod = SummaryDetails, inverted = inverted }


itemBasis :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
itemBasis tag =
    styledBlock
        { tag = tag
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


accordionItem : { toggleMethod : ToggleMethod, inverted : Bool } -> List (Attribute msg) -> AccordionItem msg -> Html msg
accordionItem { toggleMethod, inverted } attributes item =
    let
        inputStyles =
            [ display none
            , generalSiblings
                [ Css.Global.div [ display none ] ]
            , checked
                [ generalSiblings
                    [ Css.Global.div [ display block ] ]
                ]
            ]
    in
    case toggleMethod of
        Checkbox ->
            let
                prefixedId =
                    item.id ++ "_accordion-checkbox"
            in
            itemBasis Html.div
                attributes
                [ Html.input [ id prefixedId, type_ "checkbox", name "accordion-checkbox", css inputStyles ] []
                , title { tag = Html.label, inverted = inverted } [ for prefixedId ] item.title
                , content [] item.content
                ]

        Radio ->
            let
                prefixedId =
                    item.id ++ "_accordion-radio"
            in
            itemBasis Html.div
                attributes
                [ Html.input [ id prefixedId, type_ "radio", name "accordion-radio", value item.id, css inputStyles ] []
                , title { tag = Html.label, inverted = inverted } [ for prefixedId ] item.title
                , content [] item.content
                ]

        SummaryDetails ->
            itemBasis Html.details
                attributes
                [ title { tag = Html.summary, inverted = inverted } [] item.title
                , content [] item.content
                ]


title :
    { tag : List (Attribute msg) -> List (Html msg) -> Html msg
    , inverted : Bool
    }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
title { tag, inverted } =
    Html.styled tag
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
