module Pages.Modules.Progress exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (value)
import Page
import Random
import Request exposing (Request)
import Shared
import UI.Progress as Progress exposing (State(..))
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.element
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Progress"
                , body = view model
                }
        , subscriptions = \_ -> Sub.none
        }



-- INIT


type alias Model =
    { progressValue : Float
    , progressLabel : String
    , label : String
    , indicating : Bool
    , state : State
    }


init : ( Model, Cmd Msg )
init =
    ( { progressValue = 0
      , progressLabel = "%"
      , label = "Uploading Files"
      , indicating = False
      , state = Default
      }
    , Random.generate NewProgress (Random.int 10 50)
    )



-- UPDATE


type Msg
    = NewProgress Int
    | UpdateConfig (Config.Msg Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewProgress int ->
            let
                calculated =
                    model.progressValue + toFloat int

                newProgress =
                    if calculated > 100 then
                        100

                    else if calculated < 0 then
                        0

                    else
                        calculated
            in
            ( { model | progressValue = newProgress }
                |> updatelabelOnIndicating
            , Cmd.none
            )

        UpdateConfig configMsg ->
            case configMsg of
                Config.Update updater ->
                    ( updater model, Cmd.none )

                Config.CounterPlus ->
                    ( model, Random.generate NewProgress (Random.int 10 15) )

                Config.CounterMinus ->
                    ( model, Random.generate NewProgress (Random.int -15 -10) )


updatelabelOnIndicating : Model -> Model
updatelabelOnIndicating model =
    { model
        | label =
            case ( model.indicating, model.progressValue == 100 ) of
                ( True, True ) ->
                    "Project Funded!"

                ( True, False ) ->
                    String.fromFloat model.progressValue ++ "% Funded"

                ( False, _ ) ->
                    model.label
    }



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview UpdateConfig
        { title = "Progress"
        , preview =
            [ Progress.progressWithProps
                { value = model.progressValue
                , progress = String.fromFloat model.progressValue ++ model.progressLabel
                , label = model.label
                , indicating = model.indicating
                , state = model.state
                }
            ]
        , configSections =
            [ { label = "Bar"
              , configs =
                    [ { label = ""
                      , config =
                            Config.counter
                                { value = model.progressValue
                                , toString = \value -> String.fromFloat value ++ "%"
                                }
                      , note = "A progress element can contain a bar visually indicating progress"
                      }
                    ]
              }
            , { label = "Types"
              , configs =
                    [ { label = ""
                      , config =
                            Config.bool
                                { id = "indicating"
                                , label = "Indicating"
                                , bool = model.indicating
                                , setter =
                                    \m ->
                                        let
                                            newIndicating =
                                                not m.indicating
                                        in
                                        { m
                                            | indicating = newIndicating
                                            , label =
                                                if newIndicating then
                                                    m.label

                                                else
                                                    "Uploading Files"
                                        }
                                            |> updatelabelOnIndicating
                                }
                      , note = "An indicating progress bar visually indicates the current level of progress of a task"
                      }
                    ]
              }
            , { label = "States"
              , configs =
                    [ { label = ""
                      , config =
                            Config.select
                                { value = model.state
                                , options = [ Default, Active, Success, Warning, Error, Disabled ]
                                , fromString = Progress.stateFromString
                                , toString = Progress.stateToString
                                , setter =
                                    \state m ->
                                        { m
                                            | state = state
                                            , label =
                                                case state of
                                                    Success ->
                                                        "Everything worked, your file is all ready."

                                                    Warning ->
                                                        "Your file didn't meet the minimum resolution requirements."

                                                    Error ->
                                                        "There was an error."

                                                    _ ->
                                                        m.label
                                        }
                                }
                      , note =
                            case model.state of
                                Active ->
                                    "A progress bar can show activity"

                                Success ->
                                    "A progress bar can show a success state"

                                Warning ->
                                    "A progress bar can show a warning state"

                                Error ->
                                    "A progress bar can show an error state"

                                Disabled ->
                                    "A progress bar can be disabled"

                                _ ->
                                    ""
                      }
                    ]
              }
            , { label = "Content"
              , configs =
                    [ { label = "Progress"
                      , config =
                            Config.string
                                { label = ""
                                , value = model.progressLabel
                                , setter = \string m -> { m | progressLabel = string }
                                }
                      , note = "A progress bar can contain a text value indicating current progress"
                      }
                    , { label = "Label"
                      , config =
                            Config.string
                                { label = ""
                                , value = model.label
                                , setter = \string m -> { m | label = string }
                                }
                      , note = "A progress element can contain a label"
                      }
                    ]
              }
            ]
        }
    ]
