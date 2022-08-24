module Pages.Views.Card exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (src)
import Page
import Request exposing (Request)
import Shared
import UI.Card as Card exposing (cards, extraContent)
import UI.Checkbox exposing (checkbox)
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
    [ configAndPreview
        { title = "Cards"
        , preview =
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
        , configs =
            [ { label = "Content"
              , fields =
                    [ { label = ""
                      , description = "A card can contain an image"
                      , content =
                            checkbox
                                { id = "image"
                                , label = "Image"
                                , checked = model.hasImage
                                , onClick = ToggleHasImage
                                }
                      }
                    , { label = ""
                      , description = "A card can contain a header"
                      , content =
                            checkbox
                                { id = "header"
                                , label = "Header"
                                , checked = model.hasHeader
                                , onClick = ToggleHasHeader
                                }
                      }
                    , { label = ""
                      , description = "A card can contain content metadata"
                      , content =
                            checkbox
                                { id = "metadata"
                                , label = "Metadata"
                                , checked = model.hasMetadata
                                , onClick = ToggleHasMetadata
                                }
                      }
                    , { label = ""
                      , description = "A card can contain a description with one or more paragraphs"
                      , content =
                            checkbox
                                { id = "description"
                                , label = "Description"
                                , checked = model.hasDescription
                                , onClick = ToggleHasDescription
                                }
                      }
                    , { label = ""
                      , description = "A card can contain extra content meant to be formatted separately from the main content"
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
