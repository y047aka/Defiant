module Pages.Collections.Breadcrumb exposing (page)

import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Breadcrumb exposing (breadcrumb)
import UI.Example exposing (example)
import UI.Icon exposing (icon)
import UI.Segment exposing (segment)


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
    let
        inverted =
            shared.darkMode
    in
    [ example
        { title = "Breadcrumb"
        , description = "A standard breadcrumb"
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ breadcrumb { divider = icon [] "fas fa-angle-right", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        ]
    , example
        { title = "Divider"
        , description = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Registration", url = "/" }
            , { label = "Personal Information", url = "" }
            ]
        ]
    , example
        { title = "Active"
        , description = "A section can be active"
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Products", url = "/" }
            , { label = "Paper Towels", url = "" }
            ]
        ]
    , example
        { title = "Inverted"
        , description = "A breadcrumb can be inverted"
        }
        [ segment { inverted = True }
            []
            [ breadcrumb { divider = text "/", inverted = True }
                [ { label = "Home", url = "/" }
                , { label = "Registration", url = "/" }
                , { label = "Personal Information", url = "" }
                ]
            ]
        ]
    ]
