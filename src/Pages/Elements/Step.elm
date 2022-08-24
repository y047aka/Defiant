module Pages.Elements.Step exposing (Model, Msg, Progress(..), page, progressFromString, progressToString)

import Html.Styled as Html exposing (Html, div, input, label, option, select, text)
import Html.Styled.Attributes exposing (checked, for, id, name, selected, type_, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Checkbox exposing (checkbox)
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
    [ configAndPreview
        { title = "Steps"
        , preview =
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
              steps []
                [ let
                    step_ =
                        case model.progress of
                            Shipping ->
                                activeStep

                            _ ->
                                step
                  in
                  step_ [] <|
                    considerOptions
                        { icon = "fas fa-truck"
                        , title = "Shipping"
                        , description = "Choose your shipping options"
                        }
                , let
                    step_ =
                        case model.progress of
                            Shipping ->
                                disabledStep

                            Billing ->
                                activeStep

                            ConfirmOrder ->
                                step
                  in
                  step_ [] <|
                    considerOptions
                        { icon = "fas fa-credit-card"
                        , title = "Billing"
                        , description = "Enter billing information"
                        }
                , let
                    step_ =
                        case model.progress of
                            ConfirmOrder ->
                                activeStep

                            _ ->
                                disabledStep
                  in
                  step_ [] <|
                    considerOptions
                        { icon = "fas fa-info"
                        , title = "Confirm Order"
                        , description = ""
                        }
                ]
            ]
        , configs =
            [ { label = "Progress"
              , fields =
                    [ { label = ""
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
                    ]
              }
            , { label = "Content"
              , fields =
                    [ { label = ""
                      , description = "A step can contain an icon"
                      , content =
                            checkbox
                                { id = "icon"
                                , label = "Icon"
                                , checked = model.hasIcon
                                , onClick = ToggleHasIcon
                                }
                      }
                    , { label = ""
                      , description = "A step can contain a description"
                      , content =
                            checkbox
                                { id = "description"
                                , label = "Description"
                                , checked = model.hasDescription
                                , onClick = ToggleHasDescription
                                }
                      }
                    ]
              }
            ]
        }
    , configAndPreview
        { title = "Step"
        , preview =
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
        , configs =
            [ { label = "States"
              , fields =
                    [ { label = ""
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
              }
            ]
        }
    ]



-- HELPER


type Progress
    = Shipping
    | Billing
    | ConfirmOrder


progressFromString : String -> Maybe Progress
progressFromString string =
    case string of
        "Shipping" ->
            Just Shipping

        "Billing" ->
            Just Billing

        "ConfirmOrder" ->
            Just ConfirmOrder

        _ ->
            Nothing


progressToString : Progress -> String
progressToString progress =
    case progress of
        Shipping ->
            "Shipping"

        Billing ->
            "Billing"

        ConfirmOrder ->
            "ConfirmOrder"
