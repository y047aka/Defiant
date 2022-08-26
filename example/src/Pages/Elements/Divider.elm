module Pages.Elements.Divider exposing (page)

import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Divider exposing (divider)
import UI.Example exposing (wireframeShortParagraph)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Divider"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ configAndPreview
        { title = "Divider"
        , preview =
            [ wireframeShortParagraph
            , divider [] []
            , wireframeShortParagraph
            ]
        , configs = []
        }
    ]
