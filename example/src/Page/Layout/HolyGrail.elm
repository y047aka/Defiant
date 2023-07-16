module Page.Layout.HolyGrail exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import UI.Example exposing (wireframeParagraph)
import UI.HolyGrail exposing (holyGrail)



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type alias Msg =
    ()


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ playground
        { title = "Holy grail"
        , theme = theme
        , inverted = False
        , preview =
            [ holyGrail
                { header = [ text "header" ]
                , main = [ wireframeParagraph ]
                , aside_left = [ text "aside" ]
                , aside_right = [ text "aside" ]
                , footer = [ text "footer" ]
                }
            ]
        , configSections = []
        }
    ]
