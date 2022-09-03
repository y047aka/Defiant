module Pages.Elements.Loader exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, text)
import Page
import Request exposing (Request)
import Shared
import UI.Dimmer exposing (dimmer)
import UI.Example exposing (wireframeShortParagraph)
import UI.Loader exposing (loader, textLoader)
import UI.Segment exposing (segment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Loader"
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
view shared =
    [ configAndPreview UpdateConfig
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
    , configAndPreview UpdateConfig
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