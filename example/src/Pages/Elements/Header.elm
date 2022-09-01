module Pages.Elements.Header exposing (Model, Msg, page)

import Config
import Data exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import Html.Styled as Html exposing (Html, text)
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
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    let
        options =
            { theme = theme }
    in
    [ configAndPreview UpdateConfig
        { title = "Content Headers"
        , preview =
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
        , configSections =
            [ { label = "Variations"
              , configs =
                    [ { label = "Size"
                      , config =
                            Config.select
                                { value = model.size
                                , options = [ Massive, Huge, Big, Large, Medium, Small, Tiny, Mini ]
                                , fromString = sizeFromString
                                , toString = sizeToString
                                , setter = \size m -> { m | size = size }
                                }
                      , note = "Text can vary in the same sizes as icons"
                      }
                    ]
              }
            ]
        }
    , configAndPreview UpdateConfig
        { title = "Icon Headers"
        , preview =
            [ iconHeader options
                []
                [ icon [] "fas fa-cogs"
                , iconHeaderContent []
                    [ text "Account Settings"
                    , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
                    ]
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig
        { title = "Subheader"
        , preview =
            [ Header.header options
                []
                [ text "Account Settings"
                , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
                , wireframeShortParagraph
                ]
            ]
        , configSections = []
        }
    ]
