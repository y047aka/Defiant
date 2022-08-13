module Pages.Elements.Step exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, option, select, text)
import Html.Styled.Attributes exposing (checked, for, id, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Step as Step exposing (State(..), activeStep, completedStep, disabledStep, step, steps)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Step"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { hasIcon : Bool
    , hasDescription : Bool
    , state : State
    }


init : Model
init =
    { hasIcon = True
    , hasDescription = True
    , state = Default
    }



-- UPDATE


type Msg
    = ToggleHasIcon
    | ToggleHasDescription
    | ChangeState State


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleHasIcon ->
            { model | hasIcon = not model.hasIcon }

        ToggleHasDescription ->
            { model | hasDescription = not model.hasDescription }

        ChangeState state ->
            { model | state = state }



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview { title = "Steps" }
        [ steps []
            [ step []
                { icon = "fas fa-truck"
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            , activeStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            , disabledStep []
                { icon = "fas fa-info"
                , title = "Confirm Order"
                , description = ""
                }
            ]
        ]
        []
    , configAndPreview { title = "Content" }
        [ steps []
            [ step []
                { icon =
                    if model.hasIcon then
                        "fas fa-truck"

                    else
                        ""
                , title = "Shipping"
                , description =
                    if model.hasDescription then
                        "Choose your shipping options"

                    else
                        ""
                }
            ]
        ]
        [ { label = "Icon"
          , description = "A step can contain an icon"
          , content =
                checkbox []
                    [ Checkbox.input [ id "icon", type_ "checkbox", checked model.hasIcon, onClick ToggleHasIcon ] []
                    , Checkbox.label [ for "icon" ] [ text "Icon" ]
                    ]
          }
        , { label = "Description"
          , description = "A step can contain a description"
          , content =
                checkbox []
                    [ Checkbox.input [ id "description", type_ "checkbox", checked model.hasDescription, onClick ToggleHasDescription ] []
                    , Checkbox.label [ for "description" ] [ text "Description" ]
                    ]
          }
        ]
    , configAndPreview { title = "States" }
        [ steps []
            [ let
                step_ =
                    case model.state of
                        Default ->
                            step

                        Active ->
                            activeStep

                        Completed ->
                            completedStep

                        Disabled ->
                            disabledStep
              in
              step_ []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            ]
        ]
        [ { label = "States"
          , description =
                case model.state of
                    Default ->
                        ""

                    Active ->
                        "A step can be highlighted as active"

                    Completed ->
                        "A step can show that a user has completed it"

                    Disabled ->
                        "A step can show that it cannot be selected"
          , content =
                select [ onInput (Step.stateFromString >> Maybe.withDefault model.state >> ChangeState) ] <|
                    List.map (\state -> option [ value (Step.stateToString state), selected (model.state == state) ] [ text (Step.stateToString state) ])
                        [ Default, Active, Completed, Disabled ]
          }
        ]
    ]
