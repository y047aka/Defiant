module Pages.Views.Item exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, span, text)
import Html.Styled.Attributes exposing (checked, for, id, src, type_)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import UI.Checkbox as Checkbox exposing (checkbox)
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
                            checkbox []
                                [ Checkbox.input [ id "image", type_ "checkbox", checked model.hasImage, onClick ToggleHasImage ] []
                                , Checkbox.label [ for "image" ] [ text "Image" ]
                                ]
                      }
                    , { label = ""
                      , description = "An item can contain a header"
                      , content =
                            checkbox []
                                [ Checkbox.input [ id "header", type_ "checkbox", checked model.hasHeader, onClick ToggleHasHeader ] []
                                , Checkbox.label [ for "header" ] [ text "Header" ]
                                ]
                      }
                    , { label = ""
                      , description = "An item can contain content metadata"
                      , content =
                            checkbox []
                                [ Checkbox.input [ id "metadata", type_ "checkbox", checked model.hasMetadata, onClick ToggleHasMetadata ] []
                                , Checkbox.label [ for "metadata" ] [ text "Metadata" ]
                                ]
                      }
                    , { label = ""
                      , description = "An item can contain a description with a single or multiple paragraphs"
                      , content =
                            checkbox []
                                [ Checkbox.input [ id "description", type_ "checkbox", checked model.hasDescription, onClick ToggleHasDescription ] []
                                , Checkbox.label [ for "description" ] [ text "Description" ]
                                ]
                      }
                    , { label = ""
                      , description = "An item can contain content ExtraContent"
                      , content =
                            checkbox []
                                [ Checkbox.input [ id "extra_content", type_ "checkbox", checked model.hasExtraContent, onClick ToggleHasExtraContent ] []
                                , Checkbox.label [ for "extra_content" ] [ text "ExtraContent" ]
                                ]
                      }
                    ]
              }
            ]
        }
    ]
