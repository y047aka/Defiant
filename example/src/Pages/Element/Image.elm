module Pages.Element.Image exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (src)
import Page
import Request exposing (Request)
import Shared
import UI.Image exposing (smallImage)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Image"
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
        { title = "Image"
        , preview = [ smallImage [ src "/static/images/wireframe/image.png" ] [] ]
        , configSections = []
        }
    ]
