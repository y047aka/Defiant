module Pages.Top exposing (Model, Msg, init, update, view)

import Data.PageSummary as PageSummary exposing (categoryToString)
import Html.Styled exposing (Html, a, text)
import Html.Styled.Attributes exposing (href)
import Shared
import UI.Card as Card exposing (card, cards)
import UI.Header as Header
import UI.Segment exposing (basicSegment)
import Url.Builder



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
        item { title, description, route } =
            card shared
                []
                [ a [ href (Url.Builder.absolute route []) ]
                    [ Card.content shared
                        []
                        { header = [ text title ]
                        , meta = []
                        , description = [ text description ]
                        }
                    ]
                ]
    in
    List.map
        (\( category, pages ) ->
            basicSegment shared
                []
                [ Header.header shared [] [ text (categoryToString category) ]
                , cards [] (List.map item pages)
                ]
        )
        PageSummary.summariesByCagetgory
