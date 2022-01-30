module Pages.Defiant.HolyGrail exposing (page)

import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example, wireframeParagraph)
import UI.HolyGrail exposing (holyGrail)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Holy Grail"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ example
        { title = "Holy grail"
        , description = "Holy grail layout"
        }
        [ holyGrail
            { header = [ text "header" ]
            , main = [ wireframeParagraph ]
            , aside_left = [ text "aside" ]
            , aside_right = [ text "aside" ]
            , footer = [ text "footer" ]
            }
        ]
    ]
