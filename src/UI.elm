module UI exposing (header, section)

import Html.Styled exposing (Attribute, Html)
import UI.Header as Header
import UI.Section as Section



-- HEADER


header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    Header.header



-- SECTION


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    Section.section
