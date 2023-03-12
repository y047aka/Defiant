module Pages.Form.Checkbox exposing (Model, Msg, page)

import Config
import Effect
import Html.Styled as Html exposing (Html)
import Layouts exposing (Layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Types exposing (FormState(..))
import UI.Checkbox exposing (checkbox, toggleCheckbox)
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
                { title = "Checkbox"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



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
    [ configAndPreview
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
                    [ Config.bool
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
    , configAndPreview
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
