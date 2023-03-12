module Pages.Element.Message exposing (Model, Msg, page)

import Effect
import Html.Styled as Html exposing (Html, div, p, text)
import Layouts exposing (Layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Message exposing (message)
import View.ConfigAndPreview exposing (configAndPreview)


layout : Model -> Layout
layout model =
    Layouts.Default { default = () }


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Message"
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
    let
        options =
            { theme = shared.theme }
    in
    [ configAndPreview
        { title = "Message"
        , theme = shared.theme
        , inverted = False
        , preview =
            [ message []
                [ div []
                    [ Header.header options [] [ text "Changes in Service" ]
                    , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                    ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview
        { title = "Icon Message"
        , theme = shared.theme
        , inverted = False
        , preview =
            [ message []
                [ icon [] "fas fa-inbox"
                , div []
                    [ Header.header options [] [ text "Have you heard about our mailing list?" ]
                    , p [] [ text "Get the best news in your e-mail every day." ]
                    ]
                ]
            ]
        , configSections = []
        }
    ]
