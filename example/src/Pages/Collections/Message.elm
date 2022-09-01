module Pages.Collections.Message exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, div, p, text)
import Page
import Request exposing (Request)
import Shared
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Message exposing (message)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Message"
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
    let
        options =
            { theme = shared.theme }
    in
    [ configAndPreview UpdateConfig
        { title = "Message"
        , preview =
            [ message []
                [ div []
                    [ Header.header options [] [ text "Changes in Service" ]
                    , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                    ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig
        { title = "Icon Message"
        , preview =
            [ message []
                [ icon [] "fas fa-inbox"
                , div []
                    [ Header.header options [] [ text "Have you heard about our mailing list?" ]
                    , p [] [ text "Get the best news in your e-mail every day." ]
                    ]
                ]
            ]
        , configSections = []
        }
    ]
