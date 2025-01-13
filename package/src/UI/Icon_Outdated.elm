module UI.Icon_Outdated exposing (icon)

import Css exposing (..)
import FontAwesome.Icon
import Html.Styled as Html exposing (Attribute, Html, fromUnstyled)
import Icon_Outdated.Brands as Brands
import Icon_Outdated.Regular as Regular
import Icon_Outdated.Solid as Solid


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

        -- i.icon:before
        , before
            [ property "background" "none" |> important ]
        ]
        attributes
        [ svg ]
