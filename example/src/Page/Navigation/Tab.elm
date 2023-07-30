module Page.Navigation.Tab exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import UI.Example exposing (wireframeParagraph)
import UI.Header as Header
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
    [ Header.header { theme = theme } [] [ text "Tab" ]
    , playground
        { theme = theme
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
    , Header.header { theme = theme } [] [ text "Active" ]
    , playground
        { theme = theme
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
    , Header.header { theme = theme } [] [ text "Loading" ]
    , playground
        { theme = theme
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
