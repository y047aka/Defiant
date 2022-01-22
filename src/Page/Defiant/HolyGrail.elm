module Page.Defiant.HolyGrail exposing (Model, Msg, architecture)

import Html.Styled as Html exposing (Html, text)
import Shared exposing (Shared)
import UI.Example exposing (example, wireframeParagraph)
import UI.HolyGrail exposing (holyGrail)


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


view : Model -> List (Html Msg)
view =
    \_ ->
        [ example
            { title = "Holy grail"
            , description = "Holy grail layout"
            }
            [ holyGrail
                { header = [ text "header" ]
                , main = [ wireframeParagraph ]
                , aside_left = [ text "aside" ]
                , aside_right = [ text "aside" ]
                , footer = [ text "footer" ]
                }
            ]
        ]