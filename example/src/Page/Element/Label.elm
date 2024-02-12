module Page.Element.Label exposing (Model, Msg, init, update, view)

import Control
import Data.PalettesByState as PalettesByState
import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import Types exposing (PresetColor(..))
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Label as Label exposing (..)



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
    = UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ Header.header { theme = theme } [] [ text "Label" ]
    , playground
        { theme = theme
        , inverted = False
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
        , controlSections =
            [ { label = "Variations"
              , configs =
                    [ Control.field "Color"
                        (Control.select
                            { value = colorToString model.color
                            , options = List.map colorToString <| [ Default, Primary, Secondary ] ++ List.map Colored [ Red, Orange, Yellow, Olive, Green, Teal, Blue, Violet, Purple, Pink, Brown, Grey, Black ]
                            , onChange =
                                (\color ps ->
                                    colorFromString color
                                        |> Maybe.map (\c -> { ps | color = c })
                                        |> Maybe.withDefault ps
                                )
                                    >> UpdateConfig
                            }
                        )
                    , Control.comment "A label can have different colors"
                    ]
              }
            ]
        }
    , Header.header { theme = theme } [] [ text "Icon" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
            , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
            , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
            , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
            ]
        , controlSections = []
        }
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
            , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
            , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
            , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
            ]
        , controlSections = []
        }
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ Label.label [] [ icon [] "fas fa-envelope" ]
            , Label.label [] [ icon [] "fas fa-dog" ]
            , Label.label [] [ icon [] "fas fa-cat" ]
            ]
        , controlSections = []
        }
    , Header.header { theme = theme } [] [ text "Basic" ]
    , playground
        { theme = theme
        , inverted = False
        , preview = [ basicLabel [] [ text "Basic" ] ]
        , controlSections = []
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
