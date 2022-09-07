module Pages.Layout.Rail exposing (page)

import Css exposing (..)
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (css)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example, wireframeParagraph)
import UI.Rail exposing (leftRail, rightRail)
import UI.Segment exposing (segment)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Rail"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
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
