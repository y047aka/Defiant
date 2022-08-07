module UI.CircleStep exposing
    ( steps
    , step, activeStep, completedStep, disabledStep
    )

{-|

@docs steps
@docs step, activeStep, completedStep, disabledStep

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Palette as Palette exposing (palette, paletteWith, setBackground, setBorder, setColor)
import Css.Typography exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html, text)
import Html.Styled.Attributes exposing (css)
import UI.Icon as Icon


type StepPosition
    = First
    | Middle
    | Last


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
        , padding3 (em 1.14285714) (em 2) (em 2.28571428)
        , palette
            (Palette.init
                |> setBackground (hex "#FFFFFF")
                |> setColor (rgba 0 0 0 0.87)
            )
        , prefixed [] "box-shadow" "none"
        , borderRadius zero
        , property "border" "none"
        , property "-webkit-transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease"
        , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"

        -- Before
        , before
            [ display block
            , position absolute
            , zIndex (int 2)
            , property "content" "''"
            , top (pct 100)
            , left zero
            , width (pct 100)
            , height (px 2)
            ]
        , batch
            [ before
                [ colorBarGradient Middle state ]
            , firstChild
                [ before
                    [ colorBarGradient First state ]
                ]
            , lastChild
                [ before
                    [ colorBarGradient Last state ]
                ]
            ]

        -- After
        , after
            [ display block
            , position absolute
            , zIndex (int 2)
            , property "content" "''"
            , top (pct 100)
            , left (pct 50)
            , width (em 1.14285714)
            , height (em 1.14285714)
            , borderRadius (pct 50)
            , paletteWith { border = border3 (px 2) solid, shadow = batch [] } <|
                let
                    default =
                        Palette.init
                            |> setBackground (hex "#FFFFFF")
                            |> setBorder (rgba 40 40 40 0.3)
                in
                case state of
                    Active ->
                        default |> setBorder (rgba 0 0 0 0.87)

                    Completed ->
                        default |> setBackground (rgba 0 0 0 0.87)

                    _ ->
                        default
            , property "-webkit-transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease"
            , property "transition" "background-color 0.1s ease, opacity 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "-webkit-transform" "translateY(-50%) translateX(-50%)"
            , property "transform" "translateY(-50%) translateX(-50%)"
            ]

        -- .ui.steps .step:first-child
        , firstChild
            [ paddingLeft (em 2) ]

        -- .ui.steps .step:last-child
        , lastChild
            [ marginRight zero ]

        -- .ui.steps .step:after
        , after
            [ display block ]

        -- State
        , batch <|
            case state of
                Active ->
                    [ -- .ui.steps .step.active
                      cursor auto
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


colorBarGradient : StepPosition -> State -> Style
colorBarGradient position state =
    let
        transparent_ =
            rgba 0 0 0 0

        completed =
            rgba 0 0 0 0.87

        default =
            rgba 40 40 40 0.3

        leftColor =
            case ( position, state ) of
                ( First, _ ) ->
                    transparent_

                ( _, Active ) ->
                    completed

                ( _, Completed ) ->
                    completed

                _ ->
                    default

        rightColor =
            case ( position, state ) of
                ( Last, _ ) ->
                    transparent_

                ( _, Completed ) ->
                    completed

                _ ->
                    default
    in
    backgroundImage <|
        linearGradient2 toRight (stop2 leftColor (pct 50)) (stop2 rightColor (pct 50)) [ stop rightColor ]


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
          fontFamilies fomanticFontFamilies
        , fontSize (em 1.14285714)
        , fontWeight bold

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
