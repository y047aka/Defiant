module Shared exposing (Flags, Model, Msg(..), init, subscriptions, update)

import Json.Decode as Json
import Request exposing (Request)


type alias Flags =
    Json.Value


type alias Model =
    { darkMode : Bool }


type Msg
    = ToggleDarkMode


init : Request -> Flags -> ( Model, Cmd Msg )
init _ _ =
    ( { darkMode = False }, Cmd.none )


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        ToggleDarkMode ->
            ( { model | darkMode = not model.darkMode }
            , Cmd.none
            )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
