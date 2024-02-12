module Page.Layout.Sidebar exposing (Model, Msg, init, update, view)

import Basics.Extra exposing (decrementIfPositive)
import Control
import Html.Styled exposing (Html, p, text)
import Playground exposing (playground)
import Shared
import UI.Header as Header
import UI.Layout.Box as Box exposing (box)
import UI.Layout.Sidebar as Sidebar exposing (withSidebar)



-- INIT


type alias Model =
    { props : Sidebar.Props }


init : Model
init =
    { props = Sidebar.defaultProps }



-- UPDATE


type Msg
    = UpdateProps (Sidebar.Props -> Sidebar.Props)
    | SideWithPlus
    | SideWithMinus
    | ContentMinPlus
    | ContentMinMinus
    | SpacePlus
    | SpaceMinus


update : Msg -> Model -> Model
update msg m =
    let
        p =
            m.props
    in
    case msg of
        UpdateProps updater ->
            { m | props = updater m.props }

        SideWithPlus ->
            { m | props = Sidebar.setSideWith (p.sideWith + 1) p }

        SideWithMinus ->
            { m | props = Sidebar.setSideWith (decrementIfPositive 1 p.sideWith) p }

        ContentMinPlus ->
            { m | props = Sidebar.setContentMin (p.contentMin + 1) p }

        ContentMinMinus ->
            { m | props = Sidebar.setContentMin (decrementIfPositive 1 p.contentMin) p }

        SpacePlus ->
            { m | props = Sidebar.setSpace (((p.space * 10) + 1) / 10) p }

        SpaceMinus ->
            { m | props = Sidebar.setSpace (decrementIfPositive 0.1 p.space) p }



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } { props } =
    [ Header.header { theme = theme } [] [ text "Sidebar" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ withSidebar props
                []
                [ box Box.defaultProps [] []
                , box Box.defaultProps [] [ text "Search" ]
                ]
            ]
        , controlSections =
            [ { label = "side"
              , configs =
                    [ Control.select
                        { value = props.side
                        , options = [ "left", "right" ]
                        , onChange = Sidebar.setSide >> UpdateProps
                        }
                    ]
              }
            , { label = "sideWith"
              , configs =
                    [ Control.counter
                        { value = props.sideWith
                        , toString = \value -> String.fromFloat value ++ " rem"
                        , onClickPlus = SideWithPlus
                        , onClickMinus = SideWithMinus
                        }
                    ]
              }
            , { label = "contentMin"
              , configs =
                    [ Control.counter
                        { value = props.contentMin
                        , toString = \value -> String.fromFloat value ++ " %"
                        , onClickPlus = ContentMinPlus
                        , onClickMinus = ContentMinMinus
                        }
                    ]
              }
            , { label = "space"
              , configs =
                    [ Control.counter
                        { value = props.space
                        , toString = \value -> String.fromFloat value ++ " rem"
                        , onClickPlus = SpacePlus
                        , onClickMinus = SpaceMinus
                        }
                    ]
              }
            , { label = "noStretch"
              , configs =
                    [ Control.field "noStretch"
                        (Control.bool
                            { id = "noStretch"
                            , value = props.noStretch
                            , onClick = Sidebar.setNoStretch (not props.noStretch) |> UpdateProps
                            }
                        )
                    ]
              }
            ]
        }
    ]
