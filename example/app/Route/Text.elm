module Route.Text exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Control
import Effect exposing (Effect)
import FatalError
import Headless.Text exposing (TextAs(..), TextProps, text)
import Html.Styled as Html exposing (Html)
import PagesMsg
import Playground exposing (Node(..), playground)
import RouteBuilder
import Shared
import View


type alias RouteParams =
    {}


route : RouteBuilder.StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single
        { data = data, head = \_ -> [] }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = \_ _ _ _ -> Sub.none
            }



-- MODEL


type alias Model =
    TextProps


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect Msg )
init app shared =
    ( Headless.Text.defaultTextProps, Effect.none )



-- UPDATE


type Msg
    = UpdateTextProps (TextProps -> TextProps)


update :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect Msg )
update app shared msg model =
    case msg of
        UpdateTextProps updater ->
            ( updater model, Effect.none )



-- DATA


type alias Data =
    {}


type alias ActionData =
    BackendTask.BackendTask FatalError.FatalError (List RouteParams)


data : BackendTask.BackendTask FatalError.FatalError Data
data =
    BackendTask.succeed {}



-- VIEW


view :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View.View (PagesMsg.PagesMsg Msg)
view app shared model =
    { title = "Text"
    , body =
        List.map (Html.map PagesMsg.fromMsg)
            [ textPlayground False model ]
    }


textPlayground : Bool -> TextProps -> Html Msg
textPlayground isDarkMode state =
    playground
        { isDarkMode = isDarkMode
        , toMsg = UpdateTextProps
        , preview = text state "Hello, World!"
        , controlSections =
            [ { heading = "Typography"
              , controls =
                    [ Field "textAs"
                        (Control.select
                            { value = textAsToString state.textAs
                            , options = List.map textAsToString [ Span, Div, Label, P ]
                            , onChange =
                                \textAs state_ ->
                                    textAsFromString textAs
                                        |> Maybe.map (\textAs_ -> { state_ | textAs = textAs_ })
                                        |> Maybe.withDefault state_
                            }
                        )
                    ]
              }
            ]
        }


textAsToString : TextAs -> String
textAsToString textAs =
    case textAs of
        Span ->
            "span"

        Div ->
            "div"

        Label ->
            "label"

        P ->
            "p"


textAsFromString : String -> Maybe TextAs
textAsFromString string =
    case string of
        "span" ->
            Just Span

        "div" ->
            Just Div

        "label" ->
            Just Label

        "p" ->
            Just P

        _ ->
            Nothing
