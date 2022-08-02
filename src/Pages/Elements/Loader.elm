module Pages.Elements.Loader exposing (page)

import Data.Theme exposing (Theme(..))
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
    [ example
        { title = "Loader"
        , description = "A loader"
        }
        [ segment { theme = shared.theme }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, theme = Light }
                []
                [ loader { theme = Light } [] [] ]
            ]
        ]
    , example
        { title = "Text Loader"
        , description = "A loader can contain text"
        }
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
    ]
