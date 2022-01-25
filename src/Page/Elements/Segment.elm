module Page.Elements.Segment exposing (Model, Msg, architecture)

import Data.Architecture exposing (Architecture)
import Html.Styled as Html exposing (Html, p, text)
import Shared exposing (Shared)
import UI.Example exposing (example, wireframeShortParagraph)
import UI.Segment exposing (basicSegment, disabledSegment, invertedSegment, paddedSegment, segment, verticalSegment, veryPaddedSegment)


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
        options =
            { inverted = shared.darkMode }
    in
    [ example
        { title = "Segment"
        , description = "A segment of content"
        }
        [ segment options [] [ wireframeShortParagraph ] ]
    , example
        { title = "Vertical Segment"
        , description = "A vertical segment formats content to be aligned as part of a vertical group"
        }
        [ verticalSegment options [] [ wireframeShortParagraph ]
        , verticalSegment options [] [ wireframeShortParagraph ]
        , verticalSegment options [] [ wireframeShortParagraph ]
        ]
    , example
        { title = "Disabled"
        , description = "A segment may show its content is disabled"
        }
        [ disabledSegment options [] [ wireframeShortParagraph ] ]
    , example
        { title = "Inverted"
        , description = "A segment can have its colors inverted for contrast"
        }
        [ invertedSegment []
            [ p [] [ text "I'm here to tell you something, and you will probably read me first." ] ]
        ]
    , example
        { title = "Padded"
        , description = "A segment can increase its padding"
        }
        [ paddedSegment options [] [ wireframeShortParagraph ] ]
    , example
        { title = ""
        , description = ""
        }
        [ veryPaddedSegment options [] [ wireframeShortParagraph ] ]
    , example
        { title = "Basic"
        , description = "A basic segment has no special formatting"
        }
        [ basicSegment options
            []
            [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
        ]
    ]
