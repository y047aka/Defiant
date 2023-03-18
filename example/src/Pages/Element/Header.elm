module Pages.Element.Header exposing (Model, Msg, page)

import Effect
import Html.Styled as Html exposing (Html, text)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import Types exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import UI.Example exposing (wireframeShortParagraph)
import UI.Header exposing (..)
import UI.Icon exposing (icon)


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
    = UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    let
        options =
            { theme = theme }
    in
    [ playground
        { title = "Content Headers"
        , theme = theme
        , inverted = False
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
                    [ Playground.string
                        { label = "Header"
                        , value = model.header
                        , onInput = (\string c -> { c | header = string }) >> UpdateConfig
                        , placeholder = ""
                        , note = ""
                        }
                    , Playground.string
                        { label = "Subheader"
                        , value = model.subHeader
                        , onInput = (\string c -> { c | subHeader = string }) >> UpdateConfig
                        , placeholder = ""
                        , note = ""
                        }
                    ]
              }
            , { label = "Variations"
              , configs =
                    [ Playground.select
                        { label = "Size"
                        , value = model.size
                        , options = [ Massive, Huge, Big, Large, Medium, Small, Tiny, Mini ]
                        , fromString = sizeFromString
                        , toString = sizeToString
                        , onChange = (\size c -> { c | size = size }) >> UpdateConfig
                        , note = "Text can vary in the same sizes as icons"
                        }
                    ]
              }
            ]
        }
    , playground
        { title = "Icon Headers"
        , theme = theme
        , inverted = False
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
