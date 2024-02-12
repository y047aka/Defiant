module Page.Navigation.Menu exposing (Model, Msg, init, update, view)

import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, input, text)
import Html.Styled.Attributes as Attributes exposing (href, placeholder, rel, type_)
import Playground exposing (playground)
import Shared
import UI.Header as Header
import UI.Input as Input
import UI.Menu as Menu exposing (..)
import UI.Segment exposing (invertedSegment)



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
    [ Header.header { theme = shared.theme } [] [ text "Secondary Menu" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ secondaryMenu { theme = Light } [] <|
                [ secondaryMenuActiveItem [] [ text "Home" ]
                , secondaryMenuItem [] [] [ text "Messages" ]
                , secondaryMenuItem [] [] [ text "Friends" ]
                , rightMenu []
                    [ secondaryMenuItem [] [] <|
                        [ Input.input []
                            [ input [ type_ "text", placeholder "Search..." ] [] ]
                        ]
                    , secondaryMenuItem [] [] [ text "Logout" ]
                    ]
                ]
            ]
        , controlSections = []
        }
    , Header.header { theme = shared.theme } [] [ text "Vertical Menu" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ verticalMenu { theme = shared.theme, additionalStyles = [] } [] <|
                [ verticalMenuActiveItem { theme = shared.theme } [] <|
                    [ text "Inbox"
                    , verticalMenuActiveItemLabel [] [ text "1" ]
                    ]
                , verticalMenuItem { theme = shared.theme, additionalStyles = [] } [] <|
                    [ text "Spam"
                    , verticalMenuActiveItemLabel [] [ text "51" ]
                    ]
                , verticalMenuItem { theme = shared.theme, additionalStyles = [] } [] <|
                    [ text "Updates"
                    , verticalMenuActiveItemLabel [] [ text "1" ]
                    ]
                , verticalMenuItem { theme = shared.theme, additionalStyles = [] } [] [ text "Search mail..." ]
                ]
            ]
        , controlSections = []
        }
    , Header.header { theme = shared.theme } [] [ text "Link Item" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ verticalMenu { theme = shared.theme, additionalStyles = [] } [] <|
                [ verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
                , verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [] [ text "Javascript Link" ]
                ]
            ]
        , controlSections = []
        }
    , Header.header { theme = shared.theme } [] [ text "Inverted" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ Menu.menu { theme = Dark } [] <|
                [ linkItem { theme = Dark } [] [ text "Home" ]
                , linkItem { theme = Dark } [] [ text "Messages" ]
                , linkItem { theme = Dark } [] [ text "Friends" ]
                ]
            ]
        , controlSections = []
        }
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ invertedSegment []
                [ secondaryMenu { theme = Light } [] <|
                    [ linkItem { theme = Dark } [] [ text "Home" ]
                    , linkItem { theme = Dark } [] [ text "Messages" ]
                    , linkItem { theme = Dark } [] [ text "Friends" ]
                    ]
                ]
            ]
        , controlSections = []
        }
    ]
