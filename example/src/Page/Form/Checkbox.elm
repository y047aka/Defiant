module Page.Form.Checkbox exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html)
import Playground exposing (playground)
import Shared
import Types exposing (FormState(..))
import UI.Checkbox exposing (checkbox, toggleCheckbox)



-- INIT


type alias Model =
    { checked : Bool, disabled : Bool }


init : Model
init =
    { checked = False, disabled = False }



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
        { title = "Checkbox"
        , theme = theme
        , inverted = False
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
                    [ Playground.bool
                        { label = "Disabled"
                        , id = "disabled"
                        , bool = model.disabled
                        , onClick = (\c -> { c | disabled = not c.disabled }) |> UpdateConfig
                        , note = "A checkbox can show it is currently unable to be interacted with"
                        }
                    ]
              }
            ]
        }
    , playground
        { title = "Toggle"
        , theme = theme
        , inverted = False
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
