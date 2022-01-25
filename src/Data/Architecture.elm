module Data.Architecture exposing (Architecture)

import Html.Styled exposing (Html)
import Shared exposing (Shared)


type alias Architecture model msg =
    { init : Shared -> ( { model | shared : Shared }, Cmd msg )
    , update : msg -> { model | shared : Shared } -> ( { model | shared : Shared }, Cmd msg )
    , view : { model | shared : Shared } -> List (Html msg)
    }
