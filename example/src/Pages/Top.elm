module Pages.Top exposing (Model, Msg, init, update, view)

import Data.PageSummary as PageSummary exposing (categoryToString)
import Data.Theme exposing (Theme)
import Html.Styled exposing (Html, a, text)
import Html.Styled.Attributes exposing (href)
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


view : { theme : Theme } -> List (Html msg)
view options =
    let
        item { title, description, route } =
            card options
                []
                [ a [ href (Url.Builder.absolute route []) ]
                    [ Card.content options
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
            basicSegment options
                []
                [ Header.header options [] [ text (categoryToString category) ]
                , cards [] (List.map item pages)
                ]
        )
        PageSummary.summariesByCagetgory
