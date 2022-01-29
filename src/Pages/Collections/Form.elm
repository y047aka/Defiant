module Pages.Collections.Form exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (for, id, name, placeholder, rows, tabindex, type_)
import Shared exposing (Shared)
import UI.Button exposing (button)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Example exposing (example)
import UI.Form as Form exposing (State(..), checkboxLabel, field, fields, form, textarea, threeFields, twoFields)


architecture : Architecture Model Msg
architecture =
    { init = init
    , update = update
    , view = view
    }


type alias Model =
    { shared : Shared }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared }, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> List (Html msg)
view _ =
    let
        fieldsWithState options =
            [ twoFields []
                [ field
                    { type_ = "text"
                    , label = "First Name"
                    , state = options.state
                    }
                    []
                    [ Form.input { state = options.state } [ type_ "text", placeholder "First Name" ] [] ]
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
                , state = options.state
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id options.id, type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = options.state } [ for options.id ] [ text "I agree to the Terms and Conditions" ]
                    ]
                ]
            ]
    in
    [ example
        { title = "Form"
        , description = "A form"
        }
        [ form []
            [ field
                { type_ = "text"
                , label = "First Name"
                , state = Default
                }
                []
                [ Form.input { state = Default } [ type_ "text", name "first-name", placeholder "First Name" ] [] ]
            , field
                { type_ = "text"
                , label = "Last Name"
                , state = Default
                }
                []
                [ Form.input { state = Default } [ type_ "text", name "last-name", placeholder "Last Name" ] [] ]
            , field
                { type_ = "checkbox"
                , label = ""
                , state = Default
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id "checkbox_example_1", type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = Default } [ for "checkbox_example_1" ] [ text "I agree to the Terms and Conditions" ]
                    ]
                ]
            , button [ type_ "submit" ] [ text "Submit" ]
            ]
        ]
    , example
        { title = "Field"
        , description = "A field is a form element containing a label and an input"
        }
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
    , example
        { title = "Fields"
        , description = "A set of fields can appear grouped together"
        }
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
    , example
        { title = "", description = "" }
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
    , example
        { title = "Text Area"
        , description = "A textarea can be used to allow for extended user input."
        }
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
    , example
        { title = "Checkbox"
        , description = "A form can contain a checkbox"
        }
        [ form []
            [ field
                { type_ = "checkbox"
                , label = ""
                , state = Default
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id "checkbox_example_2", type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = Default } [ for "checkbox_example_2" ] [ text "Checkbox" ]
                    ]
                ]
            ]
        ]
    , example
        { title = "Field Error"
        , description = "Individual fields may display an error state"
        }
        [ form [] (fieldsWithState { id = "state_example_1", state = Error }) ]
    , example
        { title = "Field Warning"
        , description = "Individual fields may display a warning state"
        }
        [ form [] (fieldsWithState { id = "state_example_2", state = Warning }) ]
    , example
        { title = "Field Success"
        , description = "Individual fields may display a Success state"
        }
        [ form [] (fieldsWithState { id = "state_example_3", state = Success }) ]
    , example
        { title = "Field Info"
        , description = "Individual fields may display an informational state"
        }
        [ form [] (fieldsWithState { id = "state_example_4", state = Info }) ]
    ]
