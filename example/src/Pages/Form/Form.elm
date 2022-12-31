module Pages.Form.Form exposing (Model, Msg, page)

import Config
import Effect
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (placeholder, rows, type_)
import Layouts exposing (Layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Types exposing (FormState(..), formStateFromString, formStateToString)
import UI.Button exposing (button)
import UI.Checkbox as Checkbox
import UI.Form as Form exposing (field, fields, form, textarea, threeFields, twoFields)
import View.ConfigAndPreview exposing (configAndPreview)


layout : Model -> Layout
layout model =
    Layouts.Default { default = () }


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Form"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



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
    | UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleChecked ->
            { model | checked = not model.checked }

        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Form"
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
                    [ { label = ""
                      , config =
                            Config.select
                                { value = model.state
                                , options = [ Default, Error, Warning, Success, Info ]
                                , fromString = formStateFromString
                                , toString = formStateToString
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Checkbox"
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
