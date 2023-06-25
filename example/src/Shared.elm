module Shared exposing
    ( Model, Msg(..)
    , init, update, subscriptions
    )

{-|

@docs Model, Msg
@docs init, update, subscriptions

-}

import Data.Theme exposing (Theme(..))



-- INIT


type alias Model =
    { theme : Theme }


init : Model
init =
    { theme = System }



-- UPDATE


type Msg
    = ChangeTheme Theme


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeTheme theme ->
            { model | theme = theme }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
