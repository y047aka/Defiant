module Page.DataDisplay.Item exposing (Model, Msg, init, update, view)

import Control
import Data.DummyData as DummyData
import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (src)
import Playground exposing (playground)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Header as Header
import UI.Image exposing (image)
import UI.Item as Item exposing (..)



-- INIT


type alias Model =
    { props : Props
    , movies : List { header : String, metadata : String }
    }


type alias Props =
    { header : { visible : Bool, value : String }
    , metadata : { visible : Bool, value : String }
    , description : { visible : Bool, value : String }
    , extraContent : { visible : Bool, value : String }
    , hasImage : Bool
    }


init : Model
init =
    { props =
        { header = { visible = True, value = "" }
        , metadata = { visible = True, value = "" }
        , description = { visible = True, value = "" }
        , extraContent = { visible = True, value = "Extra Content" }
        , hasImage = True
        }
    , movies =
        List.map
            (\{ title, cinema } ->
                { header = title
                , metadata = cinema
                }
            )
            DummyData.movies
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
view { theme } { props, movies } =
    [ Header.header { theme = theme } [] [ text "Items" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ let
                item { header, metadata } =
                    Item.item []
                        [ if props.hasImage then
                            image [ src "/images/wireframe/image.png" ] []

                          else
                            text ""
                        , Item.content []
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
                                        [ span [] [ text metadata ] ]

                                    ( True, value ) ->
                                        [ text value ]

                                    ( False, _ ) ->
                                        []
                            , description =
                                case ( props.description.visible, props.description.value ) of
                                    ( True, "" ) ->
                                        [ wireframeShortParagraph ]

                                    ( True, value ) ->
                                        [ text value ]

                                    ( False, _ ) ->
                                        []
                            , extra =
                                if props.extraContent.visible then
                                    [ text props.extraContent.value ]

                                else
                                    []
                            }
                        ]
              in
              items [] <| List.map item movies
            ]
        , controlSections =
            [ { heading = "Content"
              , controls =
                    [ Control.field "Image"
                        (Control.bool
                            { id = "image"
                            , value = props.hasImage
                            , onClick = (\ps -> { ps | hasImage = not ps.hasImage }) |> UpdateProps
                            }
                        )
                    , Control.comment "An item can contain an image"
                    , Control.boolAndString
                        { label = "Header"
                        , id = "header"
                        , data = props.header
                        , onUpdate = (\data -> \ps -> { ps | header = data }) >> UpdateProps
                        , placeholder = "12 Years a Slave"
                        }
                    , Control.boolAndString
                        { label = "Metadata"
                        , id = "metadata"
                        , data = props.metadata
                        , onUpdate = (\data -> \ps -> { ps | metadata = data }) >> UpdateProps
                        , placeholder = "Union Square 14"
                        }
                    , Control.boolAndString
                        { label = "Description"
                        , id = "description"
                        , data = props.description
                        , onUpdate = (\data -> \ps -> { ps | description = data }) >> UpdateProps
                        , placeholder = "An item can contain a description"
                        }
                    , Control.boolAndString
                        { label = "Extra Content"
                        , id = "extra_content"
                        , data = props.extraContent
                        , onUpdate = (\data -> \ps -> { ps | extraContent = data }) >> UpdateProps
                        , placeholder = "Extra Content"
                        }
                    ]
              }
            ]
        }
    ]
