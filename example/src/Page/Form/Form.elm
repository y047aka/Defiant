module Page.Form.Form exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, text)
import Html.Styled.Attributes exposing (placeholder, rows, type_)
import Playground exposing (playground)
import Props
import Shared
import Types exposing (FormState(..), formStateFromString, formStateToString)
import UI.Button exposing (button)
import UI.Checkbox as Checkbox
import UI.Form as Form exposing (field, fields, form, textarea, threeFields, twoFields)
import UI.Header as Header



-- INIT


type alias Model =
    { checked : Bool
    , state : FormState
    }


init : Model
init =
    { checked = False
    , state = Error
    }



-- UPDATE


type Msg
    = ToggleChecked
    | UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleChecked ->
            { model | checked = not model.checked }

        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ Header.header { theme = theme } [] [ text "Form" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ form []
                [ twoFields []
                    [ field
                        { type_ = "text"
                        , label = "First Name"
                        , state = model.state
                        }
                        []
                        [ Form.input { state = model.state } [ type_ "text", placeholder "First Name" ] [] ]
                    , field
                        { type_ = "text"
                        , label = "Last Name"
                        , state = Default
                        }
                        []
                        [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                    ]
                , field
                    { type_ = "checkbox"
                    , label = ""
                    , state = model.state
                    }
                    []
                    [ Checkbox.checkboxWithProps
                        { id = "state_example"
                        , label = "I agree to the Terms and Conditions"
                        , checked = model.checked
                        , disabled = False
                        , state = model.state
                        , onClick = ToggleChecked
                        }
                    ]
                , button [ type_ "submit" ] [ text "Submit" ]
                ]
            ]
        , configSections =
            [ { label = "Form States"
              , configs =
                    [ Props.field "Form States"
                        (Props.select
                            { value = formStateToString model.state
                            , options = List.map formStateToString [ Default, Error, Warning, Success, Info ]
                            , onChange =
                                (\state ps ->
                                    formStateFromString state
                                        |> Maybe.map (\s -> { ps | state = s })
                                        |> Maybe.withDefault ps
                                )
                                    >> UpdateConfig
                            }
                        )
                    , Props.comment
                        (case model.state of
                            Error ->
                                "Individual fields may display an error state"

                            Warning ->
                                "Individual fields may display a warning state"

                            Success ->
                                "Individual fields may display a Success state"

                            Info ->
                                "Individual fields may display an informational state"

                            Default ->
                                ""
                        )
                    ]
              }
            ]
        }
    , Header.header { theme = theme } [] [ text "Field" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ form []
                [ field
                    { type_ = "text"
                    , label = "User Input"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text" ] [] ]
                ]
            ]
        , configSections = []
        }
    , Header.header { theme = theme } [] [ text "Fields" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ form []
                [ fields []
                    [ field
                        { type_ = "text"
                        , label = "First Name"
                        , state = Default
                        }
                        []
                        [ Form.input { state = Default } [ type_ "text", placeholder "First Name" ] [] ]
                    , field
                        { type_ = "text"
                        , label = "Middle name"
                        , state = Default
                        }
                        []
                        [ Form.input { state = Default } [ type_ "text", placeholder "Middle name" ] [] ]
                    , field
                        { type_ = "text"
                        , label = "Last Name"
                        , state = Default
                        }
                        []
                        [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                    ]
                ]
            ]
        , configSections = []
        }
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ form []
                [ threeFields []
                    [ field
                        { type_ = "text"
                        , label = "First Name"
                        , state = Default
                        }
                        []
                        [ Form.input { state = Default } [ type_ "text", placeholder "First Name" ] [] ]
                    , field
                        { type_ = "text"
                        , label = "Middle name"
                        , state = Default
                        }
                        []
                        [ Form.input { state = Default } [ type_ "text", placeholder "Middle name" ] [] ]
                    , field
                        { type_ = "text"
                        , label = "Last Name"
                        , state = Default
                        }
                        []
                        [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                    ]
                ]
            ]
        , configSections = []
        }
    , Header.header { theme = theme } [] [ text "Text Area" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ form []
                [ field
                    { type_ = "textarea"
                    , label = "Text"
                    , state = Default
                    }
                    []
                    [ textarea { state = Default } [] [] ]
                , field
                    { type_ = "textarea"
                    , label = "Short Text"
                    , state = Default
                    }
                    []
                    [ textarea { state = Default } [ rows 2 ] [] ]
                ]
            ]
        , configSections = []
        }
    , Header.header { theme = theme } [] [ text "Checkbox" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ form []
                [ field
                    { type_ = "checkbox"
                    , label = ""
                    , state = Default
                    }
                    []
                    [ Checkbox.checkbox
                        { id = "checkbox_example_2"
                        , label = "Checkbox"
                        , checked = model.checked
                        , disabled = False
                        , onClick = ToggleChecked
                        }
                    ]
                ]
            ]
        , configSections = []
        }
    ]
