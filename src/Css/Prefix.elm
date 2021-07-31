module Css.Prefix exposing (alignItems, alignSelf, displayFlex, displayInlineFlex, flex)

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
