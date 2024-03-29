module Page.Element.Dimmer exposing (Model, Msg, init, update, view)

import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (src)
import Html.Styled.Events exposing (onClick)
import Playground exposing (playground)
import Shared
import UI.Button exposing (button)
import UI.Dimmer as Dimmer exposing (dimmer, pageDimmer)
import UI.Example exposing (wireframeMediaParagraph, wireframeShortParagraph)
import UI.Header as Header exposing (iconHeader, subHeader)
import UI.Icon exposing (icon)
import UI.Image exposing (smallImage)
import UI.Segment exposing (segment)



-- INIT


type alias Model =
    { toggledItems : List String }


init : Model
init =
    { toggledItems = [] }



-- UPDATE


type Msg
    = Toggle String
    | UpdateProps (Model -> Model)


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

        UpdateProps updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view shared { toggledItems } =
    let
        options =
            { theme = shared.theme }
    in
    [ Header.header options [] [ text "Dimmer" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ segment options
                []
                [ Header.header options [] [ text "Overlayable Section" ]
                , div [] <|
                    List.repeat 1 (smallImage [ src "/images/wireframe/image.png" ] [])
                , wireframeMediaParagraph
                , dimmer { isActive = List.member "dimmer" toggledItems, theme = Light } [ onClick (Toggle "dimmer") ] []
                ]
            , button [ onClick (Toggle "dimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
            ]
        , controlSections = []
        }
    , Header.header options [] [ text "Content Dimmer" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ segment options
                []
                [ Header.header options [] [ text "Overlayable Section" ]
                , div [] <|
                    List.repeat 1 (smallImage [ src "/images/wireframe/image.png" ] [])
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
        , controlSections = []
        }
    , Header.header options [] [ text "Page Dimmer" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
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
        , controlSections = []
        }
    , Header.header options [] [ text "Inverted Dimmer" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
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
        , controlSections = []
        }
    ]
