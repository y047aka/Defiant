module Pages.Elements.Header exposing (Model, Msg, page)

import Data exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import Html.Styled as Html exposing (Html, div, option, select, text)
import Html.Styled.Attributes exposing (selected, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Header as Header exposing (..)
import UI.Icon exposing (icon)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Header"
                , body = view shared model
                }
        }



-- INIT


type alias Model =
    { size : Size }


init : Model
init =
    { size = Medium }



-- UPDATE


type Msg
    = ChangeSize Size


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeSize size ->
            { model | size = size }



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    let
        options =
            { theme = theme }
    in
    [ configAndPreview { title = "Content Headers" }
        (div [] <|
            [ case model.size of
                Massive ->
                    massiveHeader options [] [ text "Massive Header" ]

                Huge ->
                    hugeHeader options [] [ text "Huge Header" ]

                Big ->
                    bigHeader options [] [ text "Big Header" ]

                Large ->
                    largeHeader options [] [ text "Large Header" ]

                Medium ->
                    mediumHeader options [] [ text "Medium Header" ]

                Small ->
                    smallHeader options [] [ text "Small Header" ]

                Tiny ->
                    tinyHeader options [] [ text "Tiny Header" ]

                Mini ->
                    miniHeader options [] [ text "Mini Header" ]
            , wireframeShortParagraph
            ]
        )
        [ { label = "Size"
          , description = "Text can vary in the same sizes as icons"
          , content =
                select [ onInput (sizeFromString >> Maybe.withDefault model.size >> ChangeSize) ] <|
                    List.map (\state -> option [ value (sizeToString state), selected (model.size == state) ] [ text (sizeToString state) ])
                        [ Massive, Huge, Big, Large, Medium, Small, Tiny, Mini ]
          }
        ]
    , configAndPreview { title = "Icon Headers" }
        (iconHeader options
            []
            [ icon [] "fas fa-cogs"
            , iconHeaderContent []
                [ text "Account Settings"
                , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
                ]
            ]
        )
        []
    , configAndPreview { title = "Subheader" }
        (Header.header options
            []
            [ text "Account Settings"
            , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
            , wireframeShortParagraph
            ]
        )
        []
    ]
