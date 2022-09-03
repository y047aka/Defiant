module Pages.Elements.Label exposing (Model, Msg, page)

import Config
import Data.PalettesByState as PalettesByState
import Html.Styled as Html exposing (Html, text)
import Page
import Request exposing (Request)
import Shared
import Types exposing (PresetColor(..))
import UI.Icon exposing (icon)
import UI.Label as Label exposing (..)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Label"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { color : Color }


type Color
    = Default
    | Primary
    | Secondary
    | Colored PresetColor


init : Model
init =
    { color = Default }



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview UpdateConfig
        { title = "Label"
        , preview =
            [ let
                label_ =
                    case model.color of
                        Default ->
                            Label.label

                        Primary ->
                            primaryLabel

                        Secondary ->
                            secondaryLabel

                        Colored c ->
                            labelWithProps
                                { border = False
                                , palette = Just (PalettesByState.fromPresetColor c |> .default)
                                , additionalStyles = []
                                }
              in
              label_ [] [ icon [] "fas fa-envelope", text "23" ]
            ]
        , configSections =
            [ { label = "Variations"
              , configs =
                    [ { label = "Color"
                      , config =
                            Config.select
                                { value = model.color
                                , options = [ Default, Primary, Secondary ] ++ List.map Colored [ Red, Orange, Yellow, Olive, Green, Teal, Blue, Violet, Purple, Pink, Brown, Grey, Black ]
                                , fromString = colorFromString
                                , toString = colorToString
                                , setter = \color m -> { m | color = color }
                                }
                      , note = "A label can have different colors"
                      }
                    ]
              }
            ]
        }
    , configAndPreview UpdateConfig
        { title = "Icon"
        , preview =
            [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
            , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
            , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
            , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig
        { title = ""
        , preview =
            [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
            , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
            , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
            , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig
        { title = ""
        , preview =
            [ Label.label [] [ icon [] "fas fa-envelope" ]
            , Label.label [] [ icon [] "fas fa-dog" ]
            , Label.label [] [ icon [] "fas fa-cat" ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig
        { title = "Basic"
        , preview = [ basicLabel [] [ text "Basic" ] ]
        , configSections = []
        }
    ]



-- HELPER


colorFromString : String -> Maybe Color
colorFromString string =
    case ( string, Types.colorFromString string ) of
        ( "Default", _ ) ->
            Just Default

        ( "Primary", _ ) ->
            Just Primary

        ( "Secondary", _ ) ->
            Just Secondary

        ( _, Just colored ) ->
            Just (Colored colored)

        _ ->
            Nothing


colorToString : Color -> String
colorToString color =
    case color of
        Default ->
            "Default"

        Primary ->
            "Primary"

        Secondary ->
            "Secondary"

        Colored c ->
            Types.colorToString c
