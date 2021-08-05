module UI.Header exposing
    ( header
    , massiveHeader, hugeHeader, bigHeader, largeHeader, mediumHeader, smallHeader, tinyHeader, miniHeader
    , subHeader
    , iconHeader, iconHeaderContent
    )

{-|

@docs header
@docs massiveHeader, hugeHeader, bigHeader, largeHeader, mediumHeader, smallHeader, tinyHeader, miniHeader
@docs subHeader
@docs iconHeader, iconHeaderContent

-}

import Css exposing (..)
import Css.Global exposing (adjacentSiblings, children, typeSelector)
import Css.Typography as Typography exposing (typography)
import Html.Styled as Html exposing (Attribute, Html)


basis : { inverted : Bool } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis { inverted } additionalStyles =
    let
        headingTypography =
            Typography.heading
    in
    Html.styled Html.header
        [ -- .ui.header
          borderStyle none
        , margin3 (calc (rem 2) minus (em 0.1428571428571429)) zero (rem 1)
        , padding2 zero zero
        , typography
            { headingTypography
                | fontSize = ""
                , textTransform = Typography.none
            }
        , if inverted then
            -- .ui.inverted.header
            color (hex "#FFFFFF")

          else
            color (rgba 0 0 0 0.87)

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

        -- AdditionalStyles
        , batch additionalStyles
        ]


header : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
header { inverted } =
    basis { inverted = inverted } []


miniHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
miniHeader { inverted } =
    basis { inverted = inverted }
        [ -- .ui.mini.header
          fontSize (em 0.85714286)
        ]


tinyHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
tinyHeader { inverted } =
    basis { inverted = inverted }
        [ -- .ui.tiny.header
          fontSize (em 1)
        ]


smallHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
smallHeader { inverted } =
    basis { inverted = inverted }
        [ -- .ui.small.header
          fontSize (em 1.07142857)
        ]


mediumHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
mediumHeader { inverted } =
    basis { inverted = inverted } []


largeHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
largeHeader { inverted } =
    basis { inverted = inverted }
        [ -- .ui.large.header
          fontSize (em 1.71428571)
        ]


bigHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
bigHeader { inverted } =
    basis { inverted = inverted }
        [ -- .ui.big.header
          fontSize (em 1.85714286)
        ]


hugeHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
hugeHeader { inverted } =
    basis { inverted = inverted }
        [ -- .ui.huge.header
          fontSize (em 2)
        , minHeight (em 1)
        ]


massiveHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
massiveHeader { inverted } =
    basis { inverted = inverted }
        [ -- .ui.massive.header
          fontSize (em 2.28571429)
        , minHeight (em 1)
        ]


subHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
subHeader { inverted } =
    Html.styled Html.div
        [ -- .ui.header .sub.header
          display block
        , fontWeight normal
        , padding zero
        , margin zero
        , fontSize (rem 1)
        , lineHeight (em 1.2)
        , if inverted then
            -- .ui.inverted.header .sub.header
            color (rgba 255 255 255 0.8)

          else
            color (rgba 0 0 0 0.6)
        ]


iconHeader : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
iconHeader { inverted } =
    basis { inverted = inverted }
        [ -- .ui.icon.header
          display inlineBlock
        , textAlign center
        , margin3 (rem 2) zero (rem 1)

        -- .ui.icon.header:after
        , after
            [ property "content" "''"
            , display block
            , height zero
            , property "clear" "both"
            , visibility hidden
            ]

        -- .ui.icon.header:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.icon.header > i.icon
        , children
            [ Css.Global.i
                [ property "float" "none"
                , display block
                , width auto
                , height auto
                , lineHeight (int 1)
                , padding zero
                , fontSize (em 3)
                , margin3 zero auto (rem 0.5)
                , opacity (int 1)
                ]
            ]
        ]


iconHeaderContent : List (Attribute msg) -> List (Html msg) -> Html msg
iconHeaderContent =
    Html.styled Html.div
        [ -- .ui.icon.header .content
          display block
        , padding zero
        ]
