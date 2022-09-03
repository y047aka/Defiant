module Pages.Views.Item exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, span, text)
import Html.Styled.Attributes exposing (src)
import Page
import Request exposing (Request)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Image exposing (image)
import UI.Item as Item exposing (..)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Item"
                , body = view model
                }
        }



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
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview UpdateConfig
        { title = "Items"
        , preview =
            [ let
                item { header, metadata } =
                    Item.item []
                        [ if model.hasImage then
                            image [ src "/static/images/wireframe/image.png" ] []

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
                    [ { label = ""
                      , config =
                            Config.bool
                                { id = "image"
                                , label = "Image"
                                , bool = model.hasImage
                                , setter = \m -> { m | hasImage = not m.hasImage }
                                }
                      , note = "An item can contain an image"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "header"
                                , label = "Header"
                                , bool = model.hasHeader
                                , setter = \m -> { m | hasHeader = not m.hasHeader }
                                }
                      , note = "An item can contain a header"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "metadata"
                                , label = "Metadata"
                                , bool = model.hasMetadata
                                , setter = \m -> { m | hasMetadata = not m.hasMetadata }
                                }
                      , note = "An item can contain content metadata"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "description"
                                , label = "Description"
                                , bool = model.hasDescription
                                , setter = \m -> { m | hasDescription = not m.hasDescription }
                                }
                      , note = "An item can contain a description with a single or multiple paragraphs"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "extra_content"
                                , label = "Extra Content"
                                , bool = model.hasExtraContent
                                , setter = \m -> { m | hasExtraContent = not m.hasExtraContent }
                                }
                      , note = "An item can contain content ExtraContent"
                      }
                    ]
              }
            ]
        }
    ]