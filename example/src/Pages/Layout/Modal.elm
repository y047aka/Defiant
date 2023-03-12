module Pages.Layout.Modal exposing (Model, Msg, page)

import Effect
import Html.Styled as Html exposing (Html, a, p, text)
import Html.Styled.Attributes as Attributes exposing (href)
import Html.Styled.Events exposing (onClick)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Button exposing (blackButton, button, greenButton, redButton)
import UI.Icon exposing (icon)
import UI.Modal as Modal exposing (basicModal, dialog, modal)


layout : Model -> Layout
layout model =
    Layouts.Default { default = () }


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Modal"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    { toggledItems : List String }


init : Model
init =
    { toggledItems = [] }



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


view : Shared.Model -> Model -> List (Html Msg)
view shared { toggledItems } =
    [ playground
        { title = "Modal"
        , theme = shared.theme
        , inverted = False
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
    , playground
        { title = "Basic"
        , theme = shared.theme
        , inverted = False
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
    , playground
        { title = "Dialog"
        , theme = shared.theme
        , inverted = False
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
