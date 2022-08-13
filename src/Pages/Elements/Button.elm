module Pages.Elements.Button exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, text)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import UI.Button exposing (..)
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
    { counter : Int }


init : Model
init =
    { counter = 0 }



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }



-- VIEW


view : Model -> List (Html Msg)
view { counter } =
    [ configAndPreview { title = "Button" }
        [ button [] [ text "Follow" ] ]
        []
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
            , basicLabel [] [ text (String.fromInt counter) ]
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
    , configAndPreview { title = "Colored" }
        [ primaryButton [] [ text "Primary" ]
        , secondaryButton [] [ text "Secondary" ]
        , redButton [] [ text "Red" ]
        , orangeButton [] [ text "Orange" ]
        , yellowButton [] [ text "Yellow" ]
        , oliveButton [] [ text "Olive" ]
        , greenButton [] [ text "Green" ]
        , tealButton [] [ text "Teal" ]
        , blueButton [] [ text "Blue" ]
        , violetButton [] [ text "Violet" ]
        , purpleButton [] [ text "Purple" ]
        , pinkButton [] [ text "Pink" ]
        , brownButton [] [ text "Brown" ]
        , greyButton [] [ text "Grey" ]
        , blackButton [] [ text "Black" ]
        ]
        []
    ]
