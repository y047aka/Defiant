module UI.Layout.Sidebar exposing
    ( Props, defaultProps
    , withSidebar
    , setSide, setSideWith, setContentMin, setSpace, setNoStretch
    )

{-|

@docs Props, defaultProps
@docs withSidebar
@docs setSide, setSideWith, setContentMin, setSpace, setNoStretch

-}

import Css exposing (..)
import Css.Extra exposing (batchIf, gap)
import Css.Global exposing (children, selector)
import Html.Styled as Html exposing (Attribute, Html, div)


type alias Props =
    { side : String
    , sideWith : Float
    , contentMin : Float
    , space : Float
    , noStretch : Bool
    }


defaultProps : Props
defaultProps =
    { side = "left"
    , sideWith = 20
    , contentMin = 50
    , space = 1
    , noStretch = False
    }


withSidebar : Props -> List (Attribute msg) -> List (Html msg) -> Html msg
withSidebar props atributes items =
    let
        ( sidebar, notSidebar ) =
            if props.side /= "left" then
                ( selector ":last-child", selector ":first-child" )

            else
                ( selector ":first-child", selector ":last-child" )
    in
    Html.styled div
        [ displayFlex
        , flexWrap wrap
        , gap (rem props.space)
        , batchIf props.noStretch [ alignItems flexStart ]
        , children
            [ sidebar
                [ flexBasis (rem props.sideWith)
                , flexGrow (int 1)
                ]
            , notSidebar
                [ property "flex-basis" "0"
                , flexGrow (int 999)
                , minWidth (pct props.contentMin)
                ]
            ]
        ]
        atributes
        items



-- HELPERS


setSide : String -> Props -> Props
setSide val props =
    { props | side = val }


setSideWith : Float -> Props -> Props
setSideWith val props =
    { props | sideWith = val }


setContentMin : Float -> Props -> Props
setContentMin val props =
    { props | contentMin = val }


setSpace : Float -> Props -> Props
setSpace val props =
    { props | space = val }


setNoStretch : Bool -> Props -> Props
setNoStretch bool props =
    { props | noStretch = bool }
