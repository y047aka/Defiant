module Css.Extra exposing (none, orNone, prefixed, when)

import Css exposing (..)



-- HELPERS


none : Style
none =
    batch []


when : Bool -> Style -> Style
when condition style =
    if condition then
        style

    else
        none


orNone : Maybe a -> (a -> Style) -> Style
orNone maybe f =
    maybe
        |> Maybe.map f
        |> Maybe.withDefault none



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
