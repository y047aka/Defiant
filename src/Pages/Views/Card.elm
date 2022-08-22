module Pages.Views.Card exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, text)
import Html.Styled.Attributes exposing (checked, for, id, name, src, type_)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import UI.Card as Card exposing (card, cards, extraContent)
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
    in
    [ configAndPreview { title = "Card" }
        [ card options
            []
            [ if model.hasImage then
                image [ src "/static/images/avatar/kristy.png" ] []

              else
                text ""
            , Card.content options
                []
                { header =
                    if model.hasHeader then
                        [ text "Kristy" ]

                    else
                        []
                , meta =
                    if model.hasMetadata then
                        [ text "Joined in 2013" ]

                    else
                        []
                , description =
                    if model.hasDescription then
                        [ text "Kristy is an art director living in New York." ]

                    else
                        []
                }
            , if model.hasExtraContent then
                extraContent options
                    []
                    [ icon [] "fas fa-user"
                    , text "22 Friends"
                    ]

              else
                text ""
            ]
        ]
        [ { label = "Image"
          , description = "A card can contain an image"
          , content =
                checkbox []
                    [ Checkbox.input [ id "image", type_ "checkbox", checked model.hasImage, onClick ToggleHasImage ] []
                    , Checkbox.label [ for "image" ] [ text "Image" ]
                    ]
          }
        , { label = "Header"
          , description = "A card can contain a header"
          , content =
                checkbox []
                    [ Checkbox.input [ id "header", type_ "checkbox", checked model.hasHeader, onClick ToggleHasHeader ] []
                    , Checkbox.label [ for "header" ] [ text "Header" ]
                    ]
          }
        , { label = "Metadata"
          , description = "A card can contain content metadata"
          , content =
                checkbox []
                    [ Checkbox.input [ id "metadata", type_ "checkbox", checked model.hasMetadata, onClick ToggleHasMetadata ] []
                    , Checkbox.label [ for "metadata" ] [ text "Metadata" ]
                    ]
          }
        , { label = "Description"
          , description = "A card can contain a description with one or more paragraphs"
          , content =
                checkbox []
                    [ Checkbox.input [ id "description", type_ "checkbox", checked model.hasDescription, onClick ToggleHasDescription ] []
                    , Checkbox.label [ for "description" ] [ text "Description" ]
                    ]
          }
        , { label = "Extra Content"
          , description = "A card can contain extra content meant to be formatted separately from the main content"
          , content =
                checkbox []
                    [ Checkbox.input [ id "extra_content", type_ "checkbox", checked model.hasExtraContent, onClick ToggleHasExtraContent ] []
                    , Checkbox.label [ for "extra_content" ] [ text "ExtraContent" ]
                    ]
          }
        ]
    , configAndPreview { title = "Cards" }
        [ cards [] <|
            List.map
                (\{ name, type_, description_, friends, imageUrl } ->
                    card options
                        []
                        [ image [ src imageUrl ] []
                        , Card.content options
                            []
                            { header = [ text name ]
                            , meta = [ text type_ ]
                            , description = [ text description_ ]
                            }
                        , extraContent options
                            []
                            [ icon [] "fas fa-user"
                            , text (String.fromInt friends ++ " Friends")
                            ]
                        ]
                )
                [ { name = "Matt Giampietro"
                  , type_ = "Friends"
                  , description_ = "Matthew is an interior designer living in New York."
                  , friends = 75
                  , imageUrl = "/static/images/avatar/matthew.png"
                  }
                , { name = "Molly"
                  , type_ = "Coworker"
                  , description_ = "Molly is a personal assistant living in Paris."
                  , friends = 35
                  , imageUrl = "/static/images/avatar/molly.png"
                  }
                , { name = "Elyse"
                  , type_ = "Coworker"
                  , description_ = "Elyse is a copywriter working in New York."
                  , friends = 151
                  , imageUrl = "/static/images/avatar/elyse.png"
                  }
                ]
        ]
        []
    ]
