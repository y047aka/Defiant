module Pages.Element.Placeholder exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html)
import Page
import Request exposing (Request)
import Shared
import UI.Placeholder as Placeholder exposing (line)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Placeholder"
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
    = UpdateConfig (Config.Msg Model Msg)


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ configAndPreview UpdateConfig { theme = theme } <|
        { title = "Lines"
        , preview =
            [ Placeholder.placeholder []
                [ line [] []
                , line [] []
                , line [] []
                , line [] []
                , line [] []
                ]
            ]
        , configSections = []
        }
    ]
