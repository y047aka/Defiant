module Pages.Elements.Placeholder exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html)
import Shared exposing (Shared)
import UI.Example exposing (example)
import UI.Placeholder as Placeholder exposing (line)


architecture : Architecture Model Msg
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
view _ =
    [ example
        { title = "Lines"
        , description = "A placeholder can contain have lines of text"
        }
        [ Placeholder.placeholder []
            [ line [] []
            , line [] []
            , line [] []
            , line [] []
            , line [] []
            ]
        ]
    ]
