module Pages.Modules.Checkbox exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html)
import Page
import Request exposing (Request)
import Shared
import UI.Checkbox exposing (checkbox)
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
    { checked : Bool }


init : Model
init =
    { checked = False }



-- UPDATE


type Msg
    = ToggleChecked
    | UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleChecked ->
            { model | checked = not model.checked }

        UpdateConfig _ ->
            model



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
                , onClick = ToggleChecked
                }
            ]
        , configSections = []
        }
    ]
