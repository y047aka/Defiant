module Pages.Modules.Progress exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, input, option, select, text)
import Html.Styled.Attributes exposing (checked, for, id, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Page
import Random
import Request exposing (Request)
import Shared
import UI.Button exposing (button, labeledButton)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Input as Input
import UI.Label exposing (basicLabel)
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
    = ProgressPlus
    | ProgressMinus
    | NewProgress Int
    | EditProgressLabel String
    | EditLabel String
    | ToggleIndicating
    | ChangeState State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProgressPlus ->
            ( model, Random.generate NewProgress (Random.int 10 15) )

        ProgressMinus ->
            ( model, Random.generate NewProgress (Random.int -15 -10) )

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

        EditProgressLabel string ->
            ( { model | progressLabel = string }, Cmd.none )

        EditLabel string ->
            ( { model | label = string }, Cmd.none )

        ToggleIndicating ->
            let
                newIndicating =
                    not model.indicating
            in
            ( { model
                | indicating = newIndicating
                , label =
                    if newIndicating then
                        model.label

                    else
                        "Uploading Files"
              }
                |> updatelabelOnIndicating
            , Cmd.none
            )

        ChangeState state ->
            ( { model
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
                            model.label
              }
            , Cmd.none
            )


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
    let
        controller =
            labeledButton []
                [ button [ onClick ProgressMinus ] [ text "-" ]
                , basicLabel [] [ text (String.fromFloat model.progressValue ++ "%") ]
                , button [ onClick ProgressPlus ] [ text "+" ]
                ]
    in
    [ configAndPreview { title = "Progress" }
        [ Progress.progressWithProps
            { value = model.progressValue
            , progress = String.fromFloat model.progressValue ++ model.progressLabel
            , label = model.label
            , indicating = model.indicating
            , state = model.state
            }
        ]
        [ { label = "Bar"
          , description = "A progress element can contain a bar visually indicating progress"
          , content = controller
          }
        , { label = "Types"
          , description = "An indicating progress bar visually indicates the current level of progress of a task"
          , content =
                checkbox []
                    [ Checkbox.input [ id "indicating", type_ "checkbox", checked model.indicating, onClick ToggleIndicating ] []
                    , Checkbox.label [ for "indicating" ] [ text "Indicating" ]
                    ]
          }
        , { label = "States"
          , description =
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
          , content =
                select [ onInput (Progress.stateFromString >> Maybe.withDefault model.state >> ChangeState) ] <|
                    List.map (\state -> option [ value (Progress.stateToString state), selected (model.state == state) ] [ text (Progress.stateToString state) ])
                        [ Default, Active, Success, Warning, Error, Disabled ]
          }
        , { label = "Progress"
          , description = "A progress bar can contain a text value indicating current progress"
          , content =
                Input.input []
                    [ input [ type_ "text", value model.progressLabel, onInput EditProgressLabel ] [] ]
          }
        , { label = "Label"
          , description = "A progress element can contain a label"
          , content =
                Input.input []
                    [ input [ type_ "text", value model.label, onInput EditLabel ] [] ]
          }
        ]
    ]
