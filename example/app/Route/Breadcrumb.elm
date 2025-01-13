module Route.Breadcrumb exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Effect exposing (Effect)
import FatalError
import Headless.Text exposing (TextProps)
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (href)
import PagesMsg
import Playground exposing (Node(..), playground)
import RouteBuilder
import Shared
import UI.Breadcrumb as Breadcrumb
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
    { title = "Breadcrumb"
    , body =
        List.map (Html.map PagesMsg.fromMsg)
            [ breadcrumbPlayground False model ]
    }


breadcrumbPlayground : Bool -> TextProps -> Html Msg
breadcrumbPlayground isDarkMode state =
    playground
        { isDarkMode = isDarkMode
        , toMsg = UpdateTextProps
        , preview =
            Breadcrumb.breadcrumbList []
                [ Breadcrumb.breadcrumbItem { current = False } [ href "#" ] [ text "Top" ]
                , Breadcrumb.breadcrumbItem { current = False } [ href "#" ] [ text "UI" ]
                , Breadcrumb.breadcrumbItem { current = True } [ href "#" ] [ text "Breadcrumb" ]
                ]
        , controlSections =
            []
        }
