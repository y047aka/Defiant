module Pages.Navigation.Tab exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html)
import Playground exposing (playground)
import Shared
import UI.Example exposing (wireframeParagraph)
import UI.Tab exposing (State(..), tab)



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type alias Msg =
    ()


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ playground
        { title = "Tab"
        , theme = theme
        , inverted = False
        , preview =
            [ tab { state = Inactive }
                []
                [ wireframeParagraph
                , wireframeParagraph
                ]
            ]
        , configSections = []
        }
    , playground
        { title = "Active"
        , theme = theme
        , inverted = False
        , preview =
            [ tab { state = Active }
                []
                [ wireframeParagraph
                , wireframeParagraph
                ]
            ]
        , configSections = []
        }
    , playground
        { title = "Loading"
        , theme = theme
        , inverted = False
        , preview =
            [ tab { state = Loading }
                []
                [ wireframeParagraph
                , wireframeParagraph
                ]
            ]
        , configSections = []
        }
    ]
