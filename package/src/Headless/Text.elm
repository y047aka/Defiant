module Headless.Text exposing
    ( TextProps, defaultTextProps
    , text
    )

{-|

@docs TextProps, TextAs, defaultTextProps
@docs text

-}

import Html.Styled as Html exposing (Attribute, Html)


type alias TextProps =
    { textAs : TextAs
    }


type TextAs
    = Span
    | Div
    | Label
    | P


defaultTextProps : TextProps
defaultTextProps =
    { textAs = Span }


text : TextProps -> String -> Html msg
text props string =
    Html.styled (textAsToTag props.textAs) [] [] [ Html.text string ]



-- PRIVATE HELPERS


textAsToTag : TextAs -> (List (Attribute msg) -> List (Html msg) -> Html msg)
textAsToTag textAs =
    case textAs of
        Span ->
            Html.span

        Div ->
            Html.div

        Label ->
            Html.label

        P ->
            Html.p
