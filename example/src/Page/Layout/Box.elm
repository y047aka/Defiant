module Page.Layout.Box exposing (Model, Msg, init, update, view)

import Basics.Extra exposing (decrementIfPositive)
import Html.Styled exposing (Html, a, h2, p, strong, text)
import Html.Styled.Attributes exposing (href)
import Playground exposing (playground)
import Shared
import UI.Layout.Box as Box exposing (box)



-- INIT


type alias Model =
    { props : Box.Props }


init : Model
init =
    { props = Box.defaultProps }



-- UPDATE


type Msg
    = UpdateProps (Box.Props -> Box.Props)
    | PaddingPlus
    | PaddingMinus
    | BorderPlus
    | BorderMinus


update : Msg -> Model -> Model
update msg m =
    let
        p =
            m.props
    in
    case msg of
        UpdateProps updater ->
            { m | props = updater m.props }

        PaddingPlus ->
            { m | props = Box.setPadding (((p.padding * 10) + 1) / 10) p }

        PaddingMinus ->
            { m
                | props =
                    p.padding
                        |> decrementIfPositive 0.1
                        |> (\v -> Box.setPadding v p)
            }

        BorderPlus ->
            { m | props = Box.setBorderWidth (p.borderWidth + 1) p }

        BorderMinus ->
            { m | props = Box.setBorderWidth (decrementIfPositive 1 p.borderWidth) p }



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
        { title = "Box"
        , theme = theme
        , inverted = False
        , preview =
            [ box props
                []
                [ h2 [] [ text "Header" ]
                , content
                , content
                ]
            ]
        , configSections =
            [ { label = "Padding"
              , configs =
                    [ Playground.counter
                        { label = ""
                        , value = props.padding
                        , toString = \value -> String.fromFloat value ++ " rem"
                        , onClickPlus = PaddingPlus
                        , onClickMinus = PaddingMinus
                        , note = ""
                        }
                    ]
              }
            , { label = "Border width"
              , configs =
                    [ Playground.counter
                        { label = ""
                        , value = props.borderWidth
                        , toString = \value -> String.fromFloat value ++ " px"
                        , onClickPlus = BorderPlus
                        , onClickMinus = BorderMinus
                        , note = ""
                        }
                    ]
              }
            , { label = "Invert"
              , configs =
                    [ Playground.bool
                        { id = "invert"
                        , label = "Invert"
                        , bool = props.invert
                        , onClick = Box.setInvert (not props.invert) |> UpdateProps
                        , note = ""
                        }
                    ]
              }
            ]
        }
    ]
