module Pages.Elements.CircleStep exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, div, input, label, option, select, text)
import Html.Styled.Attributes exposing (checked, for, id, name, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Page
import Pages.Elements.Step exposing (Progress(..), progressFromString, progressToString)
import Request exposing (Request)
import Shared
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.CircleStep as CircleStep exposing (State(..))
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Circle Step"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { hasIcon : Bool
    , hasDescription : Bool
    , state : State
    , progress : Progress
    }


init : Model
init =
    { hasIcon = True
    , hasDescription = True
    , state = Default
    , progress = Shipping
    }



-- UPDATE


type Msg
    = ToggleHasIcon
    | ToggleHasDescription
    | ChangeState State
    | ChangeProgress Progress


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleHasIcon ->
            { model | hasIcon = not model.hasIcon }

        ToggleHasDescription ->
            { model | hasDescription = not model.hasDescription }

        ChangeState state ->
            { model | state = state }

        ChangeProgress progress ->
            { model | progress = progress }



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview { title = "Steps" }
        [ let
            considerOptions { icon, title, description } =
                { icon =
                    if model.hasIcon then
                        icon

                    else
                        ""
                , title = title
                , description =
                    if model.hasDescription then
                        description

                    else
                        ""
                }
          in
          CircleStep.steps []
            [ let
                step =
                    case model.progress of
                        Shipping ->
                            CircleStep.activeStep

                        _ ->
                            CircleStep.completedStep
              in
              step [] <|
                considerOptions
                    { icon = "fas fa-truck"
                    , title = "Shipping"
                    , description = "Choose your shipping options"
                    }
            , let
                step =
                    case model.progress of
                        Shipping ->
                            CircleStep.disabledStep

                        Billing ->
                            CircleStep.activeStep

                        ConfirmOrder ->
                            CircleStep.completedStep
              in
              step [] <|
                considerOptions
                    { icon = "fas fa-credit-card"
                    , title = "Billing"
                    , description = "Enter billing information"
                    }
            , let
                step =
                    case model.progress of
                        ConfirmOrder ->
                            CircleStep.activeStep

                        _ ->
                            CircleStep.disabledStep
              in
              step [] <|
                considerOptions
                    { icon = "fas fa-info"
                    , title = "Confirm Order"
                    , description = ""
                    }
            ]
        ]
        [ { label = "Progress"
          , description = ""
          , content =
                div [] <|
                    List.map
                        (\progress ->
                            let
                                prefixedId =
                                    "progress_" ++ progressToString progress
                            in
                            div []
                                [ input
                                    [ id prefixedId
                                    , type_ "radio"
                                    , name "progress"
                                    , value (progressToString progress)
                                    , checked (model.progress == progress)
                                    , onInput (progressFromString >> Maybe.withDefault model.progress >> ChangeProgress)
                                    ]
                                    []
                                , label [ for prefixedId ] [ text (progressToString progress) ]
                                ]
                        )
                        [ Shipping, Billing, ConfirmOrder ]
          }
        , { label = "Icon"
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
    , configAndPreview { title = "Step" }
        [ CircleStep.steps []
            [ let
                step =
                    case model.state of
                        Default ->
                            CircleStep.step

                        Active ->
                            CircleStep.activeStep

                        Completed ->
                            CircleStep.completedStep

                        Disabled ->
                            CircleStep.disabledStep
              in
              step []
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
                select [ onInput (CircleStep.stateFromString >> Maybe.withDefault model.state >> ChangeState) ] <|
                    List.map (\state -> option [ value (CircleStep.stateToString state), selected (model.state == state) ] [ text (CircleStep.stateToString state) ])
                        [ Default, Active, Completed, Disabled ]
          }
        ]
    ]
