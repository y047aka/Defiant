module Pages.Elements.CircleStep exposing (page)

import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.CircleStep as CircleStep
import UI.Example exposing (example)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Circle Step"
            , body = view
            }
        }


view : List (Html msg)
view =
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
