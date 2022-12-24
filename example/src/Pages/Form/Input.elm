module Pages.Form.Input exposing (Model, Msg, page)

import Components.Default exposing (layout)
import Config
import Effect
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes exposing (placeholder, type_)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Input as Input
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Input"
                , body = view shared
                }
                    |> layout shared route
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
        { title = "Input"
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Search..." ] [] ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Labeled"
        , preview =
            [ Input.input []
                [ Input.label [] [ text "http://" ]
                , input [ type_ "text", placeholder "mysite.com" ] []
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
