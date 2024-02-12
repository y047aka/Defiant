module Page.Element.Text exposing (Model, Msg, init, update, view)

import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, p, text)
import Playground exposing (playground)
import Control
import Shared
import Types exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import UI.Header as Header
import UI.Text exposing (..)



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
    = UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            updater model



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
    [ Header.header options [] [ text "Text" ]
    , playground
        { theme = theme
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
        , configSections =
            [ { label = ""
              , configs =
                    [ Control.field "Inverted"
                        (Control.bool
                            { id = "inverted"
                            , value = model.inverted
                            , onClick = (\ps -> { ps | inverted = not ps.inverted }) |> UpdateConfig
                            }
                        )
                    ]
              }
            ]
        }
    , Header.header options [] [ text "Size" ]
    , playground
        { theme = theme
        , inverted = False
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
                    [ Control.select
                        { value = sizeToString model.size
                        , options = List.map sizeToString [ Massive, Huge, Big, Large, Medium, Small, Tiny, Mini ]
                        , onChange =
                            (\size ps ->
                                sizeFromString size
                                    |> Maybe.map (\s -> { ps | size = s })
                                    |> Maybe.withDefault ps
                            )
                                >> UpdateConfig
                        }
                    , Control.comment "Text can vary in the same sizes as icons"
                    ]
              }
            ]
        }
    ]
