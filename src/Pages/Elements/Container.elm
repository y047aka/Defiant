module Pages.Elements.Container exposing (page)

import Html.Styled as Html exposing (Html, a, h2, p, strong, text)
import Html.Styled.Attributes exposing (href)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Container exposing (container, textContainer)
import UI.Example exposing (example)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Container"
            , body = view
            }
        }


view : List (Html msg)
view =
    let
        content =
            p []
                [ text "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa "
                , strong [] [ text "strong" ]
                , text ". Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede "
                , a [ href "#" ] [ text "link" ]
                , text " mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi."
                ]
    in
    [ example
        { title = "Container"
        , description = "A standard container"
        }
        [ container [] [ content ] ]
    , example
        { title = "Text Container"
        , description = "A container can reduce its maximum width to more naturally accomodate a single column of text"
        }
        [ textContainer []
            [ h2 [] [ text "Header" ]
            , content
            , content
            ]
        ]
    ]
