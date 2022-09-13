module Pages.Form.Input exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes exposing (placeholder, type_)
import Page
import Request exposing (Request)
import Shared
import UI.Input as Input
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Input"
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
        { title = "Input"
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Search..." ] [] ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme } <|
        { title = "Labeled"
        , preview =
            [ Input.input []
                [ Input.label [] [ text "http://" ]
                , input [ type_ "text", placeholder "mysite.com" ] []
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme } <|
        { title = ""
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Enter weight.." ] []
                , Input.label [] [ text "kg" ]
                ]
            ]
        , configSections = []
        }
    ]