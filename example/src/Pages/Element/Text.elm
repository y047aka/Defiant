module Pages.Element.Text exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, p, text)
import Page
import Request exposing (Request)
import Shared
import Types exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import UI.Segment exposing (segment)
import UI.Text exposing (..)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Text"
                , body = view shared model
                }
        }



-- INIT


type alias Model =
    { size : Size }


init : Model
init =
    { size = Medium }



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
            { theme = theme }
    in
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Text"
        , preview =
            [ segment options
                []
                [ text "This is "
                , redText options "red"
                , text " inline text and this is "
                , blueText options "blue"
                , text " inline text and this is "
                , purpleText options "purple"
                , text " inline text"
                ]
            , segment options
                []
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
            [ segment options
                []
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
