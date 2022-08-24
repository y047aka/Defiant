module Pages.Elements.Text exposing (Model, Msg, page)

import Data exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import Html.Styled as Html exposing (Html, option, p, select, text)
import Html.Styled.Attributes exposing (selected, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
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
    = ChangeSize Size


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeSize size ->
            { model | size = size }



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    let
        options =
            { theme = theme }
    in
    [ configAndPreview
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
        , configs = []
        }
    , configAndPreview
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
        , configs =
            [ { label = "Size"
              , fields =
                    [ { label = ""
                      , description = "Text can vary in the same sizes as icons"
                      , content =
                            select [ onInput (sizeFromString >> Maybe.withDefault model.size >> ChangeSize) ] <|
                                List.map (\size -> option [ value (sizeToString size), selected (model.size == size) ] [ text (sizeToString size) ])
                                    [ Massive, Huge, Big, Large, Medium, Small, Tiny, Mini ]
                      }
                    ]
              }
            ]
        }
    ]
