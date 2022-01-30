module Pages.Modules.Tab exposing (page)

import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example, wireframeParagraph)
import UI.Tab exposing (State(..), tab)


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
    [ example
        { title = "Tab"
        , description = "A basic tab"
        }
        [ tab { state = Inactive }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    , example
        { title = "Active"
        , description = "A tab can be activated, and visible on the page"
        }
        [ tab { state = Active }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    , example
        { title = "Loading"
        , description = "A tab can display a loading indicator"
        }
        [ tab { state = Loading }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    ]
