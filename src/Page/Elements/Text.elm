module Page.Elements.Text exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html, p, text)
import Shared exposing (Shared)
import UI.Example exposing (example)
import UI.Segment exposing (segment)
import UI.Text exposing (..)


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
view { shared } =
    let
        options =
            { inverted = shared.darkMode }
    in
    [ example
        { title = "Text"
        , description = "A text is always used inline and uses one color from the FUI color palette"
        }
        [ segment options
            []
            [ text "This is "
            , redText options "red"
            , text " inline text and this is "
            , blueText options "blue"
            , text " inline text and this is "
            , purpleText options "purple"
            , text " inline text"
            ]
        , segment options
            []
            [ text "This is "
            , infoText "info"
            , text " inline text and this is "
            , successText "success"
            , text " inline text and this is "
            , warningText "warning"
            , text " inline text and this is "
            , errorText "error"
            , text " inline text"
            ]
        ]
    , example
        { title = "Size"
        , description = "Text can vary in the same sizes as icons"
        }
        [ segment options
            []
            [ p [] [ text "Starting with ", miniText "mini", text " text" ]
            , p [] [ text "which turns into ", tinyText "tiny", text " text" ]
            , p [] [ text "changing to ", smallText "small", text " text until it is" ]
            , p [] [ text "the default ", mediumText "medium", text " text" ]
            , p [] [ text "and could be ", largeText "large", text " text" ]
            , p [] [ text "to turn into ", bigText "big", text " text" ]
            , p [] [ text "then growing to ", hugeText "huge", text " text" ]
            , p [] [ text "to finally become ", massiveText "massive", text " text" ]
            ]
        ]
    ]
