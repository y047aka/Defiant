module Page.Element.Button exposing (Model, Msg, init, update, view)

import Data.PalettesByState as PalettesByState
import Html.Styled exposing (Html, text)
import Html.Styled.Events exposing (onClick)
import Playground exposing (playground)
import Control
import Shared
import Types exposing (PresetColor(..))
import UI.Button as Button exposing (..)
import UI.Header as Header
import UI.Icon exposing (icon)
import UI.Label exposing (basicLabel)



-- INIT


type alias Model =
    { counter : Int
    , label : String
    , color : Color
    }


type Color
    = Default
    | Primary
    | Secondary
    | Colored PresetColor


init : Model
init =
    { counter = 0
    , label = "Button"
    , color = Default
    }



-- UPDATE


type Msg
    = Increment
    | Decrement
    | UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }

        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ Header.header { theme = theme } [] [ text "Button" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ buttonWithProps
                { palettesByState =
                    case model.color of
                        Default ->
                            Button.defaultPalettes

                        Primary ->
                            PalettesByState.fromPresetColor Blue

                        Secondary ->
                            PalettesByState.fromPresetColor Black

                        Colored c ->
                            PalettesByState.fromPresetColor c
                , shadow = False
                , additionalStyles = []
                }
                []
                [ text model.label ]
            ]
        , configSections =
            [ { label = "Content"
              , configs =
                    [ Control.field "Label"
                        (Control.string
                            { value = model.label
                            , onInput = (\string ps -> { ps | label = string }) >> UpdateConfig
                            , placeholder = ""
                            }
                        )
                    ]
              }
            , { label = "Variations"
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
                    , Control.comment "A button can have different colors"
                    ]
              }
            ]
        }
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ button [] [ text "Button" ]
            , button [] [ text "Focusable" ]
            ]
        , configSections = []
        }
    , Header.header { theme = theme } [] [ text "Labeled" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ labeledButton []
                [ button [] [ icon [] "fas fa-heart", text "Like" ]
                , basicLabel [] [ text "2048" ]
                ]
            , labeledButton []
                [ button [ onClick Decrement ] [ text "-" ]
                , basicLabel [] [ text (String.fromInt model.counter) ]
                , button [ onClick Increment ] [ text "+" ]
                ]
            ]
        , configSections = []
        }
    , Header.header { theme = theme } [] [ text "Icon" ]
    , playground
        { theme = theme
        , inverted = False
        , preview = [ button [] [ icon [] "fas fa-cloud" ] ]
        , configSections = []
        }
    , Header.header { theme = theme } [] [ text "Basic" ]
    , playground
        { theme = theme
        , inverted = False
        , preview = [ basicButton [] [ icon [] "fas fa-user", text "Add Friend" ] ]
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
