module Pages.Elements.Image exposing (page)

import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (src)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Image exposing (smallImage)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Image"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ configAndPreview
        { title = "Image"
        , preview = [ smallImage [ src "/static/images/wireframe/image.png" ] [] ]
        , configs = []
        }
    ]
