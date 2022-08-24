module Pages.Views.Card exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (checked, for, id, src, type_)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import UI.Card as Card exposing (cards, extraContent)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Icon exposing (icon)
import UI.Image exposing (image)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Card"
                , body = view shared model
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


view : Shared.Model -> Model -> List (Html Msg)
view shared model =
    let
        options =
            { theme = shared.theme }

        card { header, metadata, description_, friends, imageUrl } =
            Card.card options
                []
                [ if model.hasImage then
                    image [ src imageUrl ] []

                  else
                    text ""
                , Card.content options
                    []
                    { header =
                        if model.hasHeader then
                            [ text header ]

                        else
                            []
                    , meta =
                        if model.hasMetadata then
                            [ text metadata ]

                        else
                            []
                    , description =
                        if model.hasDescription then
                            [ text description_ ]

                        else
                            []
                    }
                , if model.hasExtraContent then
                    extraContent options
                        []
                        [ icon [] "fas fa-user"
                        , text (String.fromInt friends ++ " Friends")
                        ]

                  else
                    text ""
                ]
    in
    [ configAndPreview { title = "Cards" }
        [ cards [] <|
            List.map card
                [ { header = "Matt Giampietro"
                  , metadata = "Friends"
                  , description_ = "Matthew is an interior designer living in New York."
                  , friends = 75
                  , imageUrl = "/static/images/avatar/matthew.png"
                  }
                , { header = "Molly"
                  , metadata = "Coworker"
                  , description_ = "Molly is a personal assistant living in Paris."
                  , friends = 35
                  , imageUrl = "/static/images/avatar/molly.png"
                  }
                , { header = "Elyse"
                  , metadata = "Coworker"
                  , description_ = "Elyse is a copywriter working in New York."
                  , friends = 151
                  , imageUrl = "/static/images/avatar/elyse.png"
                  }
                , { header = "Kristy"
                  , metadata = "Friends"
                  , description_ = "Kristy is an art director living in New York."
                  , friends = 22
                  , imageUrl = "/static/images/avatar/kristy.png"
                  }
                ]
        ]
        [ { label = "Content"
          , fields =
                [ { label = ""
                  , description = "A card can contain an image"
                  , content =
                        checkbox []
                            [ Checkbox.input [ id "image", type_ "checkbox", checked model.hasImage, onClick ToggleHasImage ] []
                            , Checkbox.label [ for "image" ] [ text "Image" ]
                            ]
                  }
                , { label = ""
                  , description = "A card can contain a header"
                  , content =
                        checkbox []
                            [ Checkbox.input [ id "header", type_ "checkbox", checked model.hasHeader, onClick ToggleHasHeader ] []
                            , Checkbox.label [ for "header" ] [ text "Header" ]
                            ]
                  }
                , { label = ""
                  , description = "A card can contain content metadata"
                  , content =
                        checkbox []
                            [ Checkbox.input [ id "metadata", type_ "checkbox", checked model.hasMetadata, onClick ToggleHasMetadata ] []
                            , Checkbox.label [ for "metadata" ] [ text "Metadata" ]
                            ]
                  }
                , { label = ""
                  , description = "A card can contain a description with one or more paragraphs"
                  , content =
                        checkbox []
                            [ Checkbox.input [ id "description", type_ "checkbox", checked model.hasDescription, onClick ToggleHasDescription ] []
                            , Checkbox.label [ for "description" ] [ text "Description" ]
                            ]
                  }
                , { label = ""
                  , description = "A card can contain extra content meant to be formatted separately from the main content"
                  , content =
                        checkbox []
                            [ Checkbox.input [ id "extra_content", type_ "checkbox", checked model.hasExtraContent, onClick ToggleHasExtraContent ] []
                            , Checkbox.label [ for "extra_content" ] [ text "ExtraContent" ]
                            ]
                  }
                ]
          }
        ]
    ]
