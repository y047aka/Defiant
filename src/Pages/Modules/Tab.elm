module Pages.Modules.Tab exposing (page)

import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (wireframeParagraph)
import UI.Tab exposing (State(..), tab)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Tab"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ configAndPreview { title = "Tab" }
        [ tab { state = Inactive }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
        []
    , configAndPreview { title = "Active" }
        [ tab { state = Active }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
        []
    , configAndPreview { title = "Loading" }
        [ tab { state = Loading }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
        []
    ]
