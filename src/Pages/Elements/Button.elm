module Pages.Elements.Button exposing (Model, Msg, page)

import Data exposing (PresetColor(..))
import Data.PalettesByState as PalettesByState
import Html.Styled as Html exposing (Html, option, select, text)
import Html.Styled.Attributes exposing (selected, value)
import Html.Styled.Events exposing (onClick, onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Button as Button exposing (..)
import UI.Icon exposing (icon)
import UI.Label exposing (basicLabel)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Button"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { counter : Int
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
    , color = Default
    }



-- UPDATE


type Msg
    = Increment
    | Decrement
    | ChangeColor Color


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }

        ChangeColor color ->
            { model | color = color }



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview { title = "Button" }
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
            [ text "Follow" ]
        ]
        [ { label = "Color"
          , description = "A button can have different colors"
          , content =
                select [ onInput (colorFromString >> Maybe.withDefault Default >> ChangeColor) ] <|
                    List.map (\color -> option [ value (colorToString color), selected (model.color == color) ] [ text (colorToString color) ])
                        ([ Default, Primary, Secondary ] ++ List.map Colored [ Red, Orange, Yellow, Olive, Green, Teal, Blue, Violet, Purple, Pink, Brown, Grey, Black ])
          }
        ]
    , configAndPreview { title = "" }
        [ button [] [ text "Button" ]
        , button [] [ text "Focusable" ]
        ]
        []
    , configAndPreview { title = "Emphasis" }
        [ primaryButton [] [ text "Save" ]
        , button [] [ text "Discard" ]
        ]
        []
    , configAndPreview { title = "" }
        [ secondaryButton [] [ text "Okay" ]
        , button [] [ text "Cancel" ]
        ]
        []
    , configAndPreview { title = "Labeled" }
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
        []
    , configAndPreview { title = "Icon" }
        [ button [] [ icon [] "fas fa-cloud" ] ]
        []
    , configAndPreview { title = "Basic" }
        [ basicButton [] [ icon [] "fas fa-user", text "Add Friend" ] ]
        []
    ]



-- HELPER


colorFromString : String -> Maybe Color
colorFromString string =
    case ( string, Data.colorFromString string ) of
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
            Data.colorToString c
