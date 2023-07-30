module Page.Navigation.Step exposing (Model, Msg, Progress(..), init, progressFromString, progressToString, update, view)

import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import UI.CircleStep as CircleStep
import UI.Header as Header
import UI.Step as Step exposing (State(..))



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
    = UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ Header.header { theme = theme } [] [ text "Steps" ]
    , playground
        { theme = theme
        , inverted = False
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
                    [ Playground.select
                        { label = ""
                        , value = model.type_
                        , options = [ Step, CircleStep ]
                        , fromString = stepTypeFromString
                        , toString = stepTypeToString
                        , onChange = (\type_ c -> { c | type_ = type_ }) >> UpdateConfig
                        , note = ""
                        }
                    ]
              }
            , { label = "Progress"
              , configs =
                    [ Playground.radio
                        { label = ""
                        , name = "progress"
                        , value = model.progress
                        , options = [ Shipping, Billing, ConfirmOrder ]
                        , fromString = progressFromString
                        , toString = progressToString
                        , onChange = (\progress c -> { c | progress = progress }) >> UpdateConfig
                        , note = ""
                        }
                    ]
              }
            , { label = "Content"
              , configs =
                    [ Playground.bool
                        { label = "Icon"
                        , id = "icon"
                        , bool = model.hasIcon
                        , onClick = (\c -> { c | hasIcon = not c.hasIcon }) |> UpdateConfig
                        , note = "A step can contain an icon"
                        }
                    , Playground.bool
                        { label = "Description"
                        , id = "description"
                        , bool = model.hasDescription
                        , onClick = (\c -> { c | hasDescription = not c.hasDescription }) |> UpdateConfig
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
