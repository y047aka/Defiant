module Pages.Defiant.Items exposing (page)

import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Items exposing (itemsToList, itemsToTable)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Items"
            , body = view
            }
        }


type alias Record msg =
    { heading : String, content : Html msg }


data : List (Record msg)
data =
    { heading = "Header"
    , content = text "Description"
    }
        |> List.repeat 2


config : { properties : List { label : String, getter : Record msg -> Html msg } }
config =
    { properties =
        [ { label = "Heading", getter = .heading >> text }
        , { label = "Content", getter = .content }
        ]
    }


view : List (Html msg)
view =
    [ example
        { title = "List"
        , description = ""
        }
        [ itemsToList [] config data ]
    , example
        { title = "Table"
        , description = ""
        }
        [ itemsToTable [] config data ]
    ]
