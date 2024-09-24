module Route.Button exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Effect exposing (Effect)
import FatalError
import Html.Styled as Html exposing (Html, text)
import PagesMsg
import Playground exposing (Node(..), playground)
import Route exposing (Route(..))
import RouteBuilder
import Shared
import UI.Button as Button exposing (IconPosition(..), Layout(..), Size(..), Variant(..))
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
    Button.Props Msg


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect Msg )
init app shared =
    ( { layout = Intrinsic
      , size = Large
      , variant = Contained
      , icon = Nothing
      , iconPosition = Start
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = UpdateButtonProps (Button.Props Msg -> Button.Props Msg)


update :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect Msg )
update app shared msg model =
    case msg of
        UpdateButtonProps updater ->
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
    { title = "Button"
    , body =
        List.map (Html.map PagesMsg.fromMsg)
            [ buttonPlayground False model ]
    }


buttonPlayground : Bool -> Button.Props Msg -> Html Msg
buttonPlayground isDarkMode props =
    playground
        { isDarkMode = isDarkMode
        , toMsg = UpdateButtonProps
        , preview = Button.button props [ text "Button" ]
        , controlSections =
            []
        }
