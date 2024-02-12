module Page.Element.Loader exposing (Model, Msg, init, update, view)

import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import UI.Dimmer exposing (dimmer)
import UI.Example exposing (wireframeShortParagraph)
import UI.Header as Header
import UI.Loader exposing (loader, textLoader)
import UI.Segment exposing (segment)



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
view shared =
    [ Header.header { theme = shared.theme } [] [ text "Loader" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Light }
                    []
                    [ loader { theme = Light } [] [] ]
                ]
            ]
        , controlSections = []
        }
    , Header.header { theme = shared.theme } [] [ text "Text Loader" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Light }
                    []
                    [ textLoader { theme = Light } [] [ text "Loading" ] ]
                ]
            , segment { theme = shared.theme }
                []
                [ wireframeShortParagraph
                , dimmer { isActive = True, theme = Dark }
                    []
                    [ textLoader { theme = Dark } [] [ text "Loading" ] ]
                ]
            ]
        , controlSections = []
        }
    ]
