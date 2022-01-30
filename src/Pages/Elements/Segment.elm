module Pages.Elements.Segment exposing (page)

import Html.Styled as Html exposing (Html, p, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example, wireframeShortParagraph)
import UI.Segment exposing (basicSegment, disabledSegment, invertedSegment, paddedSegment, segment, verticalSegment, veryPaddedSegment)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Segment"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


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
