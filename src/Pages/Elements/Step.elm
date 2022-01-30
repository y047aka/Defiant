module Pages.Elements.Step exposing (page)

import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Step exposing (activeStep, completedStep, disabledStep, step, steps)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Step"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ example
        { title = "Step"
        , description = "A single step"
        }
        [ steps []
            [ step []
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
    , example
        { title = "Description"
        , description = "A step can contain a description"
        }
        [ steps []
            [ step []
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
        [ steps []
            [ step []
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
        [ steps []
            [ activeStep []
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
        [ steps []
            [ completedStep []
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
        [ steps []
            [ disabledStep []
                { icon = ""
                , title = ""
                , description = "Billing"
                }
            ]
        ]
    ]
