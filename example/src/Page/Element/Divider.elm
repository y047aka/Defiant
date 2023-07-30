module Page.Element.Divider exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import UI.Divider exposing (divider)
import UI.Example exposing (wireframeShortParagraph)
import UI.Header as Header



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
    [ Header.header { theme = theme } [] [ text "Divider" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ wireframeShortParagraph
            , divider [] []
            , wireframeShortParagraph
            ]
        , configSections = []
        }
    ]
