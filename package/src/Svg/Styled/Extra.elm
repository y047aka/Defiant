module Svg.Styled.Extra exposing (attribute, role, xmlns)

import Svg.Styled exposing (Attribute)
import Svg.Styled.Attributes
import VirtualDom


attribute : String -> String -> Attribute msg
attribute key value =
    VirtualDom.attribute key value
        |> Svg.Styled.Attributes.fromUnstyled


xmlns : String -> Attribute msg
xmlns =
    attribute "xmlns"


role : String -> Attribute msg
role =
    attribute "role"
