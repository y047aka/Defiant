module Css.Extra exposing
    ( batchIf, orNone
    , marginBlock, marginInline, paddingBlock, paddingInline
    , gap, rowGap, columnGap
    , prefixed
    )

{-|

@docs batchIf, orNone

@docs marginBlock, marginInline, paddingBlock, paddingInline
@docs gap, rowGap, columnGap

@docs prefixed

-}

import Css exposing (..)



-- HELPERS


none : Style
none =
    batch []


batchIf : Bool -> List Style -> Style
batchIf condition styles =
    if condition then
        batch styles

    else
        none


orNone : Maybe a -> (a -> Style) -> Style
orNone maybe f =
    maybe
        |> Maybe.map f
        |> Maybe.withDefault none



-- PROPERTIES


marginBlock : LengthOrAuto compatible -> Style
marginBlock { value } =
    property "margin-block" value


marginInline : LengthOrAuto compatible -> Style
marginInline { value } =
    property "margin-inline" value


paddingBlock : LengthOrAuto compatible -> Style
paddingBlock { value } =
    property "padding-block" value


paddingInline : LengthOrAuto compatible -> Style
paddingInline { value } =
    property "padding-inline" value


gap : Length compatible units -> Style
gap { value } =
    property "gap" value


rowGap : Length compatible units -> Style
rowGap { value } =
    property "row-gap" value


columnGap : Length compatible units -> Style
columnGap { value } =
    property "column-gap" value



-- PREFIXER


prefixed : List String -> String -> String -> Style
prefixed additionalPrefixes p v =
    let
        originalStyle =
            Css.property p v

        prefixedStyles defaultPrefixes =
            (defaultPrefixes ++ additionalPrefixes)
                |> List.map (\prefix -> Css.property (prefix ++ p) v)

        default defaultPrefixes =
            batch <| prefixedStyles defaultPrefixes ++ [ originalStyle ]
    in
    case p of
        "align-items" ->
            batch
                [ property "-webkit-box-align" v
                , property "-ms-flex-align" v
                , originalStyle
                ]

        "align-self" ->
            batch
                [ Css.property "-ms-flex-item-align" v
                , originalStyle
                ]

        "animation" ->
            default [ "-webkit-" ]

        "animation-delay" ->
            default [ "-webkit-" ]

        "animation-duration" ->
            default [ "-webkit-" ]

        "animation-fill-mode" ->
            default [ "-webkit-" ]

        "appearance" ->
            prefixedStyles [ "-webkit-" ] |> batch

        "backface-visibility" ->
            default [ "-webkit-" ]

        "box-shadow" ->
            default [ "-webkit-" ]

        "box-sizing" ->
            default [ "-webkit-" ]

        "display" ->
            case v of
                "flex" ->
                    batch
                        [ property "display" "-webkit-box"
                        , property "display" "-ms-flexbox"
                        , originalStyle
                        ]

                "inline-flex" ->
                    batch
                        [ property "display" "-webkit-inline-box"
                        , property "display" "-ms-inline-flexbox"
                        , originalStyle
                        ]

                _ ->
                    originalStyle

        "flex" ->
            case String.split " " v of
                x :: _ ->
                    batch
                        [ Css.property "-webkit-box-flex" x
                        , default [ "-webkit-", "-ms-" ]
                        ]

                [] ->
                    default [ "-webkit-", "-ms-" ]

        "flex-direction" ->
            default [ "-ms-" ]

        "flex-wrap" ->
            default [ "-ms-" ]

        "justify-content" ->
            batch
                [ property "-webkit-box-pack" v
                , property "-ms-flex-pack" v
                , originalStyle
                ]

        "transform" ->
            default [ "-webkit-" ]

        "transform-origin" ->
            default [ "-webkit-" ]

        "user-select" ->
            default [ "-webkit-", "-moz-", "-ms-" ]

        _ ->
            originalStyle
