module UI.Placeholder exposing
    ( placeholder, line
    , image, squareImage, rectangularImage
    )

{-|

@docs placeholder, line
@docs image, squareImage, rectangularImage

-}

import Css exposing (..)
import Css.Animations as Animations exposing (keyframes)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, selector)
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    let
        placeholderShimmer =
            keyframes
                [ ( 0, [ Animations.property "background-position" "-1200px 0" ] )
                , ( 100, [ Animations.property "background-position" "1200px 0" ] )
                ]
    in
    Html.styled Html.div <|
        [ -- .ui.placeholder
          position static
        , overflow hidden
        , animationName placeholderShimmer
        , animationDuration (sec 2)
        , property "animation-timing-function" "linear"
        , property "animation-iteration-count" "infinite"
        , backgroundColor (hex "#FFFFFF")
        , property "background-image" "-webkit-gradient(linear, left top, right top, color-stop(0, rgba(0, 0, 0, 0.08)), color-stop(15%, rgba(0, 0, 0, 0.15)), color-stop(30%, rgba(0, 0, 0, 0.08)))"
        , property "background-image" "-webkit-linear-gradient(left, rgba(0, 0, 0, 0.08) 0, rgba(0, 0, 0, 0.15) 15%, rgba(0, 0, 0, 0.08) 30%)"
        , property "background-image" "linear-gradient(to right, rgba(0, 0, 0, 0.08) 0, rgba(0, 0, 0, 0.15) 15%, rgba(0, 0, 0, 0.08) 30%)"
        , backgroundSize2 (px 1200) (pct 100)
        , maxWidth (rem 30)

        -- .ui.placeholder + .ui.placeholder
        , nthChild "n+2"
            [ marginTop (rem 2)
            , prefixed [] "animation-delay" "0.15s"
            ]

        -- .ui.placeholder + .ui.placeholder + .ui.placeholder
        , nthChild "n+3"
            [ prefixed [] "animation-delay" "0.3s" ]

        -- .ui.placeholder + .ui.placeholder + .ui.placeholder + .ui.placeholder
        , nthChild "n+4"
            [ prefixed [] "animation-delay" "0.45s" ]

        -- .ui.placeholder + .ui.placeholder + .ui.placeholder + .ui.placeholder + .ui.placeholder
        , nthChild "n+5"
            [ prefixed [] "animation-delay" "0.6s" ]

        -- .ui.placeholder
        -- .ui.placeholder > :before
        -- .ui.placeholder .image.header:after
        -- .ui.placeholder .line
        -- .ui.placeholder .line:after
        , backgroundColor (hex "#FFFFFF")
        , children
            [ selector ":before"
                [ backgroundColor (hex "#FFFFFF") ]
            ]
        ]
            ++ additionalStyles


placeholder : List (Attribute msg) -> List (Html msg) -> Html msg
placeholder =
    basis []


line : List (Attribute msg) -> List (Html msg) -> Html msg
line =
    Html.styled Html.div <|
        [ -- .ui.placeholder
          -- .ui.placeholder > :before
          -- .ui.placeholder .image.header:after
          -- .ui.placeholder .line
          -- .ui.placeholder .line:after
          backgroundColor (hex "#FFFFFF")
        , pseudoClass ":after"
            [ backgroundColor (hex "#FFFFFF") ]

        -- .ui.placeholder .line
        , position relative
        , height (em 0.85714286)

        -- .ui.placeholder .line:before
        -- .ui.placeholder .line:after
        , before
            [ top (pct 100)
            , position absolute
            , property "content" (qt "")
            , backgroundColor inherit
            ]
        , after
            [ top (pct 100)
            , position absolute
            , property "content" (qt "")
            , backgroundColor inherit
            ]

        -- .ui.placeholder .line:before
        , before
            [ left zero ]

        -- .ui.placeholder .line:after
        , after
            [ right zero ]

        -- .ui.placeholder .line
        , marginBottom (em 0.5)

        -- .ui.placeholder .line:before
        -- .ui.placeholder .line:after
        , before
            [ height (em 0.5) ]
        , after
            [ height (em 0.5) ]

        -- .ui.placeholder .line:not(:first-child)
        , pseudoClass "not(:first-child)"
            [ marginTop (em 0.5) ]

        -- .ui.placeholder .line:nth-child(1):after
        , nthChild "1" [ after [ width zero ] ]

        -- .ui.placeholder .line:nth-child(2):after
        , nthChild "2" [ after [ width (pct 50) ] ]

        -- .ui.placeholder .line:nth-child(3):after {
        , nthChild "3" [ after [ width (pct 10) ] ]

        -- .ui.placeholder .line:nth-child(4):after {
        , nthChild "4" [ after [ width (pct 35) ] ]

        -- .ui.placeholder .line:nth-child(5):after {
        , nthChild "5" [ after [ width (pct 65) ] ]
        ]


image : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
image additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.placeholder .image:not(.header):not(.ui):not(.icon)
          height (px 100)

        -- .ui.placeholder .image:not(:first-child):before
        -- .ui.placeholder .paragraph:not(:first-child):before
        -- .ui.placeholder .header:not(:first-child):before
        -- , before
        --     [ height (em 1.42857143)
        --     , property "content" (qt "")
        --     , display block
        --     ]
        ]
            ++ additionalStyles


squareImage : List (Attribute msg) -> List (Html msg) -> Html msg
squareImage =
    image
        [ -- .ui.placeholder .square.image:not(.header)
          height zero
        , overflow hidden

        -- 1/1 aspect ratio
        , paddingTop (pct 100)
        ]


rectangularImage : List (Attribute msg) -> List (Html msg) -> Html msg
rectangularImage =
    image
        [ -- .ui.placeholder .rectangular.image:not(.header)
          height zero
        , overflow hidden

        -- 4/3 aspect ratio
        , paddingTop (pct 75)
        ]
