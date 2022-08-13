module UI.Step exposing
    ( State(..)
    , steps
    , step, activeStep, completedStep, disabledStep
    , stateFromString, stateToString
    )

{-|

@docs State
@docs steps
@docs step, activeStep, completedStep, disabledStep

@docs stateFromString, stateToString

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Palette as Palette exposing (paletteWith, setBackground, setBorder, setColor)
import Css.Typography as Typography exposing (typography)
import Html.Styled as Html exposing (Attribute, Html, text)
import Html.Styled.Attributes exposing (css)
import UI.Icon as Icon


type State
    = Default
    | Active
    | Completed
    | Disabled


steps : List (Attribute msg) -> List (Html msg) -> Html msg
steps =
    Html.styled Html.div
        [ -- .ui.steps
          prefixed [] "display" "inline-flex"
        , property "-webkit-box-orient" "horizontal"
        , property "-webkit-box-direction" "normal"
        , prefixed [] "flex-direction" "row"
        , prefixed [] "align-items" "stretch"
        , margin2 (em 1) zero
        , property "background" "''"
        , prefixed [] "box-shadow" "none"
        , lineHeight (em 1.14285714)
        , borderRadius (rem 0.28571429)
        , paletteWith { border = border3 (px 1) solid }
            (Palette.init |> setBorder (rgba 34 36 38 0.15))

        -- .ui.steps:not(.unstackable)
        , prefixed [] "flex-wrap" "wrap"

        -- .ui.steps:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.steps:last-child
        , lastChild
            [ marginBottom zero ]
        ]


stepBasis : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
stepBasis { state } =
    Html.styled Html.div
        [ -- .ui.steps .step
          position relative
        , prefixed [] "display" "flex"
        , prefixed [] "flex" "1 0 auto"
        , prefixed [] "flex-wrap" "wrap"
        , property "-webkit-box-orient" "horizontal"
        , property "-webkit-box-direction" "normal"
        , prefixed [] "flex-direction" "row"
        , verticalAlign middle
        , prefixed [] "align-items" "center"
        , prefixed [] "justify-content" "center"
        , margin2 zero zero
        , padding2 (em 1.14285714) (em 2)
        , prefixed [] "box-shadow" "none"
        , borderRadius zero
        , property "border" "none"
        , paletteWith { border = borderRight3 (px 1) solid }
            (Palette.init
                |> setBackground (hex "#FFFFFF")
                |> setColor (rgba 0 0 0 0.87)
                |> setBorder (rgba 34 36 38 0.15)
            )
        , property "-webkit-transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"

        -- .ui.steps .step:after
        , after
            [ display none
            , position absolute
            , zIndex (int 2)
            , property "content" "''"
            , top (pct 50)
            , right zero
            , width (em 1.14285714)
            , height (em 1.14285714)
            , paletteWith
                { border =
                    \color ->
                        batch
                            [ borderStyle solid
                            , borderWidth4 zero (px 1) (px 1) zero
                            , borderColor color
                            ]
                }
                (Palette.init
                    |> setBackground (hex "#FFFFFF")
                    |> setBorder (rgba 34 36 38 0.15)
                )
            , property "-webkit-transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "-webkit-transform" "translateY(-50%) translateX(50%) rotate(-45deg)"
            , property "transform" "translateY(-50%) translateX(50%) rotate(-45deg)"
            ]

        -- .ui.steps .step:first-child
        , firstChild
            [ paddingLeft (em 2)
            , borderRadius4 (rem 0.28571429) zero zero (rem 0.28571429)
            ]

        -- .ui.steps .step:last-child
        , lastChild
            [ borderRadius4 zero (rem 0.28571429) (rem 0.28571429) zero
            , property "border-right" "none"
            , marginRight zero
            ]

        -- .ui.steps .step:only-child
        , onlyChild
            [ borderRadius (rem 0.28571429) ]

        -- .ui.steps .step:after
        , after
            [ display block ]

        -- .ui.steps .step:last-child:after
        , lastChild
            [ after
                [ display none ]
            ]

        -- State
        , batch <|
            case state of
                Active ->
                    [ -- .ui.steps .step.active
                      cursor auto
                    , property "background" "#F3F4F5"

                    -- .ui.steps .step.active:after
                    , after
                        [ property "background" "#F3F4F5" ]
                    ]

                Disabled ->
                    [ -- .ui.steps .disabled.step
                      cursor auto
                    , property "background" "#FFFFFF"
                    , pointerEvents none

                    -- .ui.steps .disabled.step
                    -- .ui.steps .disabled.step .title
                    -- .ui.steps .disabled.step .description
                    , color (rgba 40 40 40 0.3)

                    -- .ui.steps .disabled.step:after
                    , property "background" "#FFFFFF"
                    ]

                _ ->
                    []
        ]


step_ : { state : State } -> List (Attribute msg) -> { icon : String, title : String, description : String } -> Html msg
step_ options attributes content_ =
    stepBasis options
        attributes
        [ case ( content_.icon, options.state ) of
            ( "", _ ) ->
                text ""

            ( _, Completed ) ->
                icon options "fas fa-check"

            ( icon_, _ ) ->
                icon options icon_
        , content options [] content_
        ]


step : List (Attribute msg) -> { icon : String, title : String, description : String } -> Html msg
step =
    step_ { state = Default }


activeStep : List (Attribute msg) -> { icon : String, title : String, description : String } -> Html msg
activeStep =
    step_ { state = Active }


completedStep : List (Attribute msg) -> { icon : String, title : String, description : String } -> Html msg
completedStep =
    step_ { state = Completed }


disabledStep : List (Attribute msg) -> { icon : String, title : String, description : String } -> Html msg
disabledStep =
    step_ { state = Disabled }


icon : { state : State } -> String -> Html msg
icon { state } =
    Icon.icon
        [ css
            [ -- .ui.steps .step > i.icon
              lineHeight (int 1)
            , fontSize (em 2.5)
            , margin4 zero (rem 1) zero zero

            -- .ui.steps .step > i.icon
            -- .ui.steps .step > i.icon ~ .content
            , display block
            , prefixed [] "flex" "0 1 auto"
            , prefixed [] "align-self" "middle"

            -- .ui.steps:not(.vertical) .step > i.icon
            , width auto

            -- State
            , batch <|
                case state of
                    Completed ->
                        [ -- .ui.steps .step.completed > i.icon:before
                          -- .ui.ordered.steps .step.completed:before
                          color (hex "#21BA45")
                        ]

                    _ ->
                        []
            ]
        ]


content : { state : State } -> List (Attribute msg) -> { a | title : String, description : String } -> Html msg
content options attributes content_ =
    Html.styled Html.div
        []
        attributes
        [ case content_.title of
            "" ->
                text ""

            title_ ->
                title options [] [ text title_ ]
        , case content_.description of
            "" ->
                text ""

            description_ ->
                description options [] [ text description_ ]
        ]


title : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
title { state } =
    Html.styled Html.div
        [ -- .ui.steps .step .title
          typography Typography.bold
        , fontSize (em 1.14285714)

        -- .ui.steps .step > .title
        , width (pct 100)

        -- State
        , batch <|
            case state of
                Active ->
                    [ -- .ui.steps .step.active .title
                      color (hex "#4183C4")
                    ]

                Disabled ->
                    [ -- .ui.steps .disabled.step
                      -- .ui.steps .disabled.step .title
                      -- .ui.steps .disabled.step .description
                      color (rgba 40 40 40 0.3)
                    ]

                _ ->
                    []
        ]


description : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
description { state } =
    Html.styled Html.div
        [ -- .ui.steps .step .description
          fontWeight normal
        , fontSize (em 0.92857143)
        , color (rgba 0 0 0 0.87)

        -- .ui.steps .step > .description
        , width (pct 100)

        -- .ui.steps .step .title ~ .description
        , marginTop (em 0.25)

        -- State
        , batch <|
            case state of
                Disabled ->
                    [ -- .ui.steps .disabled.step
                      -- .ui.steps .disabled.step .title
                      -- .ui.steps .disabled.step .description
                      color (rgba 40 40 40 0.3)
                    ]

                _ ->
                    []
        ]



-- HELPER


stateFromString : String -> Maybe State
stateFromString string =
    case string of
        "Default" ->
            Just Default

        "Active" ->
            Just Active

        "Completed" ->
            Just Completed

        "Disabled" ->
            Just Disabled

        _ ->
            Nothing


stateToString : State -> String
stateToString state =
    case state of
        Default ->
            "Default"

        Active ->
            "Active"

        Completed ->
            "Completed"

        Disabled ->
            "Disabled"
