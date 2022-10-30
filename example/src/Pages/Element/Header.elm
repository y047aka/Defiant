module Pages.Element.Header exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, text)
import Page
import Request exposing (Request)
import Shared
import Types exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
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
    { label : String, size : Size }


init : Model
init =
    { label = "Heading", size = Medium }



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
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Content Headers"
        , preview =
            [ headerWithProps { size = model.size, theme = theme } [] [ text <| sizeToString model.size ++ " " ++ model.label ]
            , wireframeShortParagraph
            ]
        , configSections =
            [ { label = "Content"
              , configs =
                    [ { label = "Header"
                      , config =
                            Config.string
                                { label = ""
                                , value = model.label
                                , setter = \string m -> { m | label = string }
                                }
                      , note = ""
                      }
                    ]
              }
            , { label = "Variations"
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
