module Pages.Home_ exposing (Model, Msg, page)

import Components.Default exposing (layout)
import Data.PageSummary as PageSummary exposing (categoryToString)
import Data.Theme exposing (Theme)
import Effect
import Html.Styled as Html exposing (Html, a, text)
import Html.Styled.Attributes exposing (href)
import Page exposing (Page)
import Route exposing (Route)
import Route.Path as Path
import Shared
import UI.Card as Card exposing (card, cards)
import UI.Header as Header
import UI.Segment exposing (basicSegment)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \_ model -> ( model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Homepage"
                , body = view { theme = shared.theme }
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


view : { theme : Theme } -> List (Html msg)
view options =
    let
        item { title, description, path } =
            card options
                []
                [ a [ href (Path.toString path) ]
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
