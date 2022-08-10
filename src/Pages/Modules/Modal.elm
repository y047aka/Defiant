module Pages.Modules.Modal exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, a, p, text)
import Html.Styled.Attributes as Attributes exposing (href)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import UI.Button exposing (blackButton, button, greenButton, redButton)
import UI.Example exposing (example)
import UI.Icon exposing (icon)
import UI.Modal as Modal exposing (basicModal, dialog, modal)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init shared
        , update = update
        , view =
            \model ->
                { title = "Modal"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { shared : Shared.Model
    , toggledItems : List String
    }


init : Shared.Model -> Model
init shared =
    { shared = shared
    , toggledItems = []
    }



-- UPDATE


type Msg
    = Toggle String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle newItem ->
            { model
                | toggledItems =
                    if List.member newItem model.toggledItems then
                        List.filter ((/=) newItem) model.toggledItems

                    else
                        newItem :: model.toggledItems
            }



-- VIEW


view : Model -> List (Html Msg)
view { shared, toggledItems } =
    [ example
        { title = "Modal"
        , description = "A standard modal"
        }
        [ button [ onClick (Toggle "modal") ] [ icon [] "fas fa-plus", text "Show" ]
        , modal
            { open = List.member "modal" toggledItems
            , toggle = Toggle "modal"
            , theme = shared.theme
            }
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
                [ blackButton [ onClick (Toggle "modal") ] [ text "Nope" ]
                , greenButton [ onClick (Toggle "modal") ] [ text "Yep, that's me" ]
                ]
            }
        ]
    , example
        { title = "Basic"
        , description = "A modal can reduce its complexity"
        }
        [ button [ onClick (Toggle "basicModal") ] [ icon [] "fas fa-plus", text "Show" ]
        , basicModal
            { open = List.member "basicModal" toggledItems
            , toggle = Toggle "basicModal"
            }
            []
            { header = [ text "Archive Old Messages" ]
            , content =
                [ Modal.description []
                    [ p [] [ text "Your inbox is getting full, would you like us to enable automatic archiving of old messages?" ] ]
                ]
            , actions =
                [ redButton [ onClick (Toggle "basicModal") ] [ text "No" ]
                , greenButton [ onClick (Toggle "basicModal") ] [ text "Yes" ]
                ]
            }
            []
        ]
    , example
        { title = "Dialog"
        , description = ""
        }
        [ button [ onClick (Toggle "dialog") ] [ icon [] "fas fa-plus", text "Show" ]
        , dialog
            { open = List.member "dialog" toggledItems
            , theme = shared.theme
            }
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
                [ blackButton [ onClick (Toggle "dialog") ] [ text "Nope" ]
                , greenButton [ onClick (Toggle "dialog") ] [ text "Yep, that's me" ]
                ]
            }
        ]
    ]
