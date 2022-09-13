module Pages.Layout.Modal exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, a, p, text)
import Html.Styled.Attributes as Attributes exposing (href)
import Html.Styled.Events exposing (onClick)
import Page
import Request exposing (Request)
import Shared
import UI.Button exposing (blackButton, button, greenButton, redButton)
import UI.Icon exposing (icon)
import UI.Modal as Modal exposing (basicModal, dialog, modal)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Modal"
                , body = view shared model
                }
        }



-- INIT


type alias Model =
    { toggledItems : List String }


init : Model
init =
    { toggledItems = [] }



-- UPDATE


type Msg
    = Toggle String
    | UpdateConfig (Config.Msg Model Msg)


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

        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view shared { toggledItems } =
    [ configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Modal"
        , preview =
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
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Basic"
        , preview =
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
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Dialog"
        , preview =
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
        , configSections = []
        }
    ]
