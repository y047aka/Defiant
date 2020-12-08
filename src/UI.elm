module UI exposing
    ( button, basicButton, buttonWithOption, labeledButton
    , header
    , label, basicLabel, labelWithOption
    , section
    )

{-|

@docs button, basicButton, buttonWithOption, labeledButton
@docs header
@docs label, basicLabel, labelWithOption
@docs primaryLabel, secondaryLabel
@docs section

-}

import Html.Styled exposing (Attribute, Html)
import UI.Button as Button
import UI.Header as Header
import UI.Label as Label
import UI.Modifier exposing (Palette(..))
import UI.Section as Section



-- BUTTON


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    Button.button


basicButton : List (Attribute msg) -> List (Html msg) -> Html msg
basicButton =
    Button.basicButton


buttonWithOption : Label.Options -> List (Attribute msg) -> List (Html msg) -> Html msg
buttonWithOption options =
    Button.buttonWithOption options


labeledButton : List (Attribute msg) -> List (Html msg) -> Html msg
labeledButton =
    Button.labeledButton



-- HEADER


header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    Header.header



-- LABEL


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    Label.label


basicLabel : List (Attribute msg) -> List (Html msg) -> Html msg
basicLabel =
    Label.basicLabel


labelWithOption : Label.Options -> List (Attribute msg) -> List (Html msg) -> Html msg
labelWithOption options =
    Label.labelWithOption options



-- SECTION


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    Section.section
