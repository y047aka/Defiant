module Pages.Modules.Checkbox exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html)
import Page
import Request exposing (Request)
import Shared
import Types exposing (FormState(..))
import UI.Checkbox exposing (checkbox, toggleCheckbox)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Checkbox"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { checked : Bool, disabled : Bool }


init : Model
init =
    { checked = False, disabled = False }



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


view : Model -> List (Html Msg)
view model =
    [ configAndPreview UpdateConfig
        { title = "Checkbox"
        , preview =
            [ checkbox
                { id = "checkbox_example"
                , label = "Make my profile visible"
                , checked = model.checked
                , disabled = model.disabled
                , onClick = ToggleChecked
                }
            ]
        , configSections =
            [ { label = "Disabled"
              , configs =
                    [ { label = ""
                      , config =
                            Config.bool
                                { id = "disabled"
                                , label = "Disabled"
                                , bool = model.disabled
                                , setter = \m -> { m | disabled = not m.disabled }
                                }
                      , note = "A checkbox can show it is currently unable to be interacted with"
                      }
                    ]
              }
            ]
        }
    , configAndPreview UpdateConfig
        { title = "Toggle"
        , preview =
            [ toggleCheckbox
                { id = "toggle_example"
                , label = "Subscribe to weekly newsletter"
                , checked = model.checked
                , disabled = model.disabled
                , onClick = ToggleChecked
                }
            ]
        , configSections = []
        }
    ]
