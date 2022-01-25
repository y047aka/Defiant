module Page.Collections.Breadcrumb exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html, text)
import Shared exposing (Shared)
import UI.Breadcrumb exposing (breadcrumb)
import UI.Example exposing (example)
import UI.Icon exposing (icon)
import UI.Segment exposing (segment)


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
view { shared } =
    let
        inverted =
            shared.darkMode
    in
    [ example
        { title = "Breadcrumb"
        , description = "A standard breadcrumb"
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ breadcrumb { divider = icon [] "fas fa-angle-right", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        ]
    , example
        { title = "Divider"
        , description = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Registration", url = "/" }
            , { label = "Personal Information", url = "" }
            ]
        ]
    , example
        { title = "Active"
        , description = "A section can be active"
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Products", url = "/" }
            , { label = "Paper Towels", url = "" }
            ]
        ]
    , example
        { title = "Inverted"
        , description = "A breadcrumb can be inverted"
        }
        [ segment { inverted = True }
            []
            [ breadcrumb { divider = text "/", inverted = True }
                [ { label = "Home", url = "/" }
                , { label = "Registration", url = "/" }
                , { label = "Personal Information", url = "" }
                ]
            ]
        ]
    ]
