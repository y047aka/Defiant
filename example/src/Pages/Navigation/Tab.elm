module Pages.Navigation.Tab exposing (Model, Msg, page)

import Config
import Effect
import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Example exposing (wireframeParagraph)
import UI.Tab exposing (State(..), tab)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Tab"
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
        { title = "Tab"
        , preview =
            [ tab { state = Inactive }
                []
                [ wireframeParagraph
                , wireframeParagraph
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Active"
        , preview =
            [ tab { state = Active }
                []
                [ wireframeParagraph
                , wireframeParagraph
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Loading"
        , preview =
            [ tab { state = Loading }
                []
                [ wireframeParagraph
                , wireframeParagraph
                ]
            ]
        , configSections = []
        }
    ]
