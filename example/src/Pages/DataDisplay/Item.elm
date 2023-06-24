module Pages.DataDisplay.Item exposing (Model, Msg, page)

import Data.DummyData as DummyData
import Effect
import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (src)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Image exposing (image)
import UI.Item as Item exposing (..)


layout : Model -> Layout msg
layout model =
    Layouts.Default {}


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Item"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



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
    [ playground
        { title = "Items"
        , theme = theme
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
        , configSections =
            [ { label = "Content"
              , configs =
                    [ Playground.bool
                        { label = "Image"
                        , id = "image"
                        , bool = config.hasImage
                        , onClick = (\c -> { c | hasImage = not c.hasImage }) |> UpdateConfig
                        , note = "An item can contain an image"
                        }
                    , Playground.boolAndString
                        { label = "Header"
                        , id = "header"
                        , data = config.header
                        , onUpdate = (\data -> \c -> { c | header = data }) >> UpdateConfig
                        , placeholder = "12 Years a Slave"
                        , note = ""
                        }
                    , Playground.boolAndString
                        { label = "Metadata"
                        , id = "metadata"
                        , data = config.metadata
                        , onUpdate = (\data -> \c -> { c | metadata = data }) >> UpdateConfig
                        , placeholder = "Union Square 14"
                        , note = ""
                        }
                    , Playground.boolAndString
                        { label = "Description"
                        , id = "description"
                        , data = config.description
                        , onUpdate = (\data -> \c -> { c | description = data }) >> UpdateConfig
                        , placeholder = "An item can contain a description"
                        , note = ""
                        }
                    , Playground.boolAndString
                        { label = "Extra Content"
                        , id = "extra_content"
                        , data = config.extraContent
                        , onUpdate = (\data -> \c -> { c | extraContent = data }) >> UpdateConfig
                        , placeholder = "Extra Content"
                        , note = ""
                        }
                    ]
              }
            ]
        }
    ]
