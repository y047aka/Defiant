module Playground exposing (Node(..), playground)

import Control exposing (Control)
import Css exposing (..)
import Css.Extra exposing (columnGap, fr, grid, gridTemplateColumns, rowGap)
import Css.Palette exposing (palette, paletteWithBorder)
import DesignToken.Palette as Palette
import Html.Styled as Html exposing (Html, div, header, section, text)
import Html.Styled.Attributes exposing (css)


type Node a
    = Comment String
    | Field String (Control a)


playground :
    { isDarkMode : Bool
    , toMsg : (a -> a) -> msg
    , preview : Html msg
    , controlSections : List { heading : String, controls : List (Node a) }
    }
    -> Html msg
playground { isDarkMode, toMsg, preview, controlSections } =
    let
        controlSection { heading, controls } =
            Html.map toMsg
                (div
                    [ css
                        [ padding (Css.em 0.75)
                        , displayFlex
                        , flexDirection column
                        , rowGap (Css.em 1)
                        , palette (Palette.controlSection isDarkMode)
                        , nthChild "n+2" [ paletteWithBorder (borderTop3 (px 1) solid) (Palette.controlSection isDarkMode) ]
                        ]
                    ]
                    (header
                        [ css
                            [ displayFlex
                            , justifyContent spaceBetween
                            , alignItems center
                            , fontWeight bold
                            , empty [ display none ]
                            ]
                        ]
                        [ text heading ]
                        :: List.map controlField controls
                    )
                )

        controlField node =
            case node of
                Comment str ->
                    div
                        [ css
                            [ palette Palette.textOptional
                            , empty [ display none ]
                            ]
                        ]
                        [ text str ]

                Field label control ->
                    div
                        [ css
                            [ display grid
                            , gridTemplateColumns [ fr 1, fr 1 ]
                            , alignItems center
                            , columnGap (em 0.25)
                            ]
                        ]
                        [ Html.label [] [ text label ]
                        , control.view
                        ]
    in
    section
        [ css
            [ padding (Css.em 0.8)
            , borderRadius (Css.em 1.5)
            , display grid
            , property "grid-template-columns" "1fr 25em"
            , columnGap (Css.em 1.5)
            , fontSize (px 14)
            , paletteWithBorder (border3 (px 1) solid) (Palette.playground isDarkMode)
            ]
        ]
        [ div
            [ css
                [ displayFlex
                , flexDirection column
                , justifyContent center
                , property "transform" "translate3d(0, 0, 0)" -- SnackBarの表示位置をpreviewセクション内部に収めるためのhack
                ]
            ]
            [ preview ]
        , div
            [ css
                [ alignSelf start
                , borderRadius (Css.em 1)
                , overflow hidden
                , paletteWithBorder (border3 (px 1) solid) (Palette.controlSection isDarkMode)
                ]
            ]
            (List.map controlSection controlSections)
        ]
