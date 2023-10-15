module Page.Layout.Center exposing (Model, Msg, init, update, view)

import Basics.Extra exposing (decrementIfPositive)
import Html.Styled exposing (Html, a, h2, p, strong, text)
import Html.Styled.Attributes exposing (href)
import Playground exposing (playground)
import Props
import Shared
import UI.Header as Header
import UI.Layout.Center as Center exposing (center)



-- INIT


type alias Model =
    { props : Center.Props }


init : Model
init =
    { props = Center.defaultProps }



-- UPDATE


type Msg
    = UpdateProps (Center.Props -> Center.Props)
    | MaxPlus
    | MaxMinus
    | GuttersPlus
    | GuttersMinus


update : Msg -> Model -> Model
update msg m =
    let
        p =
            m.props
    in
    case msg of
        UpdateProps updater ->
            { m | props = updater m.props }

        MaxPlus ->
            { m | props = Center.setMax (p.max + 1) p }

        MaxMinus ->
            { m | props = Center.setMax (decrementIfPositive 1 p.max) p }

        GuttersPlus ->
            { m | props = Center.setGutters (((p.gutters * 10) + 1) / 10) p }

        GuttersMinus ->
            { m | props = Center.setGutters (decrementIfPositive 0.1 p.gutters) p }



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
    [ Header.header { theme = theme } [] [ text "Center" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ center props
                []
                [ h2 [] [ text "Header" ]
                , content
                , content
                ]
            ]
        , configSections =
            [ { label = "max"
              , configs =
                    [ Props.counter
                        { value = props.max
                        , toString = \value -> String.fromFloat value ++ " ch"
                        , onClickPlus = MaxPlus
                        , onClickMinus = MaxMinus
                        }
                    ]
              }
            , { label = "andText"
              , configs =
                    [ Props.bool
                        { label = "andText"
                        , value = props.andText
                        , onClick = Center.setAndText (not props.andText) |> UpdateProps
                        }
                    ]
              }
            , { label = "gutters"
              , configs =
                    [ Props.counter
                        { value = props.gutters
                        , toString = \value -> String.fromFloat value ++ " rem"
                        , onClickPlus = GuttersPlus
                        , onClickMinus = GuttersMinus
                        }
                    ]
              }
            , { label = "intrinsic"
              , configs =
                    [ Props.bool
                        { label = "intrinsic"
                        , value = props.intrinsic
                        , onClick = Center.setIntrinsic (not props.intrinsic) |> UpdateProps
                        }
                    ]
              }
            ]
        }
    ]
