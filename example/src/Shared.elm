module Shared exposing
    ( Flags, decoder
    , Model, Msg
    , init, update, subscriptions
    )

{-|

@docs Flags, decoder
@docs Model, Msg
@docs init, update, subscriptions

-}

import Data.Theme exposing (Theme(..))
import Effect exposing (Effect)
import Json.Decode
import Route exposing (Route)
import Route.Path



-- FLAGS


type alias Flags =
    {}


decoder : Json.Decode.Decoder Flags
decoder =
    Json.Decode.succeed {}



-- INIT


type alias Model =
    { theme : Theme }


init : Result Json.Decode.Error Flags -> Route () -> ( Model, Effect Msg )
init flagsResult route =
    ( { theme = System }
    , Effect.none
    )



-- UPDATE


type Msg
    = ChangeTheme Theme


update : Route () -> Msg -> Model -> ( Model, Effect Msg )
update route msg model =
    case msg of
        ChangeTheme theme ->
            ( { model | theme = theme }
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Route () -> Model -> Sub Msg
subscriptions route model =
    Sub.none
