module UI.Icon exposing (icon)

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html)
import Svg.Styled as Svg
import Svg.Styled.Attributes exposing (xlinkHref)


icon : List (Attribute msg) -> String -> Html msg
icon attributes str =
    let
        ( fileName, symbolName ) =
            case String.words str of
                [ "fab", s ] ->
                    ( "brands", String.dropLeft 3 s )

                [ "far", s ] ->
                    ( "regular", String.dropLeft 3 s )

                [ "fas", s ] ->
                    ( "solid", String.dropLeft 3 s )

                _ ->
                    ( "", "" )

        url =
            "./static/sprites/" ++ fileName ++ ".svg#" ++ symbolName
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
        attributes
        [ Svg.styled Svg.svg
            [ -- i.icon:before
              property "background" "none" |> important

            -- Override
            , width (em 1.18)
            , height (em 1)
            , verticalAlign bottom
            , fill currentColor
            ]
            []
            [ Svg.use [ xlinkHref url ] [] ]
        ]
