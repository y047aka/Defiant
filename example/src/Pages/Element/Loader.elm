module Pages.Element.Loader exposing (Model, Msg, page)

import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html, text)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Dimmer exposing (dimmer)
import UI.Example exposing (wireframeShortParagraph)
import UI.Loader exposing (loader, textLoader)
import UI.Segment exposing (segment)


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
                { title = "Loader"
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
view shared =
    [ playground
        { title = "Loader"
        , theme = shared.theme
        , inverted = False
        , preview =
            [ segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Light }
                    []
                    [ loader { theme = Light } [] [] ]
                ]
            ]
        , configSections = []
        }
    , playground
        { title = "Text Loader"
        , theme = shared.theme
        , inverted = False
        , preview =
            [ segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Light }
                    []
                    [ textLoader { theme = Light } [] [ text "Loading" ] ]
                ]
            , segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Dark }
                    []
                    [ textLoader { theme = Dark } [] [ text "Loading" ] ]
                ]
            ]
        , configSections = []
        }
    ]
