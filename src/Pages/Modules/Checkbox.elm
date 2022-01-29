module Pages.Modules.Checkbox exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (for, id, type_)
import Shared exposing (Shared)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Example exposing (example)


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
        { title = "Checkbox"
        , description = "A checkbox allows a user to select a value from a small set of options, often binary"
        }
        [ checkbox []
            [ Checkbox.input [ id "checkbox_example", type_ "checkbox" ] []
            , Checkbox.label [ for "checkbox_example" ] [ text "Make my profile visible" ]
            ]
        ]
    ]
