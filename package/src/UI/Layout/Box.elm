module UI.Layout.Box exposing
    ( Props, defaultProps
    , box
    , setPadding, setBorderWidth, setPalette, setInvert
    )

{-|

@docs Props, defaultProps
@docs box
@docs setPadding, setBorderWidth, setPalette, setInvert

-}

import Css exposing (..)
import Css.Global exposing (descendants, everything)
import Css.Palette as Palette exposing (Palette, palette)
import Html.Styled as Html exposing (Attribute, Html, div)


type alias Props =
    { padding : Float
    , borderWidth : Float
    , palette : Palette
    , invert : Bool
    }


defaultProps : Props
defaultProps =
    { padding = 1.5
    , borderWidth = 1
    , palette = Palette.init |> (\p -> { p | background = Just (hex "FFF"), color = Just (hex "000") })
    , invert = False
    }


box : Props -> List (Attribute msg) -> List (Html msg) -> Html msg
box props atributes items =
    Html.styled div
        [ padding (rem props.padding)
        , border2 (px props.borderWidth) solid
        , palette <|
            if props.invert then
                invert props.palette

            else
                props.palette
        , descendants
            [ everything [ color inherit ] ]
        ]
        atributes
        items


invert : Palette -> Palette
invert p =
    { p | background = p.color, color = p.background }



-- HELPERS


setPadding : Float -> Props -> Props
setPadding val props =
    { props | padding = val }


setBorderWidth : Float -> Props -> Props
setBorderWidth val props =
    { props | borderWidth = val }


setPalette : Palette -> Props -> Props
setPalette palette props =
    { props | palette = palette }


setInvert : Bool -> Props -> Props
setInvert bool props =
    { props | invert = bool }
