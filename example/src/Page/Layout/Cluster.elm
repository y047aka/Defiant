module Page.Layout.Cluster exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html, p, text)
import Playground exposing (playground)
import Shared
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
            { m | props = setGap (((p.gap * 10) + 1) / 10) p }

        CounterMinus ->
            { m | props = setGap (decrementIfPositive 0.1 p.gap) p }


setGap : Float -> Cluster.Props -> Cluster.Props
setGap gap props =
    { props | gap = gap }


decrementIfPositive : Float -> Float -> Float
decrementIfPositive step value =
    if value > 0 then
        ((value * 10) - (step * 10)) / 10

    else
        value



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } { props } =
    [ playground
        { title = "Cluster"
        , theme = theme
        , inverted = False
        , preview =
            [ cluster props [] <|
                List.map (\item -> box Box.defaultProps [] [ text item ])
                    [ "Layout", "CSS", "Web Design", "Code", "Front-end", "Development" ]
            ]
        , configSections =
            [ { label = "justify"
              , configs =
                    [ Playground.select
                        { label = ""
                        , value = props.justify
                        , options = [ "start", "end", "flex-start", "flex-end", "center", "space-between", "space-around", "space-evenly" ]
                        , fromString = identity >> Just
                        , toString = identity
                        , onChange = (\justify p -> { p | justify = justify }) >> UpdateProps
                        , note = "https://developer.mozilla.org/ja/docs/Web/CSS/justify-content"
                        }
                    ]
              }
            , { label = "align"
              , configs =
                    [ Playground.select
                        { label = ""
                        , value = props.align
                        , options = [ "start", "end", "flex-start", "flex-end", "center", "stretch" ]
                        , fromString = identity >> Just
                        , toString = identity
                        , onChange = (\align p -> { p | align = align }) >> UpdateProps
                        , note = "https://developer.mozilla.org/ja/docs/Web/CSS/align-items"
                        }
                    ]
              }
            , { label = "gap"
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
