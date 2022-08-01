module Pages.Collections.Menu exposing (page)

import Data.Theme exposing (isDark)
import Html.Styled as Html exposing (Html, input, text)
import Html.Styled.Attributes as Attributes exposing (href, placeholder, rel, type_)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Input as Input
import UI.Menu as Menu exposing (..)
import UI.Segment exposing (invertedSegment)


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
    let
        inverted =
            isDark shared.theme
    in
    [ example
        { title = "Secondary Menu"
        , description = "A menu can adjust its appearance to de-emphasize its contents"
        }
        [ secondaryMenu { inverted = False } [] <|
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
    , example
        { title = "Vertical Menu"
        , description = "A vertical menu displays elements vertically.."
        }
        [ verticalMenu { inverted = inverted, additionalStyles = [] } [] <|
            [ verticalMenuActiveItem { inverted = inverted } [] <|
                [ text "Inbox"
                , verticalMenuActiveItemLabel [] [ text "1" ]
                ]
            , verticalMenuItem { inverted = inverted, additionalStyles = [] } [] <|
                [ text "Spam"
                , verticalMenuActiveItemLabel [] [ text "51" ]
                ]
            , verticalMenuItem { inverted = inverted, additionalStyles = [] } [] <|
                [ text "Updates"
                , verticalMenuActiveItemLabel [] [ text "1" ]
                ]
            , verticalMenuItem { inverted = inverted, additionalStyles = [] } [] [ text "Search mail..." ]
            ]
        ]
    , example
        { title = "Link Item"
        , description = "A menu may contain a link item, or an item formatted as if it is a link."
        }
        [ verticalMenu { inverted = inverted, additionalStyles = [] } [] <|
            [ verticalMenuLinkItem { inverted = inverted, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
            , verticalMenuLinkItem { inverted = inverted, additionalStyles = [] } [] [ text "Javascript Link" ]
            ]
        ]
    , example
        { title = "Inverted"
        , description = "A menu may have its colors inverted to show greater contrast"
        }
        [ Menu.menu { inverted = True } [] <|
            [ linkItem { inverted = True } [] [ text "Home" ]
            , linkItem { inverted = True } [] [ text "Messages" ]
            , linkItem { inverted = True } [] [ text "Friends" ]
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ invertedSegment []
            [ secondaryMenu { inverted = False } [] <|
                [ linkItem { inverted = True } [] [ text "Home" ]
                , linkItem { inverted = True } [] [ text "Messages" ]
                , linkItem { inverted = True } [] [ text "Friends" ]
                ]
            ]
        ]
    ]
