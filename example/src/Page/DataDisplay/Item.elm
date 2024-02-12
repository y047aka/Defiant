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
    { config : Config
    , movies : List { header : String, metadata : String }
    }


type alias Config =
    { header : { visible : Bool, value : String }
    , metadata : { visible : Bool, value : String }
    , description : { visible : Bool, value : String }
    , extraContent : { visible : Bool, value : String }
    , hasImage : Bool
    }


init : Model
init =
    { config =
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
    = UpdateConfig (Config -> Config)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            { model | config = updater model.config }



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } { config, movies } =
    [ Header.header { theme = theme } [] [ text "Items" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ let
                item { header, metadata } =
                    Item.item []
                        [ if config.hasImage then
                            image [ src "/images/wireframe/image.png" ] []

                          else
                            text ""
                        , Item.content []
                            { header =
                                case ( config.header.visible, config.header.value ) of
                                    ( True, "" ) ->
                                        [ text header ]

                                    ( True, value ) ->
                                        [ text value ]

                                    ( False, _ ) ->
                                        []
                            , meta =
                                case ( config.metadata.visible, config.metadata.value ) of
                                    ( True, "" ) ->
                                        [ span [] [ text metadata ] ]

                                    ( True, value ) ->
                                        [ text value ]

                                    ( False, _ ) ->
                                        []
                            , description =
                                case ( config.description.visible, config.description.value ) of
                                    ( True, "" ) ->
                                        [ wireframeShortParagraph ]

                                    ( True, value ) ->
                                        [ text value ]

                                    ( False, _ ) ->
                                        []
                            , extra =
                                if config.extraContent.visible then
                                    [ text config.extraContent.value ]

                                else
                                    []
                            }
                        ]
              in
              items [] <| List.map item movies
            ]
        , controlSections =
            [ { label = "Content"
              , configs =
                    [ Control.field "Image"
                        (Control.bool
                            { id = "image"
                            , value = config.hasImage
                            , onClick = (\ps -> { ps | hasImage = not ps.hasImage }) |> UpdateConfig
                            }
                        )
                    , Control.comment "An item can contain an image"
                    , Control.boolAndString
                        { label = "Header"
                        , id = "header"
                        , data = config.header
                        , onUpdate = (\data -> \ps -> { ps | header = data }) >> UpdateConfig
                        , placeholder = "12 Years a Slave"
                        }
                    , Control.boolAndString
                        { label = "Metadata"
                        , id = "metadata"
                        , data = config.metadata
                        , onUpdate = (\data -> \ps -> { ps | metadata = data }) >> UpdateConfig
                        , placeholder = "Union Square 14"
                        }
                    , Control.boolAndString
                        { label = "Description"
                        , id = "description"
                        , data = config.description
                        , onUpdate = (\data -> \ps -> { ps | description = data }) >> UpdateConfig
                        , placeholder = "An item can contain a description"
                        }
                    , Control.boolAndString
                        { label = "Extra Content"
                        , id = "extra_content"
                        , data = config.extraContent
                        , onUpdate = (\data -> \ps -> { ps | extraContent = data }) >> UpdateConfig
                        , placeholder = "Extra Content"
                        }
                    ]
              }
            ]
        }
    ]
