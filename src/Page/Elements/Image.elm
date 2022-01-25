module Page.Elements.Image exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (src)
import Shared exposing (Shared)
import UI.Example exposing (example)
import UI.Image exposing (smallImage)


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
        { title = "Image"
        , description = "An image"
        }
        [ smallImage [ src "./static/images/wireframe/image.png" ] [] ]
    ]
