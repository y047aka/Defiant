module Page.Layout.Cluster exposing (Model, Msg, init, update, view)

import Basics.Extra exposing (decrementIfPositive)
import Html.Styled exposing (Html, p, text)
import Playground exposing (playground)
import Props
import Shared
import UI.Header as Header
import UI.Layout.Box as Box exposing (box)
import UI.Layout.Cluster as Cluster exposing (cluster)



-- INIT


type alias Model =
    { props : Cluster.Props }


init : Model
init =
    { props = Cluster.defaultProps }



-- UPDATE


type Msg
    = UpdateProps (Cluster.Props -> Cluster.Props)
    | CounterPlus
    | CounterMinus


update : Msg -> Model -> Model
update msg m =
    let
        p =
            m.props
    in
    case msg of
        UpdateProps updater ->
            { m | props = updater m.props }

        CounterPlus ->
            { m | props = Cluster.setGap (((p.gap * 10) + 1) / 10) p }

        CounterMinus ->
            { m | props = Cluster.setGap (decrementIfPositive 0.1 p.gap) p }



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } { props } =
    [ Header.header { theme = theme } [] [ text "Cluster" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ cluster props [] <|
                List.map (\item -> box Box.defaultProps [] [ text item ])
                    [ "Layout", "CSS", "Web Design", "Code", "Front-end", "Development" ]
            ]
        , configSections =
            [ { label = "justify"
              , configs =
                    [ Props.select
                        { value = props.justify
                        , options = [ "start", "end", "flex-start", "flex-end", "center", "space-between", "space-around", "space-evenly" ]
                        , onChange = Cluster.setJustify >> UpdateProps
                        }
                    , Props.comment "https://developer.mozilla.org/ja/docs/Web/CSS/justify-content"
                    ]
              }
            , { label = "align"
              , configs =
                    [ Props.select
                        { value = props.align
                        , options = [ "start", "end", "flex-start", "flex-end", "center", "stretch" ]
                        , onChange = Cluster.setAlign >> UpdateProps
                        }
                    , Props.comment "https://developer.mozilla.org/ja/docs/Web/CSS/align-items"
                    ]
              }
            , { label = "gap"
              , configs =
                    [ Props.counter
                        { value = props.gap
                        , toString = \value -> String.fromFloat value ++ " rem"
                        , onClickPlus = CounterPlus
                        , onClickMinus = CounterMinus
                        }
                    ]
              }
            ]
        }
    ]
