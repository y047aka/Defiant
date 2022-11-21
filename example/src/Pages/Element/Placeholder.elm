module Pages.Element.Placeholder exposing (Model, Msg, page)

import Config
import Effect
import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Placeholder as Placeholder exposing (line)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
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
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
