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
import Css.Palette as Palette exposing (darkPalette, palette, setColor)
import Css.Typography exposing (fomanticFontFamilies)
import Data.Theme exposing (Theme)
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


accordion : { toggleMethod : ToggleMethod, theme : Theme } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion { toggleMethod, theme } attributes items =
    let
        itemProps =
            { toggleMethod = toggleMethod, wrapper = wrapper, label = label }

        wrapper tag =
            Html.styled tag
                [ nthChild "n+2"
                    [ borderTop3 (px 1) solid (rgba 34 36 38 0.15) ]
                ]

        label tag =
            let
                defaultPalette =
                    Palette.init |> setColor (rgba 0 0 0 0.4)

                darkPalette_ =
                    -- .ui.inverted.accordion .title:not(.ui)
                    Palette.init |> setColor (rgba 255 255 255 0.9)
            in
            Html.styled tag
                [ cursor pointer
                , if toggleMethod == SummaryDetails then
                    display listItem

                  else
                    display block
                , margin zero
                , padding2 (em 0.75) (em 1)
                , fontFamilies fomanticFontFamilies
                , fontSize (em 1)
                , fontWeight bold

                -- Palette
                , palette defaultPalette
                , darkPalette theme darkPalette_
                , property "-webkit-transition" "background 0.1s ease, color 0.1s ease"
                , property "transition" "background 0.1s ease, color 0.1s ease"
                , hover
                    [ backgroundColor transparent
                    , color (rgba 0 0 0 0.87)
                    ]
                ]
    in
    accordionBasis itemProps
        [ borderRadius (rem 0.28571429)
        , backgroundColor (hex "#FFFFFF")
        , border3 (px 1) solid (rgba 34 36 38 0.15)
        ]
        attributes
        (List.map
            (\{ id, title, content } ->
                { id = id
                , title = title
                , content =
                    [ Html.div
                        [ css
                            [ margin zero
                            , padding3 (em 0.5) (em 1) (em 1.5)
                            ]
                        ]
                        content
                    ]
                }
            )
            items
        )


accordion_Checkbox : { theme : Theme } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_Checkbox { theme } =
    accordion { toggleMethod = Checkbox, theme = theme }


accordion_Radio : { theme : Theme } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_Radio { theme } =
    accordion { toggleMethod = Radio, theme = theme }


accordion_TargetUrl : { theme : Theme } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_TargetUrl { theme } =
    accordion { toggleMethod = TargetUrl, theme = theme }


accordion_SummaryDetails : { theme : Theme } -> List (Attribute msg) -> List (AccordionItem msg) -> Html msg
accordion_SummaryDetails { theme } =
    accordion { toggleMethod = SummaryDetails, theme = theme }
