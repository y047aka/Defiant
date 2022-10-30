module Pages.Layout.HolyGrail exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, text)
import Page
import Request exposing (Request)
import Shared
import UI.Example exposing (wireframeParagraph)
import UI.HolyGrail exposing (holyGrail)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Holy Grail"
                , body = view shared
                }
        }



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Holy grail"
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
