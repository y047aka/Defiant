module Pages.Elements.Placeholder exposing (page)

import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Placeholder as Placeholder exposing (line)
import View.ConfigAndPreview exposing (configAndPreview)


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
    [ configAndPreview { title = "Lines" }
        [ Placeholder.placeholder []
            [ line [] []
            , line [] []
            , line [] []
            , line [] []
            , line [] []
            ]
        ]
        []
    ]
