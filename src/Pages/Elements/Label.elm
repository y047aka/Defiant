module Pages.Elements.Label exposing (Model, Msg, page)

import Data exposing (PresetColor(..))
import Data.PalettesByState as PalettesByState
import Html.Styled as Html exposing (Html, option, select, text)
import Html.Styled.Attributes exposing (selected, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
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
    = ChangeColor Color


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeColor color ->
            { model | color = color }



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview
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
        , configs =
            [ { label = "Variations"
              , fields =
                    [ { label = "Color"
                      , description = "A label can have different colors"
                      , content =
                            select [ onInput (colorFromString >> Maybe.withDefault Default >> ChangeColor) ] <|
                                List.map (\color -> option [ value (colorToString color), selected (model.color == color) ] [ text (colorToString color) ])
                                    ([ Default, Primary, Secondary ] ++ List.map Colored [ Red, Orange, Yellow, Olive, Green, Teal, Blue, Violet, Purple, Pink, Brown, Grey, Black ])
                      }
                    ]
              }
            ]
        }
    , configAndPreview
        { title = "Icon"
        , preview =
            [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
            , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
            , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
            , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
            ]
        , configs = []
        }
    , configAndPreview
        { title = ""
        , preview =
            [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
            , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
            , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
            , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
            ]
        , configs = []
        }
    , configAndPreview
        { title = ""
        , preview =
            [ Label.label [] [ icon [] "fas fa-envelope" ]
            , Label.label [] [ icon [] "fas fa-dog" ]
            , Label.label [] [ icon [] "fas fa-cat" ]
            ]
        , configs = []
        }
    , configAndPreview
        { title = "Basic"
        , preview = [ basicLabel [] [ text "Basic" ] ]
        , configs = []
        }
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
