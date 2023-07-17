module Page.Layout.Container exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, a, h2, p, strong, text)
import Html.Styled.Attributes exposing (href)
import Playground exposing (playground)
import Shared
import UI.Container exposing (container, textContainer)



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type alias Msg =
    ()


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
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
    [ playground
        { title = "Container"
        , theme = theme
        , inverted = False
        , preview = [ container [] [ content ] ]
        , configSections = []
        }
    , playground
        { title = "Text Container"
        , theme = theme
        , inverted = False
        , preview =
            [ textContainer []
                [ h2 [] [ text "Header" ]
                , content
                , content
                ]
            ]
        , configSections = []
        }
    ]