module Pages.Elements.Label exposing (Model, Msg, page)

import Data exposing (PresetColor(..), Size(..), colorFromString, colorToString)
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
    { color : Maybe PresetColor }


init : Model
init =
    { color = Nothing }



-- UPDATE


type Msg
    = ChangeColor (Maybe PresetColor)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeColor color ->
            { model | color = color }



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview { title = "Label" }
        [ let
            label_ =
                case model.color of
                    Just Red ->
                        redLabel

                    Just Orange ->
                        orangeLabel

                    Just Yellow ->
                        yellowLabel

                    Just Olive ->
                        oliveLabel

                    Just Green ->
                        greenLabel

                    Just Teal ->
                        tealLabel

                    Just Blue ->
                        blueLabel

                    Just Violet ->
                        violetLabel

                    Just Purple ->
                        purpleLabel

                    Just Pink ->
                        pinkLabel

                    Just Brown ->
                        brownLabel

                    Just Grey ->
                        greyLabel

                    Just Black ->
                        blackLabel

                    Nothing ->
                        Label.label
          in
          label_ [] [ icon [] "fas fa-envelope", text "23" ]
        ]
        [ { label = "Color"
          , description = "A label can have different colors"
          , content =
                select [ onInput (colorFromString >> ChangeColor) ] <|
                    (option [ value "Default", selected (model.color == Nothing) ] [ text "Default" ]
                        :: List.map (\color -> option [ value (colorToString color), selected (model.color == Just color) ] [ text (colorToString color) ])
                            [ Red, Orange, Yellow, Olive, Green, Teal, Blue, Violet, Purple, Pink, Brown, Grey, Black ]
                    )
          }
        ]
    , configAndPreview { title = "Icon" }
        [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
        , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
        , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
        , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
        ]
        []
    , configAndPreview { title = "" }
        [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
        , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
        , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
        , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
        ]
        []
    , configAndPreview { title = "" }
        [ Label.label [] [ icon [] "fas fa-envelope" ]
        , Label.label [] [ icon [] "fas fa-dog" ]
        , Label.label [] [ icon [] "fas fa-cat" ]
        ]
        []
    , configAndPreview { title = "Basic" }
        [ basicLabel [] [ text "Basic" ] ]
        []
    ]
