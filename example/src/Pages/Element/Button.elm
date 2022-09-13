module Pages.Element.Button exposing (Model, Msg, page)

import Config
import Data.PalettesByState as PalettesByState
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import Types exposing (PresetColor(..))
import UI.Button as Button exposing (..)
import UI.Icon exposing (icon)
import UI.Label exposing (basicLabel)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Button"
                , body = view shared model
                }
        }



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
    | UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }

        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ configAndPreview UpdateConfig { theme = theme } <|
        { title = "Button"
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
                    [ { label = "Label"
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
                    [ { label = "Color"
                      , config =
                            Config.select
                                { value = model.color
                                , options = [ Default, Primary, Secondary ] ++ List.map Colored [ Red, Orange, Yellow, Olive, Green, Teal, Blue, Violet, Purple, Pink, Brown, Grey, Black ]
                                , fromString = colorFromString
                                , toString = colorToString
                                , setter = \color m -> { m | color = color }
                                }
                      , note = "A button can have different colors"
                      }
                    ]
              }
            ]
        }
    , configAndPreview UpdateConfig { theme = theme } <|
        { title = ""
        , preview =
            [ button [] [ text "Button" ]
            , button [] [ text "Focusable" ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme } <|
        { title = "Labeled"
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
    , configAndPreview UpdateConfig { theme = theme } <|
        { title = "Icon"
        , preview = [ button [] [ icon [] "fas fa-cloud" ] ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme } <|
        { title = "Basic"
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
