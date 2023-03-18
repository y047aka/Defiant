module Pages.DataDisplay.Card exposing (Model, Msg, page)

import Data.DummyData as DummyData
import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (src)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Card as Card exposing (cards, extraContent)
import UI.Icon exposing (icon)
import UI.Image exposing (image)


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
                { title = "Card"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    { config : Config
    , people :
        List
            { header : String
            , metadata : String
            , description : String
            , friends : Int
            , imageUrl : String
            }
    }


type alias Config =
    { inverted : Bool
    , hasImage : Bool
    , header : Bool
    , hasMetadata : Bool
    , hasDescription : Bool
    , hasExtraContent : Bool
    }


init : Model
init =
    { config =
        { inverted = False
        , hasImage = True
        , hasHeader = True
        , hasMetadata = True
        , hasDescription = True
        , hasExtraContent = True
        }
    , people =
        List.map
            (\p ->
                { header = p.name
                , metadata = p.relation
                , description = p.introduction
                , friends = p.friends
                , imageUrl = p.imageUrl
                }
            )
            DummyData.people
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
view shared { config, people } =
    let
        options =
            { theme =
                if config.inverted then
                    Dark

                else
                    shared.theme
            }

        card { header, metadata, description, friends, imageUrl } =
            Card.card options
                []
                [ if config.hasImage then
                    image [ src imageUrl ] []

                  else
                    text ""
                , Card.content options
                    []
                    { header =
                        if config.hasHeader then
                            [ text header ]

                        else
                            []
                    , meta =
                        if config.hasMetadata then
                            [ text metadata ]

                        else
                            []
                    , description =
                        if config.hasDescription then
                            [ text description ]

                        else
                            []
                    }
                , if config.hasExtraContent then
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
        , theme = shared.theme
        , inverted = config.inverted
        , preview = [ cards [] (List.map card people) ]
        , configSections =
            [ { label = ""
              , configs =
                    [ Playground.bool
                        { id = "inverted"
                        , label = "Inverted"
                        , bool = config.inverted
                        , onClick = (\c -> { c | inverted = not c.inverted }) |> UpdateConfig
                        , note = ""
                        }
                    ]
              }
            , { label = "Content"
              , configs =
                    [ Playground.bool
                        { label = "Image"
                        , id = "image"
                        , bool = config.hasImage
                        , onClick = (\c -> { c | hasImage = not c.hasImage }) |> UpdateConfig
                        , note = "A card can contain an image"
                        }
                    , Playground.bool
                        { label = "Header"
                        , id = "header"
                        , bool = config.header
                        , onClick = (\c -> { c | hasHeader = not c.hasHeader }) |> UpdateConfig
                        , note = "A card can contain a header"
                        }
                    , Playground.bool
                        { label = "Metadata"
                        , id = "metadata"
                        , bool = config.hasMetadata
                        , onClick = (\c -> { c | hasMetadata = not c.hasMetadata }) |> UpdateConfig
                        , note = "A card can contain content metadata"
                        }
                    , Playground.bool
                        { label = "Description"
                        , id = "description"
                        , bool = config.hasDescription
                        , onClick = (\c -> { c | hasDescription = not c.hasDescription }) |> UpdateConfig
                        , note = "A card can contain a description with one or more paragraphs"
                        }
                    , Playground.bool
                        { label = "Extra Content"
                        , id = "extra_content"
                        , bool = config.hasExtraContent
                        , onClick = (\c -> { c | hasExtraContent = not c.hasExtraContent }) |> UpdateConfig
                        , note = "A card can contain extra content meant to be formatted separately from the main content"
                        }
                    ]
              }
            ]
        }
    ]
