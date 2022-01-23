module Page.Modules.Progress exposing (Model, Msg, architecture)

import Html.Styled as Html exposing (Html, text)
import Html.Styled.Events exposing (onClick)
import Random
import Shared exposing (Shared)
import UI.Button exposing (button, labeledButton)
import UI.Example exposing (example)
import UI.Label exposing (basicLabel)
import UI.Progress as Progress


architecture :
    { init : Shared -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }
architecture =
    { init = init
    , update = update
    , view = view
    }


type alias Model =
    { shared : Shared
    , progress : Float
    }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared
      , progress = 0
      }
    , Random.generate NewProgress (Random.int 10 50)
    )


type Msg
    = ProgressPlus
    | ProgressMinus
    | NewProgress Int


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


view : Model -> List (Html Msg)
view model =
    let
        controller =
            labeledButton []
                [ button [ onClick ProgressMinus ] [ text "-" ]
                , basicLabel [] [ text (String.fromFloat model.progress ++ "%") ]
                , button [ onClick ProgressPlus ] [ text "+" ]
                ]
    in
    [ example
        { title = "Standard"
        , description = "A standard progress bar"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Uploading Files"
            , indicating = False
            , disabled = False
            , state = Progress.Default
            }
        , controller
        ]
    , example
        { title = "Indicating"
        , description = "An indicating progress bar visually indicates the current level of progress of a task"
        }
        [ Progress.progress
            { value = model.progress
            , progress = ""
            , label =
                if model.progress == 100 then
                    "Project Funded!"

                else
                    String.fromFloat model.progress ++ "% Funded"
            , indicating = True
            , disabled = False
            , state = Progress.Active
            }
        , controller
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
        { title = "Active"
        , description = "A progress bar can show activity"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Uploading Files"
            , indicating = False
            , disabled = False
            , state = Progress.Active
            }
        ]
    , example
        { title = "Success"
        , description = "A progress bar can show a success state"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Everything worked, your file is all ready."
            , indicating = False
            , disabled = False
            , state = Progress.Success
            }
        ]
    , example
        { title = "Warning"
        , description = "A progress bar can show a warning state"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Your file didn't meet the minimum resolution requirements."
            , indicating = False
            , disabled = False
            , state = Progress.Warning
            }
        ]
    , example
        { title = "Error"
        , description = "A progress bar can show an error state"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "There was an error."
            , indicating = False
            , disabled = False
            , state = Progress.Error
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
