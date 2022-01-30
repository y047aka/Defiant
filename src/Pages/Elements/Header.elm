module Pages.Elements.Header exposing (page)

import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example, wireframeShortParagraph)
import UI.Header as Header exposing (..)
import UI.Icon exposing (icon)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Header"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
    let
        options =
            { inverted = shared.darkMode }
    in
    [ example
        { title = "Content Headers"
        , description = "Headers may be oriented to give the importance of a section in the context of the content that surrounds it"
        }
        [ massiveHeader options [] [ text "Massive Header" ]
        , wireframeShortParagraph
        , hugeHeader options [] [ text "Huge Header" ]
        , wireframeShortParagraph
        , bigHeader options [] [ text "Big Header" ]
        , wireframeShortParagraph
        , largeHeader options [] [ text "Large Header" ]
        , wireframeShortParagraph
        , mediumHeader options [] [ text "Medium Header" ]
        , wireframeShortParagraph
        , smallHeader options [] [ text "Small Header" ]
        , wireframeShortParagraph
        , tinyHeader options [] [ text "Tiny Header" ]
        , wireframeShortParagraph
        , miniHeader options [] [ text "Mini Header" ]
        , wireframeShortParagraph
        ]
    , example
        { title = "Icon Headers"
        , description = "A header can be formatted to emphasize an icon"
        }
        [ iconHeader options
            []
            [ icon [] "fas fa-cogs"
            , iconHeaderContent []
                [ text "Account Settings"
                , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
                ]
            ]
        ]
    , example
        { title = "Subheader"
        , description = "Headers may contain subheaders"
        }
        [ Header.header options
            []
            [ text "Account Settings"
            , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
            , wireframeShortParagraph
            ]
        ]
    ]
