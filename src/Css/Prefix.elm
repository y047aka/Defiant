module Css.Prefix exposing (boxShadow, userSelect)

import Css exposing (Style, batch)


prefixedProperties : List String -> String -> String -> List Style
prefixedProperties prefixes property value =
    prefixes
        |> List.map (\prefix_ -> Css.property (prefix_ ++ property) value)


boxShadow : String -> Style
boxShadow value =
    batch <|
        prefixedProperties [ "-webkit-", "" ] "box-shadow" value


userSelect : String -> Style
userSelect value =
    batch <|
        prefixedProperties [ "-webkit-", "-moz-", "-ms-", "" ] "user-select" value
