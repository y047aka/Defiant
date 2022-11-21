module Pages.Navigation.Menu exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes as Attributes exposing (href, placeholder, rel, type_)
import Layouts.Default exposing (layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Input as Input
import UI.Menu as Menu exposing (..)
import UI.Segment exposing (invertedSegment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \_ model -> ( model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Menu"
                , body = view shared
                }
                    |> layout shared route
        }



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)



-- VIEW


view : Shared.Model -> List (Html Msg)
view shared =
    [ configAndPreview UpdateConfig { theme = shared.theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = shared.theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = shared.theme, inverted = False } <|
        { title = "Link Item"
        , preview =
            [ verticalMenu { theme = shared.theme, additionalStyles = [] } [] <|
                [ verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
                , verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [] [ text "Javascript Link" ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = shared.theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = shared.theme, inverted = False } <|
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
