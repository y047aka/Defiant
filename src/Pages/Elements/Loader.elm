module Pages.Elements.Loader exposing (page)

import Data.Theme exposing (isDark)
import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Dimmer exposing (dimmer)
import UI.Example exposing (example, wireframeShortParagraph)
import UI.Loader exposing (loader, textLoader)
import UI.Segment exposing (segment)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Loader"
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
        { title = "Loader"
        , description = "A loader"
        }
        [ segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = False }
                []
                [ loader { inverted = False } [] [] ]
            ]
        ]
    , example
        { title = "Text Loader"
        , description = "A loader can contain text"
        }
        [ segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = False }
                []
                [ textLoader { inverted = False } [] [ text "Loading" ] ]
            ]
        , segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = True }
                []
                [ textLoader { inverted = True } [] [ text "Loading" ] ]
            ]
        ]
    ]
