module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import BackendTask exposing (BackendTask)
import Css exposing (..)
import Css.Extra exposing (marginInline)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Styled exposing (header, main_, text)
import Html.Styled.Attributes exposing (css, href)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import UI.Breadcrumb as Breadcrumb
import UrlPath exposing (UrlPath)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Nothing
    }


type Msg
    = SharedMsg SharedMsg


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    {}


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( {}, Effect.none )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SharedMsg globalMsg ->
            ( model, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view sharedData page model toMsg pageView =
    { body =
        List.map Html.Styled.toUnstyled
            [ header []
                [ Breadcrumb.breadcrumbList []
                    [ Breadcrumb.breadcrumbItem { current = False } [ href "/" ] [ text "Top" ]
                    , Breadcrumb.breadcrumbItem { current = False } [ href "#" ] [ text "UI" ]
                    , Breadcrumb.breadcrumbItem { current = True } [ href "#" ] [ text "Breadcrumb" ]
                    ]
                ]
            , main_ [ css [ maxWidth (em 50), marginInline auto ] ]
                pageView.body
            ]
    , title = pageView.title
    }
