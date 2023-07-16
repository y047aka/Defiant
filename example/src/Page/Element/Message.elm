module Page.Element.Message exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, div, p, text)
import Playground exposing (playground)
import Shared
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Message exposing (message)



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type alias Msg =
    ()


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
    [ playground
        { title = "Message"
        , theme = shared.theme
        , inverted = False
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
    , playground
        { title = "Icon Message"
        , theme = shared.theme
        , inverted = False
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
