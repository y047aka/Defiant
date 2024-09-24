module UI.Icon exposing (chevronRight, crossBold, information)

import Svg.Styled exposing (Attribute, Svg, path, svg)
import Svg.Styled.Attributes exposing (d, fill, height, viewBox, width)
import Svg.Styled.Extra exposing (role, xmlns)


svgIcon : List (Attribute msg) -> String -> Svg msg
svgIcon attributes draw =
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
        [ path [ d draw ] [] ]


chevronRight : List (Attribute msg) -> Svg msg
chevronRight attributes =
    svgIcon attributes "M9.41 21c-.26 0-.51-.1-.71-.29a.996.996 0 0 1 0-1.41L16 12 8.71 4.71a.996.996 0 1 1 1.41-1.41l7.29 7.29c.78.78.78 2.05 0 2.83l-7.29 7.29c-.19.19-.45.29-.71.29Z"


crossBold : List (Attribute msg) -> Svg msg
crossBold attributes =
    svgIcon attributes "M18.71 5.29a.996.996 0 0 0-1.41 0L12 10.59 7.71 6.29a.996.996 0 1 0-1.41 1.41L10.59 12 5.29 16.29a.996.996 0 1 0 1.41 1.41L12 13.41l4.29 4.29a.996.996 0 1 0 1.41-1.41L13.41 12l4.29-4.29a.996.996 0 0 0 0-1.42Z"


information : List (Attribute msg) -> Svg msg
information attributes =
    svgIcon attributes "M12.01 22c5.51 0 10-4.49 10-10s-4.49-10-10-10-10 4.49-10 10 4.48 10 10 10Zm0-18c4.41 0 8 3.59 8 8s-3.59 8-8 8-8-3.59-8-8 3.59-8 8-8Zm-1.25 12.5V11a1.25 1.25 0 0 1 2.5 0v5.5a1.25 1.25 0 0 1-2.5 0Zm0-8.75a1.25 1.25 0 1 1 2.5 0 1.25 1.25 0 0 1-2.5 0Z"
