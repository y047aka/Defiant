module UI.Icon exposing (icon)

import Css exposing (..)
import Html.Styled as Html exposing (Html)
import Svg.Styled as Svg
import Svg.Styled.Attributes exposing (xlinkHref)


icon : String -> String -> Html msg
icon type_ symbolName =
    let
        fileName =
            case type_ of
                "fab" ->
                    "brands"

                "far" ->
                    "regular"

                "fas" ->
                    "solid"

                _ ->
                    ""
    in
    Html.styled Html.i
        [ -- i.icon
          display inlineBlock
        , opacity (int 1)
        , margin4 zero (rem 0.25) zero zero
        , width (em 1.18)
        , height (em 1)
        , textAlign center
        , property "speak" "none"
        ]
        []
        [ Svg.styled Svg.svg
            [ -- i.icon:before
              property "background" "none" |> important

            -- Override
            , maxWidth (pct 100)
            , maxHeight (pct 100)
            ]
            []
            [ Svg.use [ xlinkHref <| "./static/sprites/" ++ fileName ++ ".svg#" ++ symbolName ] [] ]
        ]
