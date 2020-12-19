module UI.Header exposing
    ( header, massiveHeader
    , hugeHeader, bigHeader, largeHeader, mediumHeader, smallHeader, tinyHeader, miniHeader
    , wireframeParagraph
    )

{-|

@docs header, massiveHeader
@docs hugeHeader, bigHeader, largeHeader, mediumHeader, smallHeader, tinyHeader, miniHeader

-}

import Css exposing (..)
import Css.Global exposing (adjacentSiblings, typeSelector)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css, src)
import UI.Modifier as Modifier


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.h1 <|
        [ -- .ui.header
          borderStyle none
        , margin3 (calc (rem 2) minus (em 0.1428571428571429)) zero (rem 1)
        , padding2 zero zero
        , fontFamilies Modifier.fontFamilies
        , fontWeight bold
        , lineHeight (em 1.28571429)
        , textTransform none
        , color (rgba 0 0 0 0.87)

        -- .ui.header:first-child
        , firstChild
            [ marginTop (em -0.14285714) ]

        --  .ui.header:last-child
        , lastChild
            [ marginBottom zero ]

        -- .ui.header + p
        , adjacentSiblings
            [ typeSelector "p"
                [ marginTop zero ]
            ]
        ]
            ++ additionalStyles


header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    basis []


miniHeader : List (Attribute msg) -> List (Html msg) -> Html msg
miniHeader =
    basis
        [ -- .ui.mini.header
          fontSize (em 0.85714286)
        ]


tinyHeader : List (Attribute msg) -> List (Html msg) -> Html msg
tinyHeader =
    basis
        [ -- .ui.tiny.header
          fontSize (em 1)
        ]


smallHeader : List (Attribute msg) -> List (Html msg) -> Html msg
smallHeader =
    basis
        [ -- .ui.small.header
          fontSize (em 1.07142857)
        ]


mediumHeader : List (Attribute msg) -> List (Html msg) -> Html msg
mediumHeader =
    basis []


largeHeader : List (Attribute msg) -> List (Html msg) -> Html msg
largeHeader =
    basis
        [ -- .ui.large.header
          fontSize (em 1.71428571)
        ]


bigHeader : List (Attribute msg) -> List (Html msg) -> Html msg
bigHeader =
    basis
        [ -- .ui.big.header
          fontSize (em 1.85714286)
        ]


hugeHeader : List (Attribute msg) -> List (Html msg) -> Html msg
hugeHeader =
    basis
        [ -- .ui.huge.header
          fontSize (em 2)
        , minHeight (em 1)
        ]


massiveHeader : List (Attribute msg) -> List (Html msg) -> Html msg
massiveHeader =
    basis
        [ -- .ui.massive.header
          fontSize (em 2.28571429)
        , minHeight (em 1)
        ]


wireframeParagraph : Html msg
wireframeParagraph =
    Html.img
        [ src "/static/images/wireframe/short-paragraph.png"
        , css
            [ marginTop (rem 1)
            , marginBottom (rem 1)
            , maxWidth (px 500)
            , opacity (num 0.5)
            , display block
            , position relative
            , verticalAlign middle
            , backgroundColor Css.transparent
            ]
        ]
        []
