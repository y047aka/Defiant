module Pages.Element.Label exposing (Model, Msg, page)

import Config
import Data.PalettesByState as PalettesByState
import Effect
import Html.Styled as Html exposing (Html, text)
import Layouts.Default exposing (layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Types exposing (PresetColor(..))
import UI.Icon exposing (icon)
import UI.Label as Label exposing (..)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Label"
                , body = view shared model
                }
                    |> layout shared route
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


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Icon"
        , preview =
            [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
            , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
            , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
            , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = ""
        , preview =
            [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
            , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
            , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
            , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = ""
        , preview =
            [ Label.label [] [ icon [] "fas fa-envelope" ]
            , Label.label [] [ icon [] "fas fa-dog" ]
            , Label.label [] [ icon [] "fas fa-cat" ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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
