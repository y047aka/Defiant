module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (em, margin2, padding2, position, relative, zero)
import Html exposing (Html)
import Html.Styled exposing (div, main_, p, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import UI exposing (..)
import UI.Modifier exposing (Palette(..))



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Html Msg
view model =
    let
        example attributes =
            div <|
                css
                    [ -- .example {
                      margin2 (em 1) zero
                    , padding2 (em 1) zero
                    , position relative
                    ]
                    :: attributes
    in
    toUnstyled <|
        main_ []
            [ section []
                [ example []
                    [ header [] [ text "Button" ]
                    , p [] [ text "A standard button" ]
                    , button [] [ text "Follow" ]
                    ]
                , example []
                    [ button [] [ text "Button" ]
                    , button [] [ text "Focusable" ]
                    ]
                , example []
                    [ header [] [ text "Animated" ]
                    , p [] [ text "A button can animate to show hidden content" ]
                    ]
                , example []
                    [ header [] [ text "Labeled" ]
                    , p [] [ text "A button can appear alongside a label" ]
                    , labeledButton []
                        [ button [] [ text "Like" ]
                        , basicLabel [] [ text "2048" ]
                        ]
                    , labeledButton []
                        [ button [ onClick Decrement ] [ text "-" ]
                        , basicLabel [] [ text (String.fromInt model) ]
                        , button [ onClick Increment ] [ text "+" ]
                        ]
                    ]
                , example []
                    [ header [] [ text "Basic" ]
                    , p [] [ text "A basic button is less pronounced" ]
                    , basicButton [] [ text "Add Friend" ]
                    ]
                , example [] <|
                    [ header [] [ text "Colored" ]
                    , p [] [ text "A button can have different colors" ]
                    ]
                        ++ List.map
                            (\item -> buttonWithOption { palette = item.palette } [] [ text item.label ])
                            [ { label = "Primary", palette = Primary }
                            , { label = "Secondary", palette = Secondary }
                            , { label = "Red", palette = Red }
                            , { label = "Orange", palette = Orange }
                            , { label = "Yellow", palette = Yellow }
                            , { label = "Olive", palette = Olive }
                            , { label = "Green", palette = Green }
                            , { label = "Teal", palette = Teal }
                            , { label = "Blue", palette = Blue }
                            , { label = "Violet", palette = Violet }
                            , { label = "Purple", palette = Purple }
                            , { label = "Pink", palette = Pink }
                            , { label = "Brown", palette = Brown }
                            , { label = "Grey", palette = Grey }
                            , { label = "Black", palette = Black }
                            ]
                ]
            , section []
                [ example []
                    [ header [] [ text "Label" ]
                    , p [] [ text "A label" ]
                    , label [] [ text "23" ]
                    ]
                , example []
                    [ header [] [ text "Basic" ]
                    , p [] [ text "A label can reduce its complexity" ]
                    , basicLabel [] [ text "Basic" ]
                    ]
                , example [] <|
                    [ header [] [ text "Colored" ]
                    , p [] [ text "A label can have different colors" ]
                    ]
                        ++ List.map
                            (\item -> labelWithOption { palette = item.palette } [] [ text item.label ])
                            [ { label = "Primary", palette = Primary }
                            , { label = "Secondary", palette = Secondary }
                            , { label = "Red", palette = Red }
                            , { label = "Orange", palette = Orange }
                            , { label = "Yellow", palette = Yellow }
                            , { label = "Olive", palette = Olive }
                            , { label = "Green", palette = Green }
                            , { label = "Teal", palette = Teal }
                            , { label = "Blue", palette = Blue }
                            , { label = "Violet", palette = Violet }
                            , { label = "Purple", palette = Purple }
                            , { label = "Pink", palette = Pink }
                            , { label = "Brown", palette = Brown }
                            , { label = "Grey", palette = Grey }
                            , { label = "Black", palette = Black }
                            ]
                ]
            ]
