module Pages.Views.Item exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, span, text)
import Html.Styled.Attributes exposing (src)
import Page
import Request exposing (Request)
import Shared
import UI.Checkbox exposing (checkbox)
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
    = ToggleHasImage
    | ToggleHasHeader
    | ToggleHasMetadata
    | ToggleHasDescription
    | ToggleHasExtraContent


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleHasImage ->
            { model | hasImage = not model.hasImage }

        ToggleHasHeader ->
            { model | hasHeader = not model.hasHeader }

        ToggleHasMetadata ->
            { model | hasMetadata = not model.hasMetadata }

        ToggleHasDescription ->
            { model | hasDescription = not model.hasDescription }

        ToggleHasExtraContent ->
            { model | hasExtraContent = not model.hasExtraContent }



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview
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
        , configs =
            [ { label = "Content"
              , fields =
                    [ { label = ""
                      , description = "An item can contain an image"
                      , content =
                            checkbox
                                { id = "image"
                                , label = "Image"
                                , checked = model.hasImage
                                , onClick = ToggleHasImage
                                }
                      }
                    , { label = ""
                      , description = "An item can contain a header"
                      , content =
                            checkbox
                                { id = "header"
                                , label = "Header"
                                , checked = model.hasHeader
                                , onClick = ToggleHasHeader
                                }
                      }
                    , { label = ""
                      , description = "An item can contain content metadata"
                      , content =
                            checkbox
                                { id = "metadata"
                                , label = "Metadata"
                                , checked = model.hasMetadata
                                , onClick = ToggleHasMetadata
                                }
                      }
                    , { label = ""
                      , description = "An item can contain a description with a single or multiple paragraphs"
                      , content =
                            checkbox
                                { id = "description"
                                , label = "Description"
                                , checked = model.hasDescription
                                , onClick = ToggleHasDescription
                                }
                      }
                    , { label = ""
                      , description = "An item can contain content ExtraContent"
                      , content =
                            checkbox
                                { id = "extra_content"
                                , label = "Extra Content"
                                , checked = model.hasExtraContent
                                , onClick = ToggleHasExtraContent
                                }
                      }
                    ]
              }
            ]
        }
    ]
