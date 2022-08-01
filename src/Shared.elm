module Shared exposing (Flags, Model, Msg(..), init, subscriptions, update)

import Data.Theme exposing (Theme(..))
import Json.Decode as Json
import Request exposing (Request)


type alias Flags =
    Json.Value


type alias Model =
    { darkMode : Bool
    , theme : Theme
    }


type Msg
    = ToggleDarkMode
    | ChangeTheme Theme


init : Request -> Flags -> ( Model, Cmd Msg )
init _ _ =
    ( { darkMode = False, theme = System }, Cmd.none )


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        ToggleDarkMode ->
            ( { model | darkMode = not model.darkMode }, Cmd.none )

        ChangeTheme theme ->
            ( { model | theme = theme }, Cmd.none )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
