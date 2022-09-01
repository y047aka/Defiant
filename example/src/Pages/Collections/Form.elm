module Pages.Collections.Form exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (for, id, name, placeholder, rows, tabindex, type_)
import Page
import Request exposing (Request)
import Shared
import UI.Button exposing (button)
import UI.Checkbox as Checkbox exposing (checkboxWrapper)
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
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



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
                [ checkboxWrapper []
                    [ Checkbox.input [ id options.id, type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = options.state } [ for options.id ] [ text "I agree to the Terms and Conditions" ]
                    ]
                ]
            ]
    in
    [ configAndPreview UpdateConfig
        { title = "Form"
        , preview =
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
                    [ checkboxWrapper []
                        [ Checkbox.input [ id "checkbox_example_1", type_ "checkbox", tabindex 0 ] []
                        , checkboxLabel { state = Default } [ for "checkbox_example_1" ] [ text "I agree to the Terms and Conditions" ]
                        ]
                    ]
                , button [ type_ "submit" ] [ text "Submit" ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig
        { title = "Field"
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
    , configAndPreview UpdateConfig
        { title = "Fields"
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
    , configAndPreview UpdateConfig
        { title = ""
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
    , configAndPreview UpdateConfig
        { title = "Text Area"
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
    , configAndPreview UpdateConfig
        { title = "Checkbox"
        , preview =
            [ form []
                [ field
                    { type_ = "checkbox"
                    , label = ""
                    , state = Default
                    }
                    []
                    [ checkboxWrapper []
                        [ Checkbox.input [ id "checkbox_example_2", type_ "checkbox", tabindex 0 ] []
                        , checkboxLabel { state = Default } [ for "checkbox_example_2" ] [ text "Checkbox" ]
                        ]
                    ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig
        { title = "Form States"
        , preview = [ form [] (fieldsWithState { id = "state_example", state = model.state }) ]
        , configSections =
            [ { label = "Form States"
              , configs =
                    [ { label = ""
                      , config =
                            Config.select
                                { value = model.state
                                , options = [ Default, Error, Warning, Success, Info ]
                                , fromString = Form.stateFromString
                                , toString = Form.stateToString
                                , setter = \state m -> { m | state = state }
                                }
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
    ]
