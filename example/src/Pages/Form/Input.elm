module Pages.Form.Input exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, input, text)
import Html.Styled.Attributes exposing (placeholder, type_)
import Playground exposing (playground)
import Shared
import UI.Input as Input



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type alias Msg =
    ()


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ playground
        { title = "Input"
        , theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Search..." ] [] ]
            ]
        , configSections = []
        }
    , playground
        { title = "Labeled"
        , theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ Input.label [] [ text "http://" ]
                , input [ type_ "text", placeholder "mysite.com" ] []
                ]
            ]
        , configSections = []
        }
    , playground
        { title = ""
        , theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Enter weight.." ] []
                , Input.label [] [ text "kg" ]
                ]
            ]
        , configSections = []
        }
    ]
