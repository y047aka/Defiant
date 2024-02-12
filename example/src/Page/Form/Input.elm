module Page.Form.Input exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, input, text)
import Html.Styled.Attributes exposing (placeholder, type_)
import Playground exposing (playground)
import Shared
import UI.Header as Header
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
    [ Header.header { theme = theme } [] [ text "Input" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Search..." ] [] ]
            ]
        , controlSections = []
        }
    , Header.header { theme = theme } [] [ text "Labeled" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ Input.label [] [ text "http://" ]
                , input [ type_ "text", placeholder "mysite.com" ] []
                ]
            ]
        , controlSections = []
        }
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ Input.input []
                [ input [ type_ "text", placeholder "Enter weight.." ] []
                , Input.label [] [ text "kg" ]
                ]
            ]
        , controlSections = []
        }
    ]
