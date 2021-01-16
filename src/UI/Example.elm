module UI.Example exposing
    ( toc, article
    , example
    , wireframeParagraph
    )

{-|

@docs toc, article
@docs example
@docs wireframeParagraph

-}

import Css exposing (..)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css, src)


article : List (Attribute msg) -> List (Html msg) -> Html msg
article =
    Html.styled Html.div
        [ -- #example .article
          Prefix.flex "1 1 auto"
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
        , Prefix.flex "0 0 auto"

        -- override
        , minHeight (pct 100)
        ]


example : List (Attribute msg) -> List (Html msg) -> Html msg
example =
    Html.styled Html.div
        [ -- .example
          margin2 (em 1) zero
        , padding2 (em 1) zero
        , position relative
        ]


wireframeParagraph : Html msg
wireframeParagraph =
    Html.img
        [ src "./static/images/wireframe/short-paragraph.png"
        , css
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

            -- #example.header .wireframe.image
            , maxWidth (px 500)
            ]
        ]
        []
