module Page.Modules.Tab exposing
    ( Architecture, architecture
    , Model, Msg
    )

{-|

@docs Architecture, architecture
@docs Model, Msg

-}

import Html.Styled as Html exposing (Html)
import Shared exposing (Shared)
import UI.Example exposing (example, wireframeParagraph)
import UI.Tab exposing (State(..), tab)


type alias Architecture =
    { init : Shared -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }


architecture : Architecture
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
        { title = "Tab"
        , description = "A basic tab"
        }
        [ tab { state = Inactive }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    , example
        { title = "Active"
        , description = "A tab can be activated, and visible on the page"
        }
        [ tab { state = Active }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    , example
        { title = "Loading"
        , description = "A tab can display a loading indicator"
        }
        [ tab { state = Loading }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    ]
