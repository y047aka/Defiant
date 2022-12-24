module Pages.Layout.Rail exposing (Model, Msg, page)

import Components.Default exposing (layout)
import Css exposing (..)
import Effect
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (css)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Example exposing (example, wireframeParagraph)
import UI.Rail exposing (leftRail, rightRail)
import UI.Segment exposing (segment)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \_ model -> ( model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Rail"
                , body = view shared
                }
                    |> layout shared route
        }



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = NoOp



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
