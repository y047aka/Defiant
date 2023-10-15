module Page.DataDisplay.Card exposing (Model, Msg, init, update, view)

import Data.DummyData as DummyData
import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, text)
import Html.Styled.Attributes exposing (src)
import Playground exposing (playground)
import Props
import Shared
import UI.Card as Card exposing (cards, extraContent)
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Image exposing (image)



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
    , header : { visible : Bool, value : String }
    , metadata : { visible : Bool, value : String }
    , description : { visible : Bool, value : String }
    , extraContent : { visible : Bool, value : String }
    }


init : Model
init =
    { config =
        { inverted = False
        , hasImage = True
        , header = { visible = True, value = "" }
        , metadata = { visible = True, value = "" }
        , description = { visible = True, value = "" }
        , extraContent = { visible = True, value = "" }
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
                                [ text metadata ]

                            ( True, value ) ->
                                [ text value ]

                            ( False, _ ) ->
                                []
                    , description =
                        case ( config.description.visible, config.description.value ) of
                            ( True, "" ) ->
                                [ text description ]

                            ( True, value ) ->
                                [ text value ]

                            ( False, _ ) ->
                                []
                    }
                , case ( config.extraContent.visible, config.extraContent.value ) of
                    ( True, "" ) ->
                        extraContent options
                            []
                            [ icon [] "fas fa-user"
                            , text (String.fromInt friends ++ " Friends")
                            ]

                    ( True, value ) ->
                        extraContent options [] [ text value ]

                    ( False, _ ) ->
                        text ""
                ]
    in
    [ Header.header { theme = shared.theme } [] [ text "Cards" ]
    , playground
        { theme = shared.theme
        , inverted = config.inverted
        , preview = [ cards [] (List.map card people) ]
        , configSections =
            [ { label = ""
              , configs =
                    [ Props.bool
                        { label = "Inverted"
                        , value = config.inverted
                        , onClick = (\ps -> { ps | inverted = not ps.inverted }) |> UpdateConfig
                        }
                    ]
              }
            , { label = "Content"
              , configs =
                    [ Props.field
                        { label = ""
                        , props =
                            Props.bool
                                { label = "Image"
                                , value = config.hasImage
                                , onClick = (\ps -> { ps | hasImage = not ps.hasImage }) |> UpdateConfig
                                }
                        , note = "A card can contain an image"
                        }
                    , Props.boolAndString
                        { label = "Header"
                        , id = "header"
                        , data = config.header
                        , onUpdate = (\data -> \ps -> { ps | header = data }) >> UpdateConfig
                        , placeholder = "Matt Giampietro"
                        }
                    , Props.boolAndString
                        { label = "Metadata"
                        , id = "metadata"
                        , data = config.metadata
                        , onUpdate = (\data -> \ps -> { ps | metadata = data }) >> UpdateConfig
                        , placeholder = "Friends"
                        }
                    , Props.field
                        { label = ""
                        , props =
                            Props.boolAndString
                                { label = "Description"
                                , id = "description"
                                , data = config.description
                                , onUpdate = (\data -> \ps -> { ps | description = data }) >> UpdateConfig
                                , placeholder = "Matthew is an interior designer living in New York."
                                }
                        , note = "A card can contain a description with one or more paragraphs"
                        }
                    , Props.field
                        { label = ""
                        , props =
                            Props.boolAndString
                                { label = "Extra Content"
                                , id = "extra_content"
                                , data = config.extraContent
                                , onUpdate = (\data -> \ps -> { ps | extraContent = data }) >> UpdateConfig
                                , placeholder = "75 Friends"
                                }
                        , note = "A card can contain extra content meant to be formatted separately from the main content"
                        }
                    ]
              }
            ]
        }
    ]
