module UI.Icon.CrossBold exposing (crossBold)

import Svg.Styled exposing (Attribute, Svg, path, svg)
import Svg.Styled.Attributes exposing (d, fill, height, viewBox, width)
import Svg.Styled.Extra exposing (role, xmlns)


crossBold : List (Attribute msg) -> Svg msg
crossBold attributes =
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
        [ path [ d "M18.71 5.29a.996.996 0 0 0-1.41 0L12 10.59 7.71 6.29a.996.996 0 1 0-1.41 1.41L10.59 12 5.29 16.29a.996.996 0 1 0 1.41 1.41L12 13.41l4.29 4.29a.996.996 0 1 0 1.41-1.41L13.41 12l4.29-4.29a.996.996 0 0 0 0-1.42Z" ] [] ]
