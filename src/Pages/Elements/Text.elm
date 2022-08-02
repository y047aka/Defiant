module Pages.Elements.Text exposing (page)

import Html.Styled as Html exposing (Html, p, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Segment exposing (segment)
import UI.Text exposing (..)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Text"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
    let
        options =
            { theme = shared.theme }
    in
    [ example
        { title = "Text"
        , description = "A text is always used inline and uses one color from the FUI color palette"
        }
        [ segment options
            []
            [ text "This is "
            , redText options "red"
            , text " inline text and this is "
            , blueText options "blue"
            , text " inline text and this is "
            , purpleText options "purple"
            , text " inline text"
            ]
        , segment options
            []
            [ text "This is "
            , infoText "info"
            , text " inline text and this is "
            , successText "success"
            , text " inline text and this is "
            , warningText "warning"
            , text " inline text and this is "
            , errorText "error"
            , text " inline text"
            ]
        ]
    , example
        { title = "Size"
        , description = "Text can vary in the same sizes as icons"
        }
        [ segment options
            []
            [ p [] [ text "Starting with ", miniText "mini", text " text" ]
            , p [] [ text "which turns into ", tinyText "tiny", text " text" ]
            , p [] [ text "changing to ", smallText "small", text " text until it is" ]
            , p [] [ text "the default ", mediumText "medium", text " text" ]
            , p [] [ text "and could be ", largeText "large", text " text" ]
            , p [] [ text "to turn into ", bigText "big", text " text" ]
            , p [] [ text "then growing to ", hugeText "huge", text " text" ]
            , p [] [ text "to finally become ", massiveText "massive", text " text" ]
            ]
        ]
    ]
