module Pages.Elements.Text exposing (Model, Msg, page)

import Data exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import Html.Styled as Html exposing (Html, div, option, p, select, text)
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
    Page.element
        { init = init shared
        , update = update
        , view =
            \model ->
                { title = "Text"
                , body = view model
                }
        , subscriptions = \_ -> Sub.none
        }



-- INIT


type alias Model =
    { shared : Shared.Model
    , size : Size
    }


init : Shared.Model -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared
      , size = Medium
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = ChangeSize Size


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeSize size ->
            ( { model | size = size }, Cmd.none )


view : Model -> List (Html Msg)
view model =
    let
        options =
            { theme = model.shared.theme }
    in
    [ configAndPreview { title = "Text" }
        (div []
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
        )
        []
    , configAndPreview { title = "Size" }
        (segment options
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
        )
        [ { label = "States"
          , description = "Text can vary in the same sizes as icons"
          , content =
                select [ onInput (sizeFromString >> Maybe.withDefault model.size >> ChangeSize) ] <|
                    List.map (\state -> option [ value (sizeToString state), selected (model.size == state) ] [ text (sizeToString state) ])
                        [ Massive, Huge, Big, Large, Medium, Small, Tiny, Mini ]
          }
        ]
    ]
