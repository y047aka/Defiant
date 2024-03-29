module Page.Form.Checkbox exposing (Model, Msg, init, update, view)

import Control
import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import Types exposing (FormState(..))
import UI.Checkbox exposing (checkbox, toggleCheckbox)
import UI.Header as Header



-- INIT


type alias Model =
    { checked : Bool, disabled : Bool }


init : Model
init =
    { checked = False, disabled = False }



-- UPDATE


type Msg
    = ToggleChecked
    | UpdateProps (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleChecked ->
            { model | checked = not model.checked }

        UpdateProps updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ Header.header { theme = theme } [] [ text "Checkbox" ]
    , playground
        { theme = theme
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
        , controlSections =
            [ { heading = "Disabled"
              , controls =
                    [ Control.field "Disabled"
                        (Control.bool
                            { id = "disabled"
                            , value = model.disabled
                            , onClick = (\ps -> { ps | disabled = not ps.disabled }) |> UpdateProps
                            }
                        )
                    , Control.comment "A checkbox can show it is currently unable to be interacted with"
                    ]
              }
            ]
        }
    , Header.header { theme = theme } [] [ text "Toggle" ]
    , playground
        { theme = theme
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
        , controlSections = []
        }
    ]
