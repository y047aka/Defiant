module Pages.DataDisplay.Item exposing (Model, Msg, page)

import Config
import Effect
import Html.Styled as Html exposing (Html, span, text)
import Html.Styled.Attributes exposing (src)
import Layouts exposing (Layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Image exposing (image)
import UI.Item as Item exposing (..)
import View.ConfigAndPreview exposing (configAndPreview)


layout : Model -> Layout
layout model =
    Layouts.Default { default = () }


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
    { hasImage : Bool
    , hasHeader : Bool
    , hasMetadata : Bool
    , hasDescription : Bool
    , hasExtraContent : Bool
    }


init : Model
init =
    { hasImage = True
    , hasHeader = True
    , hasMetadata = True
    , hasDescription = True
    , hasExtraContent = True
    }



-- UPDATE


type Msg
    = UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ configAndPreview
        { title = "Items"
        , theme = theme
        , inverted = False
        , preview =
            [ let
                item { header, metadata } =
                    Item.item []
                        [ if model.hasImage then
                            image [ src "/images/wireframe/image.png" ] []

                          else
                            text ""
                        , Item.content []
                            { header =
                                if model.hasHeader then
                                    [ text header ]

                                else
                                    []
                            , meta =
                                if model.hasMetadata then
                                    [ span [] [ text metadata ] ]

                                else
                                    []
                            , description =
                                if model.hasDescription then
                                    [ wireframeShortParagraph ]

                                else
                                    []
                            , extra =
                                if model.hasExtraContent then
                                    [ text "Extra Content" ]

                                else
                                    []
                            }
                        ]
              in
              items []
                [ item
                    { header = "12 Years a Slave"
                    , metadata = "Union Square 14"
                    }
                , item
                    { header = "My Neighbor Totoro"
                    , metadata = "IFC Cinema"
                    }
                , item
                    { header = "Watchmen"
                    , metadata = "IFC"
                    }
                ]
            ]
        , configSections =
            [ { label = "Content"
              , configs =
                    [ Config.bool
                        { label = "Image"
                        , id = "image"
                        , bool = model.hasImage
                        , onClick = (\c -> { c | hasImage = not c.hasImage }) |> UpdateConfig
                        , note = "An item can contain an image"
                        }
                    , Config.bool
                        { label = "Header"
                        , id = "header"
                        , bool = model.hasHeader
                        , onClick = (\c -> { c | hasHeader = not c.hasHeader }) |> UpdateConfig
                        , note = "An item can contain a header"
                        }
                    , Config.bool
                        { label = "Metadata"
                        , id = "metadata"
                        , bool = model.hasMetadata
                        , onClick = (\c -> { c | hasMetadata = not c.hasMetadata }) |> UpdateConfig
                        , note = "An item can contain content metadata"
                        }
                    , Config.bool
                        { label = "Description"
                        , id = "description"
                        , bool = model.hasDescription
                        , onClick = (\c -> { c | hasDescription = not c.hasDescription }) |> UpdateConfig
                        , note = "An item can contain a description with a single or multiple paragraphs"
                        }
                    , Config.bool
                        { label = "Extra Content"
                        , id = "extra_content"
                        , bool = model.hasExtraContent
                        , onClick = (\c -> { c | hasExtraContent = not c.hasExtraContent }) |> UpdateConfig
                        , note = "An item can contain content ExtraContent"
                        }
                    ]
              }
            ]
        }
    ]
