module Pages.Modules.Checkbox exposing (page)

import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (for, id, type_)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Example exposing (example)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Checkbox"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ example
        { title = "Checkbox"
        , description = "A checkbox allows a user to select a value from a small set of options, often binary"
        }
        [ checkbox []
            [ Checkbox.input [ id "checkbox_example", type_ "checkbox" ] []
            , Checkbox.label [ for "checkbox_example" ] [ text "Make my profile visible" ]
            ]
        ]
    ]
