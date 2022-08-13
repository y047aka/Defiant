module Pages.Collections.Message exposing (page)

import Html.Styled as Html exposing (Html, div, p, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Message exposing (message)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Message"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
    let
        options =
            { theme = shared.theme }
    in
    [ configAndPreview { title = "Message" }
        [ message []
            [ div []
                [ Header.header options [] [ text "Changes in Service" ]
                , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                ]
            ]
        ]
        []
    , configAndPreview { title = "Icon Message" }
        [ message []
            [ icon [] "fas fa-inbox"
            , div []
                [ Header.header options [] [ text "Have you heard about our mailing list?" ]
                , p [] [ text "Get the best news in your e-mail every day." ]
                ]
            ]
        ]
        []
    ]
