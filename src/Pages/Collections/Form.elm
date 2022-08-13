module Pages.Collections.Form exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, option, select, text)
import Html.Styled.Attributes exposing (for, id, name, placeholder, rows, selected, tabindex, type_, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Button exposing (button)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Form as Form exposing (State(..), checkboxLabel, field, fields, form, textarea, threeFields, twoFields)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Form"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { state : State }


init : Model
init =
    { state = Error }



-- UPDATE


type Msg
    = ChangeState State


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeState state ->
            { model | state = state }



-- VIEW


view : Model -> List (Html Msg)
view model =
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
    [ configAndPreview { title = "Form" }
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
        []
    , configAndPreview { title = "Field" }
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
        []
    , configAndPreview { title = "Fields" }
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
        []
    , configAndPreview { title = "" }
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
        []
    , configAndPreview { title = "Text Area" }
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
        []
    , configAndPreview { title = "Checkbox" }
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
        []
    , configAndPreview { title = "Form States" }
        [ form [] (fieldsWithState { id = "state_example", state = model.state }) ]
        [ { label = "Form States"
          , description =
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
          , content =
                select [ onInput (Form.stateFromString >> Maybe.withDefault model.state >> ChangeState) ] <|
                    List.map (\state -> option [ value (Form.stateToString state), selected (model.state == state) ] [ text (Form.stateToString state) ])
                        [ Default, Error, Warning, Success, Info ]
          }
        ]
    ]
