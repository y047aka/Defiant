module Page.Form.Form exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, text)
import Html.Styled.Attributes exposing (placeholder, rows, type_)
import Playground exposing (playground)
import Shared
import Types exposing (FormState(..), formStateFromString, formStateToString)
import UI.Button exposing (button)
import UI.Checkbox as Checkbox
import UI.Form as Form exposing (field, fields, form, textarea, threeFields, twoFields)



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
    [ playground
        { title = "Form"
        , theme = theme
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
                    [ Playground.select
                        { label = ""
                        , value = model.state
                        , options = [ Default, Error, Warning, Success, Info ]
                        , fromString = formStateFromString
                        , toString = formStateToString
                        , onChange = (\state c -> { c | state = state }) >> UpdateConfig
                        , note =
                            case model.state of
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
                        }
                    ]
              }
            ]
        }
    , playground
        { title = "Field"
        , theme = theme
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
    , playground
        { title = "Fields"
        , theme = theme
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
        { title = ""
        , theme = theme
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
    , playground
        { title = "Text Area"
        , theme = theme
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
    , playground
        { title = "Checkbox"
        , theme = theme
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