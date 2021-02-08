module UI.Icon exposing (icon)

import Css exposing (..)
import FontAwesome.Icon
import Html.Styled as Html exposing (Attribute, Html, fromUnstyled)
import Icon.Brands as Brands
import Icon.Regular as Regular
import Icon.Solid as Solid
import Svg.Styled as Svg


icon : List (Attribute msg) -> String -> Html msg
icon attributes str =
    let
        maybeIcon =
            case String.words str of
                [ "fab", symbol ] ->
                    String.dropLeft 3 symbol |> Brands.fromString

                [ "far", symbol ] ->
                    String.dropLeft 3 symbol |> Regular.fromString

                [ "fas", symbol ] ->
                    String.dropLeft 3 symbol |> Solid.fromString

                _ ->
                    Nothing

        svg =
            maybeIcon
                |> Maybe.map (FontAwesome.Icon.viewIcon >> fromUnstyled)
                |> Maybe.withDefault (Html.text "")
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
            [ svg ]
        ]
