module Pages.Form.Input exposing (Model, Msg, page)

import Effect
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes exposing (placeholder, type_)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Input as Input


layout : Model -> Layout msg
layout model =
    Layouts.Default {}


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
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ playground
        { title = "Input"
        , theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Search..." ] [] ]
            ]
        , configSections = []
        }
    , playground
        { title = "Labeled"
        , theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ Input.label [] [ text "http://" ]
                , input [ type_ "text", placeholder "mysite.com" ] []
                ]
            ]
        , configSections = []
        }
    , playground
        { title = ""
        , theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Enter weight.." ] []
                , Input.label [] [ text "kg" ]
                ]
            ]
        , configSections = []
        }
    ]
