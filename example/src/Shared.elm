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

import Data.Theme as Theme exposing (Theme(..))
import Effect exposing (Effect)
import Html.Styled exposing (Html, option, select, text)
import Html.Styled.Attributes exposing (selected, value)
import Html.Styled.Events exposing (onInput)
import Json.Decode
import Route exposing (Route)
import Route.Path
import Shared.Model
import Shared.Msg



-- FLAGS


type alias Flags =
    {}


decoder : Json.Decode.Decoder Flags
decoder =
    Json.Decode.succeed {}



-- INIT


type alias Model =
    Shared.Model.Model


init : Result Json.Decode.Error Flags -> Route () -> ( Model, Effect Msg )
init flagsResult route =
    ( { theme = System }
    , Effect.none
    )



-- UPDATE


type alias Msg =
    Shared.Msg.Msg


update : Route () -> Msg -> Model -> ( Model, Effect Msg )
update route msg model =
    case msg of
        Shared.Msg.ChangeTheme theme ->
            ( { model | theme = theme }
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Route () -> Model -> Sub Msg
subscriptions route model =
    Sub.none



-- VIEW


themeSelector : Model -> List (Html Msg)
themeSelector shared =
    [ select [ onInput (Theme.fromString >> Maybe.withDefault shared.theme >> (\theme -> Shared.Msg.ChangeTheme theme)) ] <|
        List.map (\theme -> option [ value (Theme.toString theme), selected (shared.theme == theme) ] [ text (Theme.toString theme) ])
            [ System, Light, Dark ]
    ]
