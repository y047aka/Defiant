module Pages.Modules.Dimmer exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (src)
import Html.Styled.Events exposing (onClick)
import Shared exposing (Shared)
import UI.Button exposing (button)
import UI.Dimmer as Dimmer exposing (dimmer, pageDimmer)
import UI.Example exposing (example, wireframeMediaParagraph, wireframeShortParagraph)
import UI.Header as Header exposing (iconHeader, subHeader)
import UI.Icon exposing (icon)
import UI.Image exposing (smallImage)
import UI.Segment exposing (segment)


architecture : Architecture Model Msg
architecture =
    { init = init
    , update = update
    , view = view
    }


type alias Model =
    { shared : Shared
    , toggledItems : List String
    }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared
      , toggledItems = []
      }
    , Cmd.none
    )


type Msg
    = Toggle String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle newItem ->
            ( { model
                | toggledItems =
                    if List.member newItem model.toggledItems then
                        List.filter ((/=) newItem) model.toggledItems

                    else
                        newItem :: model.toggledItems
              }
            , Cmd.none
            )


view : Model -> List (Html Msg)
view { shared, toggledItems } =
    let
        options =
            { inverted = shared.darkMode }
    in
    [ example
        { title = "Dimmer"
        , description = "A simple dimmer displays no content"
        }
        [ segment options
            []
            [ Header.header options [] [ text "Overlayable Section" ]
            , div [] <|
                List.repeat 1 (smallImage [ src "./static/images/wireframe/image.png" ] [])
            , wireframeMediaParagraph
            , dimmer { isActive = List.member "dimmer" toggledItems, inverted = False } [ onClick (Toggle "dimmer") ] []
            ]
        , button [ onClick (Toggle "dimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
    , example
        { title = "Content Dimmer"
        , description = "A dimmer can display content"
        }
        [ segment options
            []
            [ Header.header options [] [ text "Overlayable Section" ]
            , div [] <|
                List.repeat 1 (smallImage [ src "./static/images/wireframe/image.png" ] [])
            , wireframeMediaParagraph
            , dimmer { isActive = List.member "contentDimmer" toggledItems, inverted = False }
                [ onClick (Toggle "contentDimmer") ]
                [ Dimmer.content []
                    [ iconHeader { inverted = True }
                        []
                        [ icon [] "fas fa-heart", text "Dimmed Message!" ]
                    ]
                ]
            ]
        , button [ onClick (Toggle "contentDimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
    , example
        { title = "Page Dimmer"
        , description = "A dimmer can be formatted to be fixed to the page"
        }
        [ button [ onClick (Toggle "pageDimmer") ] [ icon [] "fas fa-plus", text "Show" ]
        , pageDimmer (List.member "pageDimmer" toggledItems)
            [ onClick (Toggle "pageDimmer") ]
            [ iconHeader { inverted = True }
                []
                [ icon [] "fas fa-envelope"
                , text "Dimmer Message"
                , subHeader { inverted = True }
                    []
                    [ text "Dimmer sub-header" ]
                ]
            ]
        ]
    , example
        { title = "Inverted Dimmer"
        , description = "A dimmer can be formatted to have its colors inverted"
        }
        [ segment options
            []
            [ wireframeShortParagraph
            , wireframeShortParagraph
            , dimmer { isActive = List.member "invertedDimmer" toggledItems, inverted = True }
                [ onClick (Toggle "invertedDimmer") ]
                []
            ]
        , button [ onClick (Toggle "invertedDimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
    ]
