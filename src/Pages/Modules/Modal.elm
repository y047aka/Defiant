module Pages.Modules.Modal exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, a, p, text)
import Html.Styled.Attributes as Attributes exposing (href)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import UI.Button exposing (blackButton, button, greenButton, redButton)
import UI.Dimmer exposing (pageDimmer)
import UI.Example exposing (example)
import UI.Icon exposing (icon)
import UI.Modal as Modal exposing (basicModal, modal)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.element
        { init = init shared
        , update = update
        , view =
            \model ->
                { title = "Modal"
                , body = view model
                }
        , subscriptions = \_ -> Sub.none
        }



-- INIT


type alias Model =
    { shared : Shared.Model
    , toggledItems : List String
    }


init : Shared.Model -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared
      , toggledItems = []
      }
    , Cmd.none
    )



-- UPDATE


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



-- VIEW


view : Model -> List (Html Msg)
view { shared, toggledItems } =
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
