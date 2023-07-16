module Page.Element.Divider exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html)
import Playground exposing (playground)
import Shared
import UI.Divider exposing (divider)
import UI.Example exposing (wireframeShortParagraph)



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
        { title = "Divider"
        , theme = theme
        , inverted = False
        , preview =
            [ wireframeShortParagraph
            , divider [] []
            , wireframeShortParagraph
            ]
        , configSections = []
        }
    ]
