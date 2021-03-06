module Css.Prefix exposing (alignItems, alignSelf, animationDelay, animationDuration, animationFillMode, appearance, backfaceVisibility, boxShadow, boxSizing, displayFlex, displayInlineFlex, flex, flexDirection, flexWrap, userSelect)

import Css exposing (Style, batch, display, inlineFlex, property)
import Css.Extra


prefixedProperties : List String -> String -> String -> List Style
prefixedProperties prefixes property value =
    prefixes
        |> List.map (\prefix_ -> Css.property (prefix_ ++ property) value)


alignItems : String -> Style
alignItems value =
    batch
        [ Css.property "-webkit-box-align" value
        , Css.property "-ms-flex-align" value
        , Css.property "align-items" value
        ]


alignSelf : String -> Style
alignSelf value =
    batch
        [ Css.property "-ms-flex-item-align" value
        , Css.property "align-self" value
        ]


animationDelay : String -> Style
animationDelay value =
    batch <|
        prefixedProperties [ "-webkit-", "" ] "animation-delay" value


animationDuration : String -> Style
animationDuration value =
    batch <|
        prefixedProperties [ "-webkit-", "" ] "animation-duration" value


animationFillMode : String -> Style
animationFillMode value =
    batch <|
        prefixedProperties [ "-webkit-", "" ] "animation-fill-mode" value


appearance : String -> Style
appearance value =
    batch <|
        prefixedProperties [ "-webkit-", "-moz-" ] "appearance" value


backfaceVisibility : String -> Style
backfaceVisibility value =
    batch <|
        prefixedProperties [ "-webkit-", "" ] "backface-visibility" value


boxShadow : String -> Style
boxShadow value =
    batch <|
        prefixedProperties [ "-webkit-", "" ] "box-shadow" value


boxSizing : String -> Style
boxSizing value =
    batch <|
        prefixedProperties [ "-webkit-", "" ] "box-sizing" value


displayFlex : Style
displayFlex =
    batch
        [ property "display" "-webkit-box"
        , property "display" "-ms-flexbox"
        , Css.displayFlex
        ]


displayInlineFlex : Style
displayInlineFlex =
    batch
        [ property "display" "-webkit-inline-box"
        , property "display" "-ms-inline-flexbox"
        , display inlineFlex
        ]


flex : String -> Style
flex value =
    batch <|
        (value
            |> String.split " "
            |> List.head
            |> Maybe.map (Css.property "-webkit-box-flex")
            |> Maybe.withDefault Css.Extra.none
        )
            :: prefixedProperties [ "-webkit-", "-ms-", "" ] "flex" value


flexDirection : String -> Style
flexDirection value =
    batch <|
        prefixedProperties [ "-ms-", "" ] "flex-direction" value


flexWrap : String -> Style
flexWrap value =
    batch <|
        prefixedProperties [ "-ms-", "" ] "flex-wrap" value


userSelect : String -> Style
userSelect value =
    batch <|
        prefixedProperties [ "-webkit-", "-moz-", "-ms-", "" ] "user-select" value
