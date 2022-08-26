module Pages.Modules.Checkbox exposing (Model, Msg, page)

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
            \_ ->
                { title = "Checkbox"
                , body = view
                }
        }



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : List (Html Msg)
view =
    [ configAndPreview
        { title = "Checkbox"
        , preview =
            [ checkbox
                { id = "checkbox_example"
                , label = "Make my profile visible"
                , checked = False
                , onClick = NoOp
                }
            ]
        , configs = []
        }
    ]
