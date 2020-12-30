module Css.Prefix exposing (alignItems, alignSelf, boxShadow, displayFlex, flex, flexDirection, userSelect)

import Css exposing (Style, batch, property)
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


boxShadow : String -> Style
boxShadow value =
    batch <|
        prefixedProperties [ "-webkit-", "" ] "box-shadow" value


displayFlex : Style
displayFlex =
    batch
        [ property "display" "-webkit-box"
        , property "display" "-ms-flexbox"
        , Css.displayFlex
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
            :: prefixedProperties [ "-ms-", "" ] "flex" value


flexDirection : String -> Style
flexDirection value =
    batch <|
        prefixedProperties [ "-ms-", "" ] "flex-direction" value


userSelect : String -> Style
userSelect value =
    batch <|
        prefixedProperties [ "-webkit-", "-moz-", "-ms-", "" ] "user-select" value
