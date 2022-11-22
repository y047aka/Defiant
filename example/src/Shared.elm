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



-- VIEW


themeSelector : Model -> List (Html Msg)
themeSelector shared =
    [ select [ onInput (Theme.fromString >> Maybe.withDefault shared.theme >> (\theme -> ChangeTheme theme)) ] <|
        List.map (\theme -> option [ value (Theme.toString theme), selected (shared.theme == theme) ] [ text (Theme.toString theme) ])
            [ System, Light, Dark ]
    ]
