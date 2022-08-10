module Pages.Collections.Breadcrumb exposing (page)

import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Breadcrumb exposing (breadcrumb)
import UI.Icon exposing (icon)
import UI.Segment exposing (segment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Breadcrumb"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
    [ configAndPreview { title = "Breadcrumb" }
        (breadcrumb { divider = text "/", theme = shared.theme }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        )
        []
    , configAndPreview { title = "" }
        (breadcrumb { divider = icon [] "fas fa-angle-right", theme = shared.theme }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        )
        []
    , configAndPreview { title = "Divider" }
        (breadcrumb { divider = text "/", theme = shared.theme }
            [ { label = "Home", url = "/" }
            , { label = "Registration", url = "/" }
            , { label = "Personal Information", url = "" }
            ]
        )
        []
    , configAndPreview { title = "Active" }
        (breadcrumb { divider = text "/", theme = shared.theme }
            [ { label = "Products", url = "/" }
            , { label = "Paper Towels", url = "" }
            ]
        )
        []
    , configAndPreview { title = "Inverted" }
        (segment { theme = Dark }
            []
            [ breadcrumb { divider = text "/", theme = Dark }
                [ { label = "Home", url = "/" }
                , { label = "Registration", url = "/" }
                , { label = "Personal Information", url = "" }
                ]
            ]
        )
        []
    ]
