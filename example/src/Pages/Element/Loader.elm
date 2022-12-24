module Pages.Element.Loader exposing (Model, Msg, page)

import Components.Default exposing (layout)
import Config
import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Dimmer exposing (dimmer)
import UI.Example exposing (wireframeShortParagraph)
import UI.Loader exposing (loader, textLoader)
import UI.Segment exposing (segment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Loader"
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
view shared =
    [ configAndPreview UpdateConfig { theme = shared.theme, inverted = False } <|
        { title = "Loader"
        , preview =
            [ segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Light }
                    []
                    [ loader { theme = Light } [] [] ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = shared.theme, inverted = False } <|
        { title = "Text Loader"
        , preview =
            [ segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Light }
                    []
                    [ textLoader { theme = Light } [] [ text "Loading" ] ]
                ]
            , segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Dark }
                    []
                    [ textLoader { theme = Dark } [] [ text "Loading" ] ]
                ]
            ]
        , configSections = []
        }
    ]
