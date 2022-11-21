module Pages.Element.Text exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html, p, text)
import Layouts.Default exposing (layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Types exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import UI.Text exposing (..)
import View.ConfigAndPreview exposing (configAndPreview)
import View.Playground exposing (playground)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Text"
                , body = view shared model
                }
                    |> layout shared route
        }



-- INIT


type alias Model =
    { inverted : Bool
    , size : Size
    }


init : Model
init =
    { inverted = False
    , size = Medium
    }



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    let
        options =
            { theme =
                if model.inverted then
                    Dark

                else
                    theme
            }
    in
    [ playground
        { title = "Text"
        , toMsg = UpdateConfig
        , theme = theme
        , inverted = model.inverted
        , preview =
            [ p []
                [ text "This is "
                , redText options "red"
                , text " inline text and this is "
                , blueText options "blue"
                , text " inline text and this is "
                , purpleText options "purple"
                , text " inline text"
                ]
            , p []
                [ text "This is "
                , infoText "info"
                , text " inline text and this is "
                , successText "success"
                , text " inline text and this is "
                , warningText "warning"
                , text " inline text and this is "
                , errorText "error"
                , text " inline text"
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Size"
        , preview =
            [ p [] <|
                case model.size of
                    Massive ->
                        [ text "to finally become ", massiveText "massive", text " text" ]

                    Huge ->
                        [ text "then growing to ", hugeText "huge", text " text" ]

                    Big ->
                        [ text "to turn into ", bigText "big", text " text" ]

                    Large ->
                        [ text "and could be ", largeText "large", text " text" ]

                    Medium ->
                        [ text "the default ", mediumText "medium", text " text" ]

                    Small ->
                        [ text "changing to ", smallText "small", text " text until it is" ]

                    Tiny ->
                        [ text "which turns into ", tinyText "tiny", text " text" ]

                    Mini ->
                        [ text "Starting with ", miniText "mini", text " text" ]
            ]
        , configSections =
            [ { label = "Size"
              , configs =
                    [ { label = ""
                      , config =
                            Config.select
                                { value = model.size
                                , options = [ Massive, Huge, Big, Large, Medium, Small, Tiny, Mini ]
                                , fromString = sizeFromString
                                , toString = sizeToString
                                , setter = \size m -> { m | size = size }
                                }
                      , note = "Text can vary in the same sizes as icons"
                      }
                    ]
              }
            ]
        }
    ]
