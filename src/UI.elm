module UI exposing (section)

import Html.Styled exposing (Attribute, Html)
import UI.Section as Section



-- SECTION


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    Section.section
