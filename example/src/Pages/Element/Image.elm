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
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Image"
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
        { title = "Image"
        , preview = [ smallImage [ src "/static/images/wireframe/image.png" ] [] ]
        , configSections = []
        }
    ]
