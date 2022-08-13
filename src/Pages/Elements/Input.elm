module Pages.Elements.Input exposing (page)

import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes exposing (placeholder, type_)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Input as Input
import View.ConfigAndPreview exposing (configAndPreview)


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
    [ configAndPreview { title = "Input" }
        [ Input.input []
            [ input [ type_ "text", placeholder "Search..." ] [] ]
        ]
        []
    , configAndPreview { title = "Labeled" }
        [ Input.input []
            [ Input.label [] [ text "http://" ]
            , input [ type_ "text", placeholder "mysite.com" ] []
            ]
        ]
        []
    , configAndPreview { title = "" }
        [ Input.input []
            [ input [ type_ "text", placeholder "Enter weight.." ] []
            , Input.label [] [ text "kg" ]
            ]
        ]
        []
    ]
