module Page.Element.Placeholder exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import UI.Header as Header
import UI.Placeholder as Placeholder exposing (line)



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
    [ Header.header { theme = theme } [] [ text "Lines" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ Placeholder.placeholder []
                [ line [] []
                , line [] []
                , line [] []
                , line [] []
                , line [] []
                ]
            ]
        , configSections = []
        }
    ]
