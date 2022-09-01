module Pages.Elements.CircleStep exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html)
import Page
import Pages.Elements.Step exposing (Progress(..), progressFromString, progressToString)
import Request exposing (Request)
import Shared
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
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Model -> List (Html Msg)
view model =
    [ configAndPreview UpdateConfig
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
        , configSections =
            [ { label = "Progress"
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
    , configAndPreview UpdateConfig
        { title = "Step"
        , preview =
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
        , configSections =
            [ { label = "States"
              , configs =
                    [ { label = ""
                      , config =
                            Config.select
                                { value = model.state
                                , options = [ Default, Active, Completed, Disabled ]
                                , fromString = CircleStep.stateFromString
                                , toString = CircleStep.stateToString
                                , setter = \state m -> { m | state = state }
                                }
                      , note =
                            case model.state of
                                Default ->
                                    ""

                                Active ->
                                    "A step can be highlighted as active"

                                Completed ->
                                    "A step can show that a user has completed it"

                                Disabled ->
                                    "A step can show that it cannot be selected"
                      }
                    ]
              }
            ]
        }
    ]
