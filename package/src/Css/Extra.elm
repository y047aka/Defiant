module Css.Extra exposing
    ( batchIf, orNone
    , marginBlock, marginInline, paddingBlock, paddingInline
    , fr
    , gap, rowGap, columnGap
    , grid, gridTemplateColumns, gridTemplateRows, gridAutoColumns, gridAutoRows, gridColumn, gridRow
    , prefixed
    )

{-|

@docs batchIf, orNone

@docs marginBlock, marginInline, paddingBlock, paddingInline

@docs fr
@docs gap, rowGap, columnGap
@docs grid, gridTemplateColumns, gridTemplateRows, gridAutoColumns, gridAutoRows, gridColumn, gridRow

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



-- COMPATIBLE


dummyCompatible : Compatible
dummyCompatible =
    Css.initial.all



-- LENGTHS


type alias Fr =
    ExplicitLength FrUnits


fr : Float -> Fr
fr =
    lengthConverter_ FrUnits "fr"


type FrUnits
    = FrUnits


lengthConverter_ : units -> String -> Float -> ExplicitLength units
lengthConverter_ units unitLabel numericValue =
    { value = String.fromFloat numericValue ++ unitLabel
    , numericValue = numericValue
    , units = units
    , unitLabel = unitLabel
    , length = dummyCompatible
    , lengthOrAuto = dummyCompatible
    , lengthOrNumber = dummyCompatible
    , lengthOrNone = dummyCompatible
    , lengthOrMinMaxDimension = dummyCompatible
    , lengthOrNoneOrMinMaxDimension = dummyCompatible
    , textIndent = dummyCompatible
    , flexBasis = dummyCompatible
    , lengthOrNumberOrAutoOrNoneOrContent = dummyCompatible
    , fontSize = dummyCompatible
    , absoluteLength = dummyCompatible
    , lengthOrAutoOrCoverOrContain = dummyCompatible
    , lineHeight = dummyCompatible
    , calc = dummyCompatible
    }



-- PROPERTIES


prop1 : String -> Value a -> Style
prop1 key arg =
    property key arg.value


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



-- GRID LAYOUT


grid : Display {}
grid =
    { value = "grid", display = dummyCompatible }


gridTemplateColumns : List (Length compatible units) -> Style
gridTemplateColumns units =
    property "grid-template-columns" (String.join " " <| List.map .value units)


gridTemplateRows : List (Length compatible units) -> Style
gridTemplateRows units =
    property "grid-template-rows" (String.join " " <| List.map .value units)


gridAutoColumns : Length compatible units -> Style
gridAutoColumns =
    prop1 "grid-auto-columns"


gridAutoRows : Length compatible units -> Style
gridAutoRows =
    prop1 "grid-auto-rows"


gridColumn : String -> Style
gridColumn =
    property "grid-column"


gridRow : String -> Style
gridRow =
    property "grid-row"



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
