module Page.Modules.Modal exposing (Model, Msg, architecture)

import Html.Styled as Html exposing (Html, a, p, text)
import Html.Styled.Attributes as Attributes exposing (href)
import Html.Styled.Events exposing (onClick)
import Shared exposing (Shared)
import UI.Button exposing (blackButton, button, greenButton, redButton)
import UI.Dimmer exposing (pageDimmer)
import UI.Example exposing (example)
import UI.Icon exposing (icon)
import UI.Modal as Modal exposing (basicModal, modal)


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
    { shared : Shared
    , toggledItems : List String
    }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared
      , toggledItems = []
      }
    , Cmd.none
    )


type Msg
    = Toggle String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle newItem ->
            ( { model
                | toggledItems =
                    if List.member newItem model.toggledItems then
                        List.filter ((/=) newItem) model.toggledItems

                    else
                        newItem :: model.toggledItems
              }
            , Cmd.none
            )


view : Model -> List (Html Msg)
view =
    \{ shared, toggledItems } ->
        let
            options =
                { inverted = shared.darkMode }
        in
        [ example
            { title = "Modal"
            , description = "A standard modal"
            }
            [ button [ onClick (Toggle "modal") ] [ icon [] "fas fa-plus", text "Show" ]
            , pageDimmer (List.member "modal" toggledItems)
                [ onClick (Toggle "modal") ]
                [ modal options
                    []
                    { header = [ text "Select a Photo" ]
                    , content =
                        [ Modal.description []
                            [ p []
                                [ text "We've found the following "
                                , a [ href "https://www.gravatar.com", Attributes.target "_blank" ] [ text "gravatar" ]
                                , text " image associated with your e-mail address."
                                ]
                            , p [] [ text "Is it okay to use this photo?" ]
                            ]
                        ]
                    , actions =
                        [ blackButton [] [ text "Nope" ]
                        , greenButton [] [ text "Yep, that's me" ]
                        ]
                    }
                ]
            ]
        , example
            { title = "Basic"
            , description = "A modal can reduce its complexity"
            }
            [ button [ onClick (Toggle "basicModal") ] [ icon [] "fas fa-plus", text "Show" ]
            , pageDimmer (List.member "basicModal" toggledItems)
                [ onClick (Toggle "basicModal") ]
                [ basicModal []
                    { header = [ text "Archive Old Messages" ]
                    , content =
                        [ Modal.description []
                            [ p [] [ text "Your inbox is getting full, would you like us to enable automatic archiving of old messages?" ] ]
                        ]
                    , actions =
                        [ redButton [] [ text "No" ]
                        , greenButton [] [ text "Yes" ]
                        ]
                    }
                    []
                ]
            ]
        ]
