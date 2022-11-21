module Pages.Navigation.Step exposing (Model, Msg, Progress(..), page, progressFromString, progressToString)

import Config
import Effect
import Html.Styled as Html exposing (Html)
import Layouts.Default exposing (layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.CircleStep as CircleStep
import UI.Step as Step exposing (State(..))
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Step"
                , body = view shared model
                }
                    |> layout shared route
        }



-- INIT


type alias Model =
    { type_ : StepType
    , hasIcon : Bool
    , hasDescription : Bool
    , progress : Progress
    }


init : Model
init =
    { type_ = Step
    , hasIcon = True
    , hasDescription = True
    , progress = Shipping
    }



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
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

                steps =
                    case model.type_ of
                        Step ->
                            Step.steps

                        CircleStep ->
                            CircleStep.steps
              in
              steps []
                [ let
                    step_ =
                        case ( model.type_, model.progress ) of
                            ( Step, Shipping ) ->
                                Step.activeStep

                            ( Step, _ ) ->
                                Step.step

                            ( CircleStep, Shipping ) ->
                                CircleStep.activeStep

                            ( CircleStep, _ ) ->
                                CircleStep.completedStep
                  in
                  step_ [] <|
                    considerOptions
                        { icon = "fas fa-truck"
                        , title = "Shipping"
                        , description = "Choose your shipping options"
                        }
                , let
                    step_ =
                        case ( model.type_, model.progress ) of
                            ( Step, Shipping ) ->
                                Step.disabledStep

                            ( Step, Billing ) ->
                                Step.activeStep

                            ( Step, ConfirmOrder ) ->
                                Step.step

                            ( CircleStep, Shipping ) ->
                                CircleStep.disabledStep

                            ( CircleStep, Billing ) ->
                                CircleStep.activeStep

                            ( CircleStep, ConfirmOrder ) ->
                                CircleStep.completedStep
                  in
                  step_ [] <|
                    considerOptions
                        { icon = "fas fa-credit-card"
                        , title = "Billing"
                        , description = "Enter billing information"
                        }
                , let
                    step_ =
                        case ( model.type_, model.progress ) of
                            ( Step, ConfirmOrder ) ->
                                Step.activeStep

                            ( Step, _ ) ->
                                Step.disabledStep

                            ( CircleStep, ConfirmOrder ) ->
                                CircleStep.activeStep

                            ( CircleStep, _ ) ->
                                CircleStep.disabledStep
                  in
                  step_ [] <|
                    considerOptions
                        { icon = "fas fa-info"
                        , title = "Confirm Order"
                        , description = ""
                        }
                ]
            ]
        , configSections =
            [ { label = "Type"
              , configs =
                    [ { label = ""
                      , config =
                            Config.select
                                { value = model.type_
                                , options = [ Step, CircleStep ]
                                , fromString = stepTypeFromString
                                , toString = stepTypeToString
                                , setter = \type_ m -> { m | type_ = type_ }
                                }
                      , note = ""
                      }
                    ]
              }
            , { label = "Progress"
              , configs =
                    [ { label = ""
                      , config =
                            Config.radio
                                { name = "progress"
                                , value = model.progress
                                , options = [ Shipping, Billing, ConfirmOrder ]
                                , fromString = progressFromString
                                , toString = progressToString
                                , setter = \progress m -> { m | progress = progress }
                                }
                      , note = ""
                      }
                    ]
              }
            , { label = "Content"
              , configs =
                    [ { label = ""
                      , config =
                            Config.bool
                                { id = "icon"
                                , label = "Icon"
                                , bool = model.hasIcon
                                , setter = \m -> { m | hasIcon = not m.hasIcon }
                                }
                      , note = "A step can contain an icon"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "description"
                                , label = "Description"
                                , bool = model.hasDescription
                                , setter = \m -> { m | hasDescription = not m.hasDescription }
                                }
                      , note = "A step can contain a description"
                      }
                    ]
              }
            ]
        }
    ]



-- HELPER


type StepType
    = Step
    | CircleStep


stepTypeFromString : String -> Maybe StepType
stepTypeFromString string =
    case string of
        "Step" ->
            Just Step

        "CircleStep" ->
            Just CircleStep

        _ ->
            Nothing


stepTypeToString : StepType -> String
stepTypeToString stepType =
    case stepType of
        Step ->
            "Step"

        CircleStep ->
            "CircleStep"


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
