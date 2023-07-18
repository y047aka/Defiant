module Page.Layout.Stack exposing (Model, Msg, init, update, view)

import Basics.Extra exposing (decrementIfPositive)
import Html.Styled exposing (Html, a, h2, p, strong, text)
import Html.Styled.Attributes exposing (href)
import Playground exposing (playground)
import Shared
import UI.Layout.Stack as Stack exposing (stack)



-- INIT


type alias Model =
    { props : Stack.Props }


init : Model
init =
    { props = Stack.defaultProps }



-- UPDATE


type Msg
    = CounterPlus
    | CounterMinus


update : Msg -> Model -> Model
update msg m =
    let
        p =
            m.props
    in
    case msg of
        CounterPlus ->
            { m | props = Stack.setGap (((p.gap * 10) + 1) / 10) p }

        CounterMinus ->
            { m | props = Stack.setGap (decrementIfPositive 0.1 p.gap) p }



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } { props } =
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
        { title = "Stack"
        , theme = theme
        , inverted = False
        , preview =
            [ stack props
                []
                [ h2 [] [ text "Header" ]
                , content
                , content
                ]
            ]
        , configSections =
            [ { label = "gap"
              , configs =
                    [ Playground.counter
                        { label = ""
                        , value = props.gap
                        , toString = \value -> String.fromFloat value ++ " rem"
                        , onClickPlus = CounterPlus
                        , onClickMinus = CounterMinus
                        , note = ""
                        }
                    ]
              }
            ]
        }
    ]
