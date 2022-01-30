module Pages.Elements.Input exposing (page)

import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes exposing (placeholder, type_)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Input as Input


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Input"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ example
        { title = "Input"
        , description = "A standard input"
        }
        [ Input.input []
            [ input [ type_ "text", placeholder "Search..." ] [] ]
        ]
    , example
        { title = "Labeled"
        , description = "An input can be formatted with a label"
        }
        [ Input.input []
            [ Input.label [] [ text "http://" ]
            , input [ type_ "text", placeholder "mysite.com" ] []
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Input.input []
            [ input [ type_ "text", placeholder "Enter weight.." ] []
            , Input.label [] [ text "kg" ]
            ]
        ]
    ]
