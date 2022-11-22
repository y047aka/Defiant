module Pages.Form.Checkbox exposing (Model, Msg, page)

import Config
import Effect
import Html.Styled as Html exposing (Html)
import Layouts.Default exposing (layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Types exposing (FormState(..))
import UI.Checkbox exposing (checkbox, toggleCheckbox)
import View.ConfigAndPreview exposing (configAndPreview)


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
                    |> layout shared route
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


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
