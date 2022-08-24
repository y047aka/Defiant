module Pages.Collections.Menu exposing (page)

import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes as Attributes exposing (href, placeholder, rel, type_)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Input as Input
import UI.Menu as Menu exposing (..)
import UI.Segment exposing (invertedSegment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Menu"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
    [ configAndPreview
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
        , configs = []
        }
    , configAndPreview
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
        , configs = []
        }
    , configAndPreview
        { title = "Link Item"
        , preview =
            [ verticalMenu { theme = shared.theme, additionalStyles = [] } [] <|
                [ verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
                , verticalMenuLinkItem { theme = shared.theme, additionalStyles = [] } [] [ text "Javascript Link" ]
                ]
            ]
        , configs = []
        }
    , configAndPreview
        { title = "Inverted"
        , preview =
            [ Menu.menu { theme = Dark } [] <|
                [ linkItem { theme = Dark } [] [ text "Home" ]
                , linkItem { theme = Dark } [] [ text "Messages" ]
                , linkItem { theme = Dark } [] [ text "Friends" ]
                ]
            ]
        , configs = []
        }
    , configAndPreview
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
        , configs = []
        }
    ]
