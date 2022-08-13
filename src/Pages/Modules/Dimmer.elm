module Pages.Modules.Dimmer exposing (Model, Msg, page)

import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (src)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import UI.Button exposing (button)
import UI.Dimmer as Dimmer exposing (dimmer, pageDimmer)
import UI.Example exposing (wireframeMediaParagraph, wireframeShortParagraph)
import UI.Header as Header exposing (iconHeader, subHeader)
import UI.Icon exposing (icon)
import UI.Image exposing (smallImage)
import UI.Segment exposing (segment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init shared
        , update = update
        , view =
            \model ->
                { title = "Dimmer"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { shared : Shared.Model
    , toggledItems : List String
    }


init : Shared.Model -> Model
init shared =
    { shared = shared
    , toggledItems = []
    }



-- UPDATE


type Msg
    = Toggle String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle newItem ->
            { model
                | toggledItems =
                    if List.member newItem model.toggledItems then
                        List.filter ((/=) newItem) model.toggledItems

                    else
                        newItem :: model.toggledItems
            }



-- VIEW


view : Model -> List (Html Msg)
view { shared, toggledItems } =
    let
        options =
            { theme = shared.theme }
    in
    [ configAndPreview { title = "Dimmer" }
        [ segment options
            []
            [ Header.header options [] [ text "Overlayable Section" ]
            , div [] <|
                List.repeat 1 (smallImage [ src "/static/images/wireframe/image.png" ] [])
            , wireframeMediaParagraph
            , dimmer { isActive = List.member "dimmer" toggledItems, theme = Light } [ onClick (Toggle "dimmer") ] []
            ]
        , button [ onClick (Toggle "dimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
        []
    , configAndPreview { title = "Content Dimmer" }
        [ segment options
            []
            [ Header.header options [] [ text "Overlayable Section" ]
            , div [] <|
                List.repeat 1 (smallImage [ src "/static/images/wireframe/image.png" ] [])
            , wireframeMediaParagraph
            , dimmer { isActive = List.member "contentDimmer" toggledItems, theme = Light }
                [ onClick (Toggle "contentDimmer") ]
                [ Dimmer.content []
                    [ iconHeader { theme = Dark }
                        []
                        [ icon [] "fas fa-heart", text "Dimmed Message!" ]
                    ]
                ]
            ]
        , button [ onClick (Toggle "contentDimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
        []
    , configAndPreview { title = "Page Dimmer" }
        [ button [ onClick (Toggle "pageDimmer") ] [ icon [] "fas fa-plus", text "Show" ]
        , pageDimmer { isActive = List.member "pageDimmer" toggledItems, toggle = Toggle "pageDimmer" }
            []
            [ iconHeader { theme = Dark }
                []
                [ icon [] "fas fa-envelope"
                , text "Dimmer Message"
                , subHeader { theme = Dark }
                    []
                    [ text "Dimmer sub-header" ]
                ]
            ]
        ]
        []
    , configAndPreview { title = "Inverted Dimmer" }
        [ segment options
            []
            [ wireframeShortParagraph
            , wireframeShortParagraph
            , dimmer { isActive = List.member "invertedDimmer" toggledItems, theme = Dark }
                [ onClick (Toggle "invertedDimmer") ]
                []
            ]
        , button [ onClick (Toggle "invertedDimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
        []
    ]
