module Pages.Elements.Label exposing (page)

import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Icon exposing (icon)
import UI.Label as Label exposing (..)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Label"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ example
        { title = "Label"
        , description = "A label"
        }
        [ Label.label [] [ icon [] "fas fa-envelope", text "23" ] ]
    , example
        { title = "Icon"
        , description = "A label can include an icon"
        }
        [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
        , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
        , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
        , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
        , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
        , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
        , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Label.label [] [ icon [] "fas fa-envelope" ]
        , Label.label [] [ icon [] "fas fa-dog" ]
        , Label.label [] [ icon [] "fas fa-cat" ]
        ]
    , example
        { title = "Basic"
        , description = "A label can reduce its complexity"
        }
        [ basicLabel [] [ text "Basic" ] ]
    , example
        { title = "Colored"
        , description = "A label can have different colors"
        }
        [ primaryLabel [] [ text "Primary" ]
        , secondaryLabel [] [ text "Secondary" ]
        , redLabel [] [ text "Red" ]
        , orangeLabel [] [ text "Orange" ]
        , yellowLabel [] [ text "Yellow" ]
        , oliveLabel [] [ text "Olive" ]
        , greenLabel [] [ text "Green" ]
        , tealLabel [] [ text "Teal" ]
        , blueLabel [] [ text "Blue" ]
        , violetLabel [] [ text "Violet" ]
        , purpleLabel [] [ text "Purple" ]
        , pinkLabel [] [ text "Pink" ]
        , brownLabel [] [ text "Brown" ]
        , greyLabel [] [ text "Grey" ]
        , blackLabel [] [ text "Black" ]
        ]
    ]
