module Pages.DataDisplay.Card exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (src)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Card as Card exposing (cards, extraContent)
import UI.Icon exposing (icon)
import UI.Image exposing (image)
import View.Playground exposing (playground)


page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Card"
                , body = view shared model
                }
        }



-- INIT


type alias Model =
    { inverted : Bool
    , hasImage : Bool
    , hasHeader : Bool
    , hasMetadata : Bool
    , hasDescription : Bool
    , hasExtraContent : Bool
    }


init : Model
init =
    { inverted = False
    , hasImage = True
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


view : Shared.Model -> Model -> List (Html Msg)
view shared model =
    let
        options =
            { theme =
                if model.inverted then
                    Dark

                else
                    shared.theme
            }

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
    [ playground
        { title = "Cards"
        , toMsg = UpdateConfig
        , theme = shared.theme
        , inverted = model.inverted
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
                      , note = "A card can contain an image"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "header"
                                , label = "Header"
                                , bool = model.hasHeader
                                , setter = \m -> { m | hasHeader = not m.hasHeader }
                                }
                      , note = "A card can contain a header"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "metadata"
                                , label = "Metadata"
                                , bool = model.hasMetadata
                                , setter = \m -> { m | hasMetadata = not m.hasMetadata }
                                }
                      , note = "A card can contain content metadata"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "description"
                                , label = "Description"
                                , bool = model.hasDescription
                                , setter = \m -> { m | hasDescription = not m.hasDescription }
                                }
                      , note = "A card can contain a description with one or more paragraphs"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "extra_content"
                                , label = "Extra Content"
                                , bool = model.hasExtraContent
                                , setter = \m -> { m | hasExtraContent = not m.hasExtraContent }
                                }
                      , note = "A card can contain extra content meant to be formatted separately from the main content"
                      }
                    ]
              }
            ]
        }
    ]
