module Pages.Elements.Divider exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html)
import Shared exposing (Shared)
import UI.Divider exposing (divider)
import UI.Example exposing (example, wireframeShortParagraph)


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
        { title = "Divider"
        , description = "A standard divider"
        }
        [ wireframeShortParagraph
        , divider [] []
        , wireframeShortParagraph
        ]
    ]
