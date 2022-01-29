module Pages.Elements.CircleStep exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html)
import Shared exposing (Shared)
import UI.CircleStep as CircleStep
import UI.Example exposing (example)


architecture : Architecture Model Msg
architecture =
    { init = init
    , update = update
    , view = view
    }


type alias Model =
    { shared : Shared }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared }, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> List (Html msg)
view _ =
    [ example
        { title = "Step"
        , description = "A single step"
        }
        [ CircleStep.steps []
            [ CircleStep.step []
                { icon = ""
                , title = ""
                , description = "Shipping"
                }
            ]
        ]
    , example
        { title = "Steps"
        , description = "A set of steps"
        }
        [ CircleStep.steps []
            [ CircleStep.completedStep []
                { icon = "fas fa-truck"
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            , CircleStep.activeStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            , CircleStep.disabledStep []
                { icon = "fas fa-info"
                , title = "Confirm Order"
                , description = ""
                }
            ]
        ]
    , example
        { title = "Description"
        , description = "A step can contain a description"
        }
        [ CircleStep.steps []
            [ CircleStep.step []
                { icon = ""
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            ]
        ]
    , example
        { title = "Icon"
        , description = "A step can contain an icon"
        }
        [ CircleStep.steps []
            [ CircleStep.step []
                { icon = "fas fa-truck"
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            ]
        ]
    , example
        { title = "Active"
        , description = "A step can be highlighted as active"
        }
        [ CircleStep.steps []
            [ CircleStep.activeStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            ]
        ]
    , example
        { title = "Completed"
        , description = "A step can show that a user has completed it"
        }
        [ CircleStep.steps []
            [ CircleStep.completedStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            ]
        ]
    , example
        { title = "Disabled"
        , description = "A step can show that it cannot be selected"
        }
        [ CircleStep.steps []
            [ CircleStep.disabledStep []
                { icon = ""
                , title = ""
                , description = "Billing"
                }
            ]
        ]
    ]
