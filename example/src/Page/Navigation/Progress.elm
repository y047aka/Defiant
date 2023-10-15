module Page.Navigation.Progress exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Props
import Random
import Shared
import UI.Header as Header
import UI.Progress as Progress exposing (State(..))



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
    | CounterPlus
    | CounterMinus
    | UpdateConfig (Model -> Model)


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

        CounterPlus ->
            ( model, Random.generate NewProgress (Random.int 10 15) )

        CounterMinus ->
            ( model, Random.generate NewProgress (Random.int -15 -10) )

        UpdateConfig updater ->
            ( updater model, Cmd.none )


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
    [ Header.header { theme = theme } [] [ text "Progress" ]
    , playground
        { theme = theme
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
                    [ Props.field
                        { label = ""
                        , props =
                            Props.counter
                                { value = model.progressValue
                                , toString = \value -> String.fromFloat value ++ "%"
                                , onClickPlus = CounterPlus
                                , onClickMinus = CounterMinus
                                }
                        , note = "A progress element can contain a bar visually indicating progress"
                        }
                    ]
              }
            , { label = "Types"
              , configs =
                    [ Props.field
                        { label = ""
                        , props =
                            Props.bool
                                { label = "Indicating"
                                , value = model.indicating
                                , onClick =
                                    (\ps ->
                                        let
                                            newIndicating =
                                                not ps.indicating
                                        in
                                        { ps
                                            | indicating = newIndicating
                                            , label =
                                                if newIndicating then
                                                    ps.label

                                                else
                                                    "Uploading Files"
                                        }
                                            |> updatelabelOnIndicating
                                    )
                                        |> UpdateConfig
                                }
                        , note = "An indicating progress bar visually indicates the current level of progress of a task"
                        }
                    ]
              }
            , { label = "States"
              , configs =
                    [ Props.field
                        { label = ""
                        , props =
                            Props.select
                                { value = Progress.stateToString model.state
                                , options = List.map Progress.stateToString [ Default, Active, Success, Warning, Error, Disabled ]
                                , onChange =
                                    (\state ps ->
                                        Progress.stateFromString state
                                            |> Maybe.map
                                                (\s ->
                                                    { ps
                                                        | state = s
                                                        , label =
                                                            case s of
                                                                Success ->
                                                                    "Everything worked, your file is all ready."

                                                                Warning ->
                                                                    "Your file didn't meet the minimum resolution requirements."

                                                                Error ->
                                                                    "There was an error."

                                                                _ ->
                                                                    ps.label
                                                    }
                                                )
                                            |> Maybe.withDefault ps
                                    )
                                        >> UpdateConfig
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
                    [ Props.field
                        { label = "Progress"
                        , props =
                            Props.string
                                { value = model.progressLabel
                                , onInput = (\string ps -> { ps | progressLabel = string }) >> UpdateConfig
                                , placeholder = ""
                                }
                        , note = "A progress bar can contain a text value indicating current progress"
                        }
                    , Props.field
                        { label = "Label"
                        , props =
                            Props.string
                                { value = model.label
                                , onInput = (\string ps -> { ps | label = string }) >> UpdateConfig
                                , placeholder = ""
                                }
                        , note = "A progress element can contain a label"
                        }
                    ]
              }
            ]
        }
    ]
