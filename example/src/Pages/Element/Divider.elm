module Pages.Element.Divider exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html)
import Page
import Request exposing (Request)
import Shared
import UI.Divider exposing (divider)
import UI.Example exposing (wireframeShortParagraph)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Divider"
                , body = view
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


view : List (Html Msg)
view =
    [ configAndPreview UpdateConfig
        { title = "Divider"
        , preview =
            [ wireframeShortParagraph
            , divider [] []
            , wireframeShortParagraph
            ]
        , configSections = []
        }
    ]
