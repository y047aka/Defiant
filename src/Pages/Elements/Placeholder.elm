module Pages.Elements.Placeholder exposing (page)

import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Placeholder as Placeholder exposing (line)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Placeholder"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ example
        { title = "Lines"
        , description = "A placeholder can contain have lines of text"
        }
        [ Placeholder.placeholder []
            [ line [] []
            , line [] []
            , line [] []
            , line [] []
            , line [] []
            ]
        ]
    ]
