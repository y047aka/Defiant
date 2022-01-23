module Page.Collections.Message exposing (Model, Msg, architecture)

import Html.Styled as Html exposing (Html, div, p, text)
import Shared exposing (Shared)
import UI.Example exposing (example)
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Message exposing (message)


architecture :
    { init : Shared -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }
architecture =
    { init = init
    , update = update
    , view = view
    }


type alias Model =
    { shared : Shared }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared }, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> List (Html msg)
view { shared } =
    let
        options =
            { inverted = shared.darkMode }
    in
    [ example
        { title = "Message"
        , description = "A basic message"
        }
        [ message []
            [ div []
                [ Header.header options [] [ text "Changes in Service" ]
                , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                ]
            ]
        ]
    , example
        { title = "Icon Message"
        , description = "A message can contain an icon."
        }
        [ message []
            [ icon [] "fas fa-inbox"
            , div []
                [ Header.header options [] [ text "Have you heard about our mailing list?" ]
                , p [] [ text "Get the best news in your e-mail every day." ]
                ]
            ]
        ]
    ]
