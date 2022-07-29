module UI.Accordion exposing
    ( accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl
    , styled_Checkbox, styled_Radio, styled_SummaryDetails, styled_TargetUrl
    )

{-|

@docs accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl
@docs styled_Checkbox, styled_Radio, styled_SummaryDetails, styled_TargetUrl

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (adjacentSiblings, children, generalSiblings)
import Css.Typography exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css, for, href, id, name, type_, value)
import UI.Icon as Icon


type ToggleMethod
    = Checkbox
    | Radio
    | TargetUrl
    | SummaryDetails


type alias AccordionItem msg =
    { id : String
    , title : List (Html msg)
    , content : List (Html msg)
    }


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.div
        [ -- .ui.accordion,
          -- .ui.accordion .accordion
          maxWidth (pct 100)

        -- AdditionalStyles
        , batch additionalStyles
        ]


accordion : { toggleMethod : ToggleMethod, inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion { toggleMethod, inverted } attributes items =
    let
        itemOptions =
            { toggleMethod = toggleMethod
            , inverted = inverted
            , wrapperStyles =
                [ -- .ui.accordion:not(.styled) .title ~ .content:not(.ui):last-child
                  lastChild
                    [ children
                        [ Css.Global.div
                            [ paddingBottom zero ]
                        ]
                    ]
                ]
            , labelStyles = []
            , contentStyles = []
            }
    in
    basis [] attributes <|
        List.map (accordionItem itemOptions []) items


accordion_Checkbox : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_Checkbox { inverted } =
    accordion { toggleMethod = Checkbox, inverted = inverted }


accordion_Radio : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_Radio { inverted } =
    accordion { toggleMethod = Radio, inverted = inverted }


accordion_TargetUrl : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_TargetUrl { inverted } =
    accordion { toggleMethod = TargetUrl, inverted = inverted }


accordion_SummaryDetails : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_SummaryDetails { inverted } =
    accordion { toggleMethod = SummaryDetails, inverted = inverted }


styled : { toggleMethod : ToggleMethod, inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
styled { toggleMethod, inverted } attributes items =
    let
        itemOptions =
            { toggleMethod = toggleMethod
            , inverted = inverted
            , wrapperStyles =
                [ -- .ui.styled.accordion .title,
                  -- .ui.styled.accordion .accordion .title
                  borderTop3 (px 1) solid (rgba 34 36 38 0.15)

                -- .ui.styled.accordion > .title:first-child,
                -- .ui.styled.accordion .accordion .title:first-child
                , firstChild
                    [ property "border-top" "none"
                    ]
                ]
            , labelStyles =
                [ -- .ui.styled.accordion .title,
                  -- .ui.styled.accordion .accordion .title
                  margin zero
                , padding2 (em 0.75) (em 1)
                , color (rgba 0 0 0 0.4)
                , fontWeight bold
                , property "-webkit-transition" "background 0.1s ease, color 0.1s ease"
                , property "transition" "background 0.1s ease, color 0.1s ease"

                -- Hover
                , hover
                    [ -- .ui.styled.accordion .title:hover,
                      -- .ui.styled.accordion .active.title,
                      -- .ui.styled.accordion .accordion .title:hover,
                      -- .ui.styled.accordion .accordion .active.title
                      property "background" "transparent"
                    , color (rgba 0 0 0 0.87)
                    ]
                ]
            , contentStyles =
                [ -- .ui.styled.accordion .content,
                  -- .ui.styled.accordion .accordion .content
                  margin zero
                , padding3 (em 0.5) (em 1) (em 1.5)
                ]
            }
    in
    basis
        [ -- .ui.styled.accordion,
          -- .ui.styled.accordion .accordion
          borderRadius (rem 0.28571429)
        , property "background" "#FFFFFF"
        , prefixed [] "box-shadow" "0 1px 2px 0 rgba(34, 36, 38, 0.15), 0 0 0 1px rgba(34, 36, 38, 0.15)"
        ]
        attributes
        (List.map (accordionItem itemOptions []) items)


styled_Checkbox : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
styled_Checkbox { inverted } =
    styled { toggleMethod = Checkbox, inverted = inverted }


styled_Radio : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
styled_Radio { inverted } =
    styled { toggleMethod = Radio, inverted = inverted }


styled_TargetUrl : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
styled_TargetUrl { inverted } =
    styled { toggleMethod = TargetUrl, inverted = inverted }


styled_SummaryDetails : { inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
styled_SummaryDetails { inverted } =
    styled { toggleMethod = SummaryDetails, inverted = inverted }


itemBasis :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
itemBasis tag additionalStyles =
    Html.styled tag
        [ -- AdditionalStyles
          batch additionalStyles
        ]


accordionItem :
    { toggleMethod : ToggleMethod
    , inverted : Bool
    , wrapperStyles : List Style
    , labelStyles : List Style
    , contentStyles : List Style
    }
    -> List (Attribute msg)
    -> AccordionItem msg
    -> Html msg
accordionItem { toggleMethod, inverted, wrapperStyles, labelStyles, contentStyles } attributes item =
    let
        inputStyles =
            [ display none
            , generalSiblings
                [ Css.Global.div [ display none ] ]
            , checked
                [ adjacentSiblings
                    [ Css.Global.label
                        [ children
                            [ Css.Global.i [ iconTransitionStyle ] ]
                        ]
                    ]
                , generalSiblings
                    [ Css.Global.div [ display block ] ]
                ]
            ]

        iconTransitionStyle =
            -- .ui.accordion .active.title .dropdown.icon
            -- .ui.accordion .accordion .active.title .dropdown.icon
            prefixed [] "transform" "rotate(90deg)"

        iconAndTitle =
            dropdownIcon :: item.title
    in
    case toggleMethod of
        Checkbox ->
            let
                suffixedId =
                    item.id ++ "_accordion-checkbox"
            in
            itemBasis Html.div
                wrapperStyles
                attributes
                [ Html.input [ id suffixedId, type_ "checkbox", name "accordion-checkbox", css inputStyles ] []
                , title { tag = Html.label, inverted = inverted } labelStyles [ for suffixedId ] iconAndTitle
                , content contentStyles [] item.content
                ]

        Radio ->
            let
                suffixedId =
                    item.id ++ "_accordion-radio"
            in
            itemBasis Html.div
                wrapperStyles
                attributes
                [ Html.input [ id suffixedId, type_ "radio", name "accordion-radio", value item.id, css inputStyles ] []
                , title { tag = Html.label, inverted = inverted } labelStyles [ for suffixedId ] iconAndTitle
                , content contentStyles [] item.content
                ]

        TargetUrl ->
            itemBasis Html.div
                [ children
                    [ Css.Global.div [ display none ] ]
                , target
                    [ children
                        [ Css.Global.div [ display block ]
                        , Css.Global.a
                            [ children
                                [ Css.Global.i [ iconTransitionStyle ] ]
                            ]
                        ]
                    ]
                , batch wrapperStyles
                ]
                (id item.id :: attributes)
                [ title { tag = Html.a, inverted = inverted } labelStyles [ href ("#" ++ item.id) ] iconAndTitle
                , content contentStyles [] item.content
                ]

        SummaryDetails ->
            itemBasis Html.details
                wrapperStyles
                attributes
                [ title { tag = Html.summary, inverted = inverted } labelStyles [] item.title
                , content contentStyles [] item.content
                ]


title :
    { tag : List (Attribute msg) -> List (Html msg) -> Html msg
    , inverted : Bool
    }
    -> List Style
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
title { tag, inverted } additionalStyles =
    Html.styled tag
        [ -- .ui.accordion .title,
          -- .ui.accordion .accordion .title
          cursor pointer

        -- .ui.accordion .title:not(.ui)
        , padding2 (em 0.5) zero
        , fontFamilies fomanticFontFamilies
        , fontSize (em 1)

        -- Inverted
        , if inverted then
            -- .ui.inverted.accordion .title:not(.ui)
            color (rgba 255 255 255 0.9)

          else
            color (rgba 0 0 0 0.87)

        -- Override
        , display block

        -- AdditionalStyles
        , batch additionalStyles
        ]


content : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
content additionalStyles =
    Html.styled Html.div
        [ -- .ui.accordion:not(.styled) .title ~ .content:not(.ui)
          -- .ui.accordion:not(.styled) .accordion .title ~ .content:not(.ui)
          property "margin" "''"
        , padding3 (em 0.5) zero (em 1)

        -- AdditionalStyles
        , batch additionalStyles
        ]


dropdownIcon : Html msg
dropdownIcon =
    Icon.icon
        [ css
            [ -- .ui.accordion .title .dropdown.icon
              -- .ui.accordion .accordion .title .dropdown.icon
              property "float" "none"
            , width (em 1.25)
            , padding zero
            , fontSize (em 1)
            , property "-webkit-transition" "opacity 0.1s ease, -webkit-transform 0.1s ease"
            , property "transition" "opacity 0.1s ease, -webkit-transform 0.1s ease"
            , property "transition" "transform 0.1s ease, opacity 0.1s ease"
            , property "transition" "transform 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease"
            , verticalAlign baseline
            , prefixed [] "transform" "none"
            ]
        ]
        "fas fa-caret-right"
