module Page.Elements.Label exposing (Model, Msg, architecture)

import Html.Styled as Html exposing (Html, text)
import Shared exposing (Shared)
import UI.Example exposing (example)
import UI.Icon exposing (icon)
import UI.Label as Label exposing (..)


architecture :
    { init : Shared -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }
architecture =
    { init = init
    , update = update
    , view = view
    }


type alias Model =
    { shared : Shared }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared }, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> List (Html msg)
view _ =
    [ example
        { title = "Label"
        , description = "A label"
        }
        [ Label.label [] [ icon [] "fas fa-envelope", text "23" ] ]
    , example
        { title = "Icon"
        , description = "A label can include an icon"
        }
        [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
        , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
        , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
        , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
        , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
        , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
        , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Label.label [] [ icon [] "fas fa-envelope" ]
        , Label.label [] [ icon [] "fas fa-dog" ]
        , Label.label [] [ icon [] "fas fa-cat" ]
        ]
    , example
        { title = "Basic"
        , description = "A label can reduce its complexity"
        }
        [ basicLabel [] [ text "Basic" ] ]
    , example
        { title = "Colored"
        , description = "A label can have different colors"
        }
        [ primaryLabel [] [ text "Primary" ]
        , secondaryLabel [] [ text "Secondary" ]
        , redLabel [] [ text "Red" ]
        , orangeLabel [] [ text "Orange" ]
        , yellowLabel [] [ text "Yellow" ]
        , oliveLabel [] [ text "Olive" ]
        , greenLabel [] [ text "Green" ]
        , tealLabel [] [ text "Teal" ]
        , blueLabel [] [ text "Blue" ]
        , violetLabel [] [ text "Violet" ]
        , purpleLabel [] [ text "Purple" ]
        , pinkLabel [] [ text "Pink" ]
        , brownLabel [] [ text "Brown" ]
        , greyLabel [] [ text "Grey" ]
        , blackLabel [] [ text "Black" ]
        ]
    ]
