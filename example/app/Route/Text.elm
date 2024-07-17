module Route.Text exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Control
import Effect
import FatalError
import Head
import Headless.Text exposing (TextAs(..), TextProps, text)
import Html.Styled as Html exposing (Html)
import PagesMsg
import Playground exposing (Node(..), playground)
import RouteBuilder
import Shared
import UrlPath
import View


type alias Model =
    TextProps


type Msg
    = UpdateTextProps (TextProps -> TextProps)


type alias RouteParams =
    {}


route : RouteBuilder.StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single
        { data = data, head = head }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect.Effect Msg )
init app shared =
    ( Headless.Text.defaultTextProps, Effect.none )


update :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect.Effect Msg )
update app shared msg model =
    case msg of
        UpdateTextProps updater ->
            ( updater model, Effect.none )


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions routeParams path shared model =
    Sub.none


type alias Data =
    {}


type alias ActionData =
    BackendTask.BackendTask FatalError.FatalError (List RouteParams)


data : BackendTask.BackendTask FatalError.FatalError Data
data =
    BackendTask.succeed {}


head : RouteBuilder.App Data ActionData RouteParams -> List Head.Tag
head app =
    []


view :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View.View (PagesMsg.PagesMsg Msg)
view app shared model =
    { title = "Text"
    , body =
        List.map (Html.map PagesMsg.fromMsg >> Html.toUnstyled)
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
