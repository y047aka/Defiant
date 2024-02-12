module Page.DataDisplay.Card exposing (Model, Msg, init, update, view)

import Control
import Data.DummyData as DummyData
import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, text)
import Html.Styled.Attributes exposing (src)
import Playground exposing (playground)
import Shared
import UI.Card as Card exposing (cards, extraContent)
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Image exposing (image)



-- INIT


type alias Model =
    { props : Props
    , people :
        List
            { header : String
            , metadata : String
            , description : String
            , friends : Int
            , imageUrl : String
            }
    }


type alias Props =
    { inverted : Bool
    , hasImage : Bool
    , header : { visible : Bool, value : String }
    , metadata : { visible : Bool, value : String }
    , description : { visible : Bool, value : String }
    , extraContent : { visible : Bool, value : String }
    }


init : Model
init =
    { props =
        { inverted = False
        , hasImage = True
        , header = { visible = True, value = "" }
        , metadata = { visible = True, value = "" }
        , description = { visible = True, value = "" }
        , extraContent = { visible = True, value = "" }
        }
    , people =
        List.map
            (\p ->
                { header = p.name
                , metadata = p.relation
                , description = p.introduction
                , friends = p.friends
                , imageUrl = p.imageUrl
                }
            )
            DummyData.people
    }



-- UPDATE


type Msg
    = UpdateProps (Props -> Props)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateProps updater ->
            { model | props = updater model.props }



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view shared { props, people } =
    let
        options =
            { theme =
                if props.inverted then
                    Dark

                else
                    shared.theme
            }

        card { header, metadata, description, friends, imageUrl } =
            Card.card options
                []
                [ if props.hasImage then
                    image [ src imageUrl ] []

                  else
                    text ""
                , Card.content options
                    []
                    { header =
                        case ( props.header.visible, props.header.value ) of
                            ( True, "" ) ->
                                [ text header ]

                            ( True, value ) ->
                                [ text value ]

                            ( False, _ ) ->
                                []
                    , meta =
                        case ( props.metadata.visible, props.metadata.value ) of
                            ( True, "" ) ->
                                [ text metadata ]

                            ( True, value ) ->
                                [ text value ]

                            ( False, _ ) ->
                                []
                    , description =
                        case ( props.description.visible, props.description.value ) of
                            ( True, "" ) ->
                                [ text description ]

                            ( True, value ) ->
                                [ text value ]

                            ( False, _ ) ->
                                []
                    }
                , case ( props.extraContent.visible, props.extraContent.value ) of
                    ( True, "" ) ->
                        extraContent options
                            []
                            [ icon [] "fas fa-user"
                            , text (String.fromInt friends ++ " Friends")
                            ]

                    ( True, value ) ->
                        extraContent options [] [ text value ]

                    ( False, _ ) ->
                        text ""
                ]
    in
    [ Header.header { theme = shared.theme } [] [ text "Cards" ]
    , playground
        { theme = shared.theme
        , inverted = props.inverted
        , preview = [ cards [] (List.map card people) ]
        , controlSections =
            [ { heading = ""
              , controls =
                    [ Control.field "Inverted"
                        (Control.bool
                            { id = "inverted"
                            , value = props.inverted
                            , onClick = (\ps -> { ps | inverted = not ps.inverted }) |> UpdateProps
                            }
                        )
                    ]
              }
            , { heading = "Content"
              , controls =
                    [ Control.field "Image"
                        (Control.bool
                            { id = "image"
                            , value = props.hasImage
                            , onClick = (\ps -> { ps | hasImage = not ps.hasImage }) |> UpdateProps
                            }
                        )
                    , Control.comment "A card can contain an image"
                    , Control.boolAndString
                        { label = "Header"
                        , id = "header"
                        , data = props.header
                        , onUpdate = (\data -> \ps -> { ps | header = data }) >> UpdateProps
                        , placeholder = "Matt Giampietro"
                        }
                    , Control.boolAndString
                        { label = "Metadata"
                        , id = "metadata"
                        , data = props.metadata
                        , onUpdate = (\data -> \ps -> { ps | metadata = data }) >> UpdateProps
                        , placeholder = "Friends"
                        }
                    , Control.boolAndString
                        { label = "Description"
                        , id = "description"
                        , data = props.description
                        , onUpdate = (\data -> \ps -> { ps | description = data }) >> UpdateProps
                        , placeholder = "Matthew is an interior designer living in New York."
                        }
                    , Control.comment "A card can contain a description with one or more paragraphs"
                    , Control.boolAndString
                        { label = "Extra Content"
                        , id = "extra_content"
                        , data = props.extraContent
                        , onUpdate = (\data -> \ps -> { ps | extraContent = data }) >> UpdateProps
                        , placeholder = "75 Friends"
                        }
                    , Control.comment "A card can contain extra content meant to be formatted separately from the main content"
                    ]
              }
            ]
        }
    ]
