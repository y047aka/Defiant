module Page.Elements.Loader exposing (Model, Msg, architecture)

import Html.Styled as Html exposing (Html, text)
import Shared exposing (Shared)
import UI.Dimmer exposing (dimmer)
import UI.Example exposing (example, wireframeShortParagraph)
import UI.Loader exposing (loader, textLoader)
import UI.Segment exposing (segment)


architecture :
    { init : Shared -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }
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
        inverted =
            shared.darkMode
    in
    [ example
        { title = "Loader"
        , description = "A loader"
        }
        [ segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = False }
                []
                [ loader { inverted = False } [] [] ]
            ]
        ]
    , example
        { title = "Text Loader"
        , description = "A loader can contain text"
        }
        [ segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = False }
                []
                [ textLoader { inverted = False } [] [ text "Loading" ] ]
            ]
        , segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = True }
                []
                [ textLoader { inverted = True } [] [ text "Loading" ] ]
            ]
        ]
    ]
