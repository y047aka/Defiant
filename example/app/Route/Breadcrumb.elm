module Route.Breadcrumb exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Effect
import FatalError
import Head
import Headless.Text exposing (TextProps)
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (href)
import PagesMsg
import Playground exposing (Node(..), playground)
import RouteBuilder
import Shared
import UI.Breadcrumb as Breadcrumb
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
    { title = "Breadcrumb"
    , body =
        List.map (Html.map PagesMsg.fromMsg >> Html.toUnstyled)
            [ breadcrumbPlayground False model ]
    }


breadcrumbPlayground : Bool -> TextProps -> Html Msg
breadcrumbPlayground isDarkMode state =
    playground
        { isDarkMode = isDarkMode
        , toMsg = UpdateTextProps
        , preview =
            Breadcrumb.breadcrumbList []
                [ Breadcrumb.breadcrumbItem { current = False } [ href "/" ] [ text "Top" ]
                , Breadcrumb.breadcrumbItem { current = False } [ href "#" ] [ text "UI" ]
                , Breadcrumb.breadcrumbItem { current = True } [ href "#" ] [ text "Breadcrumb" ]
                ]
        , controlSections =
            []
        }
