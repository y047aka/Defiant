module Html.Styled.Attributes.Aria exposing (ariaCurrent, ariaHidden, ariaLabel)

import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (attribute)
import Json.Encode as JE


boolAttribute : String -> Bool -> Attribute msg
boolAttribute key bool =
    attribute key (JE.encode 0 <| JE.bool bool)


ariaCurrent : String -> Attribute msg
ariaCurrent =
    attribute "aria-current"


ariaHidden : Bool -> Attribute msg
ariaHidden =
    boolAttribute "aria-hidden"


ariaLabel : String -> Attribute msg
ariaLabel =
    attribute "aria-label"
