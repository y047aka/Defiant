module Page.Layout.Rail exposing (Model, Msg, init, update, view)

import Css exposing (..)
import Html.Styled exposing (Html, text)
import Html.Styled.Attributes exposing (css)
import Shared
import UI.Example exposing (example, wireframeParagraph)
import UI.Rail exposing (leftRail, rightRail)
import UI.Segment exposing (segment)



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


view : Shared.Model -> List (Html msg)
view shared =
    let
        options =
            { theme = shared.theme }
    in
    [ example
        { title = "Rail"
        , description = "A rail can be presented on the left or right side of a container"
        }
        [ segment options
            [ css [ width (pct 45), left (pct 27.5) ] ]
            [ leftRail []
                [ segment options [] [ text "Left Rail Content" ] ]
            , rightRail []
                [ segment options [] [ text "Right Rail Content" ] ]
            , wireframeParagraph
            , wireframeParagraph
            ]
        ]
    ]
