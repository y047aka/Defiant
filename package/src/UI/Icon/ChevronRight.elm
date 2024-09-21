module UI.Icon.ChevronRight exposing (chevronRight)

import Svg.Styled exposing (Attribute, Svg, path, svg)
import Svg.Styled.Attributes exposing (d, fill, height, viewBox, width)
import VirtualDom


chevronRight : List (Attribute msg) -> Svg msg
chevronRight attributes =
    svg
        ([ xmlns "http://www.w3.org/2000/svg"
         , width "1em"
         , height "1em"
         , fill "currentColor"
         , viewBox "0 0 24 24"
         , role "img"
         ]
            ++ attributes
        )
        [ path [ d "M9.41 21c-.26 0-.51-.1-.71-.29a.996.996 0 0 1 0-1.41L16 12 8.71 4.71a.996.996 0 1 1 1.41-1.41l7.29 7.29c.78.78.78 2.05 0 2.83l-7.29 7.29c-.19.19-.45.29-.71.29Z" ] [] ]



-- ATTRIBUTE HELPERS


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
