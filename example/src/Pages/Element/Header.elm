module Pages.Element.Header exposing (Model, Msg, page)

import Config
import Effect
import Html.Styled as Html exposing (Html, text)
import Layouts exposing (Layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Types exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import UI.Example exposing (wireframeShortParagraph)
import UI.Header exposing (..)
import UI.Icon exposing (icon)
import View.ConfigAndPreview exposing (configAndPreview)


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
                { title = "Header"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    { header : String
    , subHeader : String
    , size : Size
    }


init : Model
init =
    { header = "Header"
    , subHeader = "Subheader"
    , size = Medium
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
view { theme } model =
    let
        options =
            { theme = theme }
    in
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Content Headers"
        , preview =
            [ headerWithProps { size = model.size, theme = theme }
                []
                [ text <| sizeToString model.size ++ " " ++ model.header
                , subHeader options [] [ text model.subHeader ]
                ]
            , wireframeShortParagraph
            ]
        , configSections =
            [ { label = "Content"
              , configs =
                    [ { label = "Header"
                      , config =
                            Config.string
                                { label = ""
                                , value = model.header
                                , setter = \string m -> { m | header = string }
                                }
                      , note = ""
                      }
                    , { label = "Subheader"
                      , config =
                            Config.string
                                { label = ""
                                , value = model.subHeader
                                , setter = \string m -> { m | subHeader = string }
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
    ]
