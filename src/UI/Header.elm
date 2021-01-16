module UI.Header exposing
    ( header, massiveHeader
    , hugeHeader, bigHeader, largeHeader, mediumHeader, smallHeader, tinyHeader, miniHeader
    )

{-|

@docs header, massiveHeader
@docs hugeHeader, bigHeader, largeHeader, mediumHeader, smallHeader, tinyHeader, miniHeader

-}

import Css exposing (..)
import Css.Global exposing (adjacentSiblings, typeSelector)
import Css.Typography as Typography exposing (typography)
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    let
        headingTypography =
            Typography.heading
    in
    Html.styled Html.h1 <|
        [ -- .ui.header
          borderStyle none
        , margin3 (calc (rem 2) minus (em 0.1428571428571429)) zero (rem 1)
        , padding2 zero zero
        , typography
            { headingTypography
                | fontSize = ""
                , textTransform = Typography.none
            }
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
