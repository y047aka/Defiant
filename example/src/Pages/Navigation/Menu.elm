module Pages.Navigation.Menu exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes as Attributes exposing (href, placeholder, rel, type_)
import Page
import Request exposing (Request)
import Shared
import UI.Input as Input
import UI.Menu as Menu exposing (..)
import UI.Segment exposing (invertedSegment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Menu"
                , body = view shared
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
    = UpdateConfig (Config.Msg Model Msg)


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view shared =
    [ configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Secondary Menu"
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
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Vertical Menu"
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
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Link Item"
        , preview =
            [ verticalMenu { theme = shared.theme, additionalStyles = [] } [] <|
                [ verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
                , verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [] [ text "Javascript Link" ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Inverted"
        , preview =
            [ Menu.menu { theme = Dark } [] <|
                [ linkItem { theme = Dark } [] [ text "Home" ]
                , linkItem { theme = Dark } [] [ text "Messages" ]
                , linkItem { theme = Dark } [] [ text "Friends" ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = ""
        , preview =
            [ invertedSegment []
                [ secondaryMenu { theme = Light } [] <|
                    [ linkItem { theme = Dark } [] [ text "Home" ]
                    , linkItem { theme = Dark } [] [ text "Messages" ]
                    , linkItem { theme = Dark } [] [ text "Friends" ]
                    ]
                ]
            ]
        , configSections = []
        }
    ]
