module Page.Elements.Button exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html, text)
import Html.Styled.Events exposing (onClick)
import Shared exposing (Shared)
import UI.Button exposing (..)
import UI.Example exposing (example)
import UI.Icon exposing (icon)
import UI.Label exposing (basicLabel)


architecture : Architecture Model Msg
architecture =
    { init = init
    , update = update
    , view = view
    }


type alias Model =
    { shared : Shared
    , count : Int
    }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared
      , count = 0
      }
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )


view : Model -> List (Html Msg)
view { count } =
    [ example
        { title = "Button"
        , description = "A standard button"
        }
        [ button [] [ text "Follow" ] ]
    , example
        { title = ""
        , description = ""
        }
        [ button [] [ text "Button" ]
        , button [] [ text "Focusable" ]
        ]
    , example
        { title = "Emphasis"
        , description = "A button can be formatted to show different levels of emphasis"
        }
        [ primaryButton [] [ text "Save" ]
        , button [] [ text "Discard" ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ secondaryButton [] [ text "Okay" ]
        , button [] [ text "Cancel" ]
        ]
    , example
        { title = "Labeled"
        , description = "A button can appear alongside a label"
        }
        [ labeledButton []
            [ button [] [ icon [] "fas fa-heart", text "Like" ]
            , basicLabel [] [ text "2048" ]
            ]
        , labeledButton []
            [ button [ onClick Decrement ] [ text "-" ]
            , basicLabel [] [ text (String.fromInt count) ]
            , button [ onClick Increment ] [ text "+" ]
            ]
        ]
    , example
        { title = "Icon"
        , description = "A button can have only an icon"
        }
        [ button [] [ icon [] "fas fa-cloud" ] ]
    , example
        { title = "Basic"
        , description = "A basic button is less pronounced"
        }
        [ basicButton [] [ icon [] "fas fa-user", text "Add Friend" ] ]
    , example
        { title = "Colored"
        , description = "A button can have different colors"
        }
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
    ]
