module UI.Example exposing
    ( toc, article
    , example, exampleContainer
    , wireframeParagraph, wireframeShortParagraph, wireframeMediaParagraph
    )

{-|

@docs toc, article
@docs example, exampleContainer
@docs wireframeParagraph, wireframeShortParagraph, wireframeMediaParagraph

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children)
import Css.Media as Media exposing (only, screen, withMedia)
import Html.Styled as Html exposing (Attribute, Html, p, text)
import Html.Styled.Attributes exposing (src)
import UI.Header as Header


article : List (Attribute msg) -> List (Html msg) -> Html msg
article =
    Html.styled Html.div
        [ -- #example .article
          prefixed [] "flex" "1 1 auto"
        , minWidth (px 0)
        , marginLeft (px 250)
        ]


toc : List (Attribute msg) -> List (Html msg) -> Html msg
toc =
    Html.styled Html.div
        [ -- #example .full.height > .toc
          position fixed
        , zIndex (int 1)
        , backgroundColor (hex "#1b1c1d")
        , width (px 250)
        , prefixed [] "flex" "0 0 auto"

        -- #example .full.height > .toc
        , withMedia [ only screen [ Media.maxWidth (px 1272) ] ]
            [ width (px 200) ]

        -- override
        , minHeight (pct 100)
        , children
            [ Css.Global.div
                [ width inherit ]
            ]
        ]


example : { title : String, description : String } -> List (Html msg) -> Html msg
example options children =
    let
        title =
            if options.title == "" then
                text ""

            else
                Header.header { inverted = False } [] [ text options.title ]

        description =
            if options.description == "" then
                text ""

            else
                p [] [ text options.description ]
    in
    Html.styled Html.div
        [ -- #example .example
          margin2 (em 2) zero
        , padding2 (em 2) zero
        , position relative
        , property "-webkit-tap-highlight-color" "transparent"

        -- Override
        , whiteSpace preWrap
        ]
        []
        (title :: description :: children)


exampleContainer : List (Attribute msg) -> List (Html msg) -> Html msg
exampleContainer =
    Html.styled Html.div
        [ -- #example .fixed.menu > .container
          -- #example .main.container
          -- #example .masthead > .container
          -- #example .footer > .container
          position relative

        -- #example .main.container
        , padding3 (em 2) zero (em 7)

        -- #example .masthead > .container
        -- #example .main.container
        -- #example .fixed.menu > .container
        , marginLeft (em 3) |> important
        , marginRight (em 3) |> important
        , width auto |> important
        , maxWidth (px 960) |> important

        -- #example .main.container
        , marginRight (px 387) |> important

        -- #example .main.container
        , withMedia [ only screen [ Media.maxWidth (px 1272) ] ]
            [ marginRight (px 318) |> important ]

        -- #example .masthead > .container
        -- #example .main.container
        -- #example .fixed.menu > .container
        , withMedia [ only screen [ Media.maxWidth (px 1144) ] ]
            [ marginLeft (em 2) |> important ]

        -- #example .masthead > .container,
        -- #example .main.container,
        -- #example .fixed.menu > .container {
        , withMedia [ only screen [ Media.maxWidth (px 992) ] ]
            [ marginLeft (em 1) |> important
            , marginRight (em 1) |> important
            , maxWidth none |> important
            ]

        -- override
        , nthChild "n+2"
            [ borderTop3 (px 1) solid (rgba 34 36 38 0.15) ]
        ]


imageBasis : List (Attribute msg) -> List (Html msg) -> Html msg
imageBasis =
    Html.styled Html.img
        [ -- .ui.image
          position relative
        , display inlineBlock
        , verticalAlign middle
        , maxWidth (pct 100)
        , backgroundColor Css.transparent

        -- img.ui.image
        , display block

        -- #example .example .wireframe.image
        , opacity (num 0.5)

        -- #example .example :not(.images) > .wireframe.image
        , marginTop (rem 1)
        , marginBottom (rem 1)

        -- #example .example :not(.images) > .wireframe.image:first-child
        , firstChild
            [ marginTop (em 0) ]

        -- #example .example :not(.images) > .wireframe.image:last-child
        , lastChild
            [ marginBottom (em 0) ]
        ]


wireframeParagraph : Html msg
wireframeParagraph =
    imageBasis [ src "/static/images/wireframe/paragraph.png" ] []


wireframeShortParagraph : Html msg
wireframeShortParagraph =
    imageBasis [ src "/static/images/wireframe/short-paragraph.png" ] []


wireframeMediaParagraph : Html msg
wireframeMediaParagraph =
    imageBasis [ src "/static/images/wireframe/media-paragraph.png" ] []
