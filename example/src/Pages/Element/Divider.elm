module Pages.Element.Divider exposing (Model, Msg, page)

import Effect
import Html.Styled as Html exposing (Html)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Divider exposing (divider)
import UI.Example exposing (wireframeShortParagraph)


layout : Model -> Layout msg
layout model =
    Layouts.Default {}


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Divider"
                , body = view shared
                }
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ playground
        { title = "Divider"
        , theme = theme
        , inverted = False
        , preview =
            [ wireframeShortParagraph
            , divider [] []
            , wireframeShortParagraph
            ]
        , configSections = []
        }
    ]
