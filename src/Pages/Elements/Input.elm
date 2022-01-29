module Pages.Elements.Input exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes exposing (placeholder, type_)
import Shared exposing (Shared)
import UI.Example exposing (example)
import UI.Input as Input


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
        { title = "Input"
        , description = "A standard input"
        }
        [ Input.input []
            [ input [ type_ "text", placeholder "Search..." ] [] ]
        ]
    , example
        { title = "Labeled"
        , description = "An input can be formatted with a label"
        }
        [ Input.input []
            [ Input.label [] [ text "http://" ]
            , input [ type_ "text", placeholder "mysite.com" ] []
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Input.input []
            [ input [ type_ "text", placeholder "Enter weight.." ] []
            , Input.label [] [ text "kg" ]
            ]
        ]
    ]
