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
    Progress.Model


init : ( Model, Cmd Msg )
init =
    ( Progress.init
    , Random.generate (Progress.SetValue >> ProgressMsg) (Random.int 10 50)
    )



-- UPDATE


type Msg
    = CounterPlus
    | CounterMinus
    | ProgressMsg Progress.Msg
    | UpdateConfig (Model -> Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CounterPlus ->
            ( model, Random.generate (Progress.SetValue >> ProgressMsg) (Random.int 10 15) )

        CounterMinus ->
            ( model, Random.generate (Progress.SetValue >> ProgressMsg) (Random.int -15 -10) )

        ProgressMsg progressMsg ->
            let
                ( progressModel, progressCmd ) =
                    Progress.update progressMsg model
            in
            ( progressModel, Cmd.map ProgressMsg progressCmd )

        UpdateConfig updater ->
            ( updater model, Cmd.none )



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ Header.header { theme = theme } [] [ text "Progress" ]
    , playground
        { theme = theme
        , inverted = False
        , preview = [ Progress.progressWithProps model ]
        , configSections =
            [ { label = "Bar"
              , configs =
                    [ Props.field
                        { label = ""
                        , props =
                            Props.counter
                                { value = model.value
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
                                            , caption =
                                                if newIndicating then
                                                    ps.caption

                                                else
                                                    "Uploading Files"
                                        }
                                            |> Progress.updateCaptionOnIndicating
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
                                                        , caption =
                                                            case s of
                                                                Success ->
                                                                    "Everything worked, your file is all ready."

                                                                Warning ->
                                                                    "Your file didn't meet the minimum resolution requirements."

                                                                Error ->
                                                                    "There was an error."

                                                                _ ->
                                                                    ps.caption
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
                        { label = "Unit"
                        , props =
                            Props.string
                                { value = model.unit
                                , onInput = (\string ps -> { ps | unit = string }) >> UpdateConfig
                                , placeholder = ""
                                }
                        , note = "A progress bar can contain a text value indicating current progress"
                        }
                    , Props.field
                        { label = "Caption"
                        , props =
                            Props.string
                                { value = model.caption
                                , onInput = (\string ps -> { ps | caption = string }) >> UpdateConfig
                                , placeholder = ""
                                }
                        , note = "A progress element can contain a label"
                        }
                    ]
              }
            ]
        }
    ]
