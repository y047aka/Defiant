module Pages.Home_ exposing (page)

import Data.PageSummary as PageSummary exposing (categoryToString)
import Data.Theme exposing (Theme)
import Gen.Route as Route
import Html.Styled as Html exposing (Html, a, text)
import Html.Styled.Attributes exposing (href)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Card as Card exposing (card, cards)
import UI.Header as Header
import UI.Segment exposing (basicSegment)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Homepage"
            , body = view { theme = shared.theme }
            }
        }


view : { theme : Theme } -> List (Html msg)
view options =
    let
        item { title, description, route } =
            card options
                []
                [ a [ href (Route.toHref route) ]
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
