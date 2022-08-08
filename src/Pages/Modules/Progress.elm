module Pages.Modules.Progress exposing (Model, Msg, page)

import Css exposing (borderLeft3, column, displayFlex, flexDirection, hex, paddingLeft, pct, property, px, solid, width)
import Html.Styled as Html exposing (Html, aside, div, label, option, p, select, text)
import Html.Styled.Attributes exposing (checked, css, for, id, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Page
import Random
import Request exposing (Request)
import Shared
import UI.Button exposing (button, labeledButton)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Example exposing (example)
import UI.Label exposing (basicLabel)
import UI.Progress as Progress exposing (State(..))


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
    { progress : Float
    , indicating : Bool
    , state : State
    }


init : ( Model, Cmd Msg )
init =
    ( { progress = 0
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
                    model.progress + toFloat int

                newProgress =
                    if calculated > 100 then
                        100

                    else if calculated < 0 then
                        0

                    else
                        calculated
            in
            ( { model | progress = newProgress }, Cmd.none )

        ToggleIndicating ->
            ( { model | indicating = not model.indicating }, Cmd.none )

        ChangeState state ->
            ( { model | state = state }, Cmd.none )



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ div [ css [ displayFlex, property "column-gap" "30px" ] ]
        [ div [ css [ width (pct 100) ] ] (examples model)
        , aside
            [ css
                [ displayFlex
                , flexDirection column
                , property "gap" "20px"
                , paddingLeft (px 20)
                , borderLeft3 (px 1) solid (hex "#EEE")
                ]
            ]
            (settings model)
        ]
    ]


examples : Model -> List (Html Msg)
examples model =
    [ example
        { title = "Standard"
        , description = "A standard progress bar"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label =
                case model.state of
                    Success ->
                        "Everything worked, your file is all ready."

                    Warning ->
                        "Your file didn't meet the minimum resolution requirements."

                    Error ->
                        "There was an error."

                    Active ->
                        if model.indicating == True then
                            if model.progress == 100 then
                                "Project Funded!"

                            else
                                String.fromFloat model.progress ++ "% Funded"

                        else
                            "Uploading Files"

                    _ ->
                        "Uploading Files"
            , indicating = model.indicating
            , disabled = False
            , state = model.state
            }
        ]
    , example
        { title = "Bar"
        , description = "A progress element can contain a bar visually indicating progress"
        }
        [ Progress.progress
            { value = model.progress
            , progress = ""
            , label = ""
            , indicating = False
            , disabled = False
            , state = Progress.Default
            }
        ]
    , example
        { title = "Progress"
        , description = "A progress bar can contain a text value indicating current progress"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = ""
            , indicating = False
            , disabled = False
            , state = Progress.Default
            }
        ]
    , example
        { title = "Label"
        , description = "A progress element can contain a label"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Uploading Files"
            , indicating = False
            , disabled = False
            , state = Progress.Default
            }
        ]
    , example
        { title = "Disabled"
        , description = "A progress bar can be disabled"
        }
        [ Progress.progress
            { value = model.progress
            , progress = ""
            , label = ""
            , indicating = False
            , disabled = True
            , state = Progress.Default
            }
        ]
    ]


settings : Model -> List (Html Msg)
settings model =
    [ { label = "Value"
      , description = ""
      , content =
            labeledButton []
                [ button [ onClick ProgressMinus ] [ text "-" ]
                , basicLabel [] [ text (String.fromFloat model.progress ++ "%") ]
                , button [ onClick ProgressPlus ] [ text "+" ]
                ]
      }
    , { label = "Indicating"
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
                Success ->
                    "A progress bar can show a success state"

                Warning ->
                    "A progress bar can show a warning state"

                Error ->
                    "A progress bar can show an error state"

                Active ->
                    "A progress bar can show activity"

                _ ->
                    ""
      , content =
            select [ onInput (Progress.stateFromString >> Maybe.withDefault model.state >> ChangeState) ] <|
                List.map (\state -> option [ value (Progress.stateToString state), selected (model.state == state) ] [ text (Progress.stateToString state) ])
                    [ Default, Active, Success, Warning, Error ]
      }
    ]
        |> List.map
            (\item ->
                div [ css [ displayFlex, flexDirection column, property "gap" "5px" ] ]
                    [ label [] [ text item.label ]
                    , item.content
                    , p [] [ text item.description ]
                    ]
            )
