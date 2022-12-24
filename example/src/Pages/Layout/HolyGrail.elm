module Pages.Layout.HolyGrail exposing (Model, Msg, page)

import Components.Default exposing (layout)
import Config
import Effect
import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Example exposing (wireframeParagraph)
import UI.HolyGrail exposing (holyGrail)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Holy Grail"
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
