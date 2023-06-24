module Pages.Navigation.Progress exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html.Styled exposing (Html)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Random
import Route exposing (Route)
import Shared
import UI.Progress as Progress exposing (State(..))


layout : Model -> Layout msg
layout model =
    Layouts.Default {}


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Progress"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    { progressValue : Float
    , progressLabel : String
    , label : String
    , indicating : Bool
    , state : State
    }


init : () -> ( Model, Effect Msg )
init () =
    ( { progressValue = 0
      , progressLabel = "%"
      , label = "Uploading Files"
      , indicating = False
      , state = Default
      }
    , Effect.sendCmd <| Random.generate NewProgress (Random.int 10 50)
    )



-- UPDATE


type Msg
    = NewProgress Int
    | CounterPlus
    | CounterMinus
    | UpdateConfig (Model -> Model)


update : Msg -> Model -> ( Model, Effect Msg )
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
            , Effect.none
            )

        CounterPlus ->
            ( model, Effect.sendCmd <| Random.generate NewProgress (Random.int 10 15) )

        CounterMinus ->
            ( model, Effect.sendCmd <| Random.generate NewProgress (Random.int -15 -10) )

        UpdateConfig updater ->
            ( updater model, Effect.none )


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


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ playground
        { title = "Progress"
        , theme = theme
        , inverted = False
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
                    [ Playground.counter
                        { label = ""
                        , value = model.progressValue
                        , toString = \value -> String.fromFloat value ++ "%"
                        , onClickPlus = CounterPlus
                        , onClickMinus = CounterMinus
                        , note = "A progress element can contain a bar visually indicating progress"
                        }
                    ]
              }
            , { label = "Types"
              , configs =
                    [ Playground.bool
                        { id = "indicating"
                        , label = "Indicating"
                        , bool = model.indicating
                        , onClick =
                            (\c ->
                                let
                                    newIndicating =
                                        not c.indicating
                                in
                                { c
                                    | indicating = newIndicating
                                    , label =
                                        if newIndicating then
                                            c.label

                                        else
                                            "Uploading Files"
                                }
                                    |> updatelabelOnIndicating
                            )
                                |> UpdateConfig
                        , note = "An indicating progress bar visually indicates the current level of progress of a task"
                        }
                    ]
              }
            , { label = "States"
              , configs =
                    [ Playground.select
                        { label = ""
                        , value = model.state
                        , options = [ Default, Active, Success, Warning, Error, Disabled ]
                        , fromString = Progress.stateFromString
                        , toString = Progress.stateToString
                        , onChange =
                            (\state c ->
                                { c
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
                                                c.label
                                }
                            )
                                >> UpdateConfig
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
                    [ Playground.string
                        { label = "Progress"
                        , value = model.progressLabel
                        , onInput = (\string c -> { c | progressLabel = string }) >> UpdateConfig
                        , placeholder = ""
                        , note = "A progress bar can contain a text value indicating current progress"
                        }
                    , Playground.string
                        { label = "Label"
                        , value = model.label
                        , onInput = (\string c -> { c | label = string }) >> UpdateConfig
                        , placeholder = ""
                        , note = "A progress element can contain a label"
                        }
                    ]
              }
            ]
        }
    ]
