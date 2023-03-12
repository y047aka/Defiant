module Pages.Navigation.Menu exposing (Model, Msg, page)

import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes as Attributes exposing (href, placeholder, rel, type_)
import Layouts exposing (Layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Input as Input
import UI.Menu as Menu exposing (..)
import UI.Segment exposing (invertedSegment)
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
            \_ ->
                { title = "Menu"
                , body = view shared
                }
        }
        |> Page.withLayout layout



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
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Shared.Model -> List (Html Msg)
view shared =
    [ configAndPreview
        { title = "Secondary Menu"
        , theme = shared.theme
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
        , configSections = []
        }
    , configAndPreview
        { title = "Vertical Menu"
        , theme = shared.theme
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
        , configSections = []
        }
    , configAndPreview
        { title = "Link Item"
        , theme = shared.theme
        , inverted = False
        , preview =
            [ verticalMenu { theme = shared.theme, additionalStyles = [] } [] <|
                [ verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
                , verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [] [ text "Javascript Link" ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview
        { title = "Inverted"
        , theme = shared.theme
        , inverted = False
        , preview =
            [ Menu.menu { theme = Dark } [] <|
                [ linkItem { theme = Dark } [] [ text "Home" ]
                , linkItem { theme = Dark } [] [ text "Messages" ]
                , linkItem { theme = Dark } [] [ text "Friends" ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview
        { title = ""
        , theme = shared.theme
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
        , configSections = []
        }
    ]
