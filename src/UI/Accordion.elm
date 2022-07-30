module UI.Accordion exposing
    ( ToggleMethod(..)
    , accordionUnstyled
    , accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl
    )

{-|

@docs ToggleMethod
@docs accordionUnstyled
@docs accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (adjacentSiblings, children, generalSiblings)
import Css.Typography exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes exposing (css, for, href, name, type_, value)
import UI.Icon as Icon


type ToggleMethod
    = Checkbox
    | Radio
    | TargetUrl
    | SummaryDetails


type alias AccordionItem msg =
    { id : String
    , title : Html msg
    , content : List (Html msg)
    }

accordionBasis :
    { toggleMethod : ToggleMethod
    , wrapper : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
    , label : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
    }
    -> List Style
    -> List (Attribute msg)
    -> List (AccordionItem msg)
    -> Html msg
accordionBasis itemProps styles attributes items =
    Html.div (css styles :: attributes) <|
        List.map (\item -> accordionItem itemProps [] item) items


accordionItem :
    { toggleMethod : ToggleMethod
    , wrapper : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
    , label : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
    }
    -> List (Attribute msg)
    -> AccordionItem msg
    -> Html msg
accordionItem { toggleMethod, wrapper, label } attributes { id, title, content } =
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

        targetStyles =
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
            ]

        iconTransitionStyle =
            -- .ui.accordion .active.title .dropdown.icon
            -- .ui.accordion .accordion .active.title .dropdown.icon
            prefixed [] "transform" "rotate(90deg)"

        iconAndTitle =
            [ dropdownIcon, title ]
    in
    case toggleMethod of
        Checkbox ->
            let
                suffixedId =
                    id ++ "_accordion-checkbox"
            in
            wrapper Html.div attributes <|
                [ Html.input [ Attributes.id suffixedId, type_ "checkbox", name "accordion-checkbox", css inputStyles ] []
                , label Html.label [ for suffixedId ] iconAndTitle
                ]
                    ++ content

        Radio ->
            let
                suffixedId =
                    id ++ "_accordion-radio"
            in
            wrapper Html.div attributes <|
                [ Html.input [ Attributes.id suffixedId, type_ "radio", name "accordion-radio", value id, css inputStyles ] []
                , label Html.label [ for suffixedId ] iconAndTitle
                ]
                    ++ content

        TargetUrl ->
            Html.styled (wrapper Html.div) targetStyles (Attributes.id id :: attributes) <|
                label Html.a [ href ("#" ++ id) ] iconAndTitle
                    :: content

        SummaryDetails ->
            wrapper Html.details attributes <|
                label Html.summary [] [ title ]
                    :: content


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




accordionUnstyled : { toggleMethod : ToggleMethod } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordionUnstyled { toggleMethod } attributes items =
    let
        itemProps =
            { toggleMethod = toggleMethod, wrapper = \tag -> tag, label = \tag -> tag }
    in
    accordionBasis itemProps [] attributes items


accordion : { toggleMethod : ToggleMethod, inverted : Bool } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion { toggleMethod, inverted } attributes items =
    let
        itemProps =
            { toggleMethod = toggleMethod, wrapper = wrapper, label = label }

        wrapper tag =
            Html.styled tag
                [ -- .ui.styled.accordion .title,
                  -- .ui.styled.accordion .accordion .title
                  borderTop3 (px 1) solid (rgba 34 36 38 0.15)

                -- .ui.styled.accordion > .title:first-child,
                -- .ui.styled.accordion .accordion .title:first-child
                , firstChild
                    [ property "border-top" "none"
                    ]
                ]

        label tag =
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

                -- .ui.styled.accordion .title,
                -- .ui.styled.accordion .accordion .title
                , margin zero
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
    in
    accordionBasis itemProps
        [ -- .ui.accordion,
          -- .ui.accordion .accordion
          maxWidth (pct 100)

        -- .ui.styled.accordion,
        -- .ui.styled.accordion .accordion
        , borderRadius (rem 0.28571429)
        , property "background" "#FFFFFF"
        , prefixed [] "box-shadow" "0 1px 2px 0 rgba(34, 36, 38, 0.15), 0 0 0 1px rgba(34, 36, 38, 0.15)"
        ]
        attributes
        (List.map
            (\{ id, title, content } ->
                { id = id
                , title = title
                , content =
                    [ Html.div
                        [ css
                            [ -- .ui.styled.accordion .content,
                              -- .ui.styled.accordion .accordion .content
                              margin zero
                            , padding3 (em 0.5) (em 1) (em 1.5)
                            ]
                        ]
                        content
                    ]
                }
            )
            items
        )


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
