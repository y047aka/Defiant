module Css.FontAwesome exposing (fontAwesome)

import Css exposing (..)
import Css.Animations as Animations exposing (keyframes)
import Css.Global exposing (Snippet, each, selector)


fontAwesome : List Snippet
fontAwesome =
    -- Font Awesome Free 5.15.2 by @fontawesome - <https://fontawesome.com>
    -- License - <https://fontawesome.com/license/free> (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License)
    [ selector "svg:not(:root).svg-inline--fa"
        [ overflow visible ]
    , selector ".svg-inline--fa"
        [ display inlineBlock
        , fontSize inherit
        , height (em 1)
        , overflow visible
        , property "vertical-align" "-0.125em"
        ]
    , selector ".svg-inline--fa.fa-lg"
        [ property "vertical-align" "-0.225em" ]
    , selector ".svg-inline--fa.fa-w-1"
        [ width (em 0.0625) ]
    , selector ".svg-inline--fa.fa-w-2"
        [ width (em 0.125) ]
    , selector ".svg-inline--fa.fa-w-3"
        [ width (em 0.1875) ]
    , selector ".svg-inline--fa.fa-w-4"
        [ width (em 0.25) ]
    , selector ".svg-inline--fa.fa-w-5"
        [ width (em 0.3125) ]
    , selector ".svg-inline--fa.fa-w-6"
        [ width (em 0.375) ]
    , selector ".svg-inline--fa.fa-w-7"
        [ width (em 0.4375) ]
    , selector ".svg-inline--fa.fa-w-8"
        [ width (em 0.5) ]
    , selector ".svg-inline--fa.fa-w-9"
        [ width (em 0.5625) ]
    , selector ".svg-inline--fa.fa-w-10"
        [ width (em 0.625) ]
    , selector ".svg-inline--fa.fa-w-11"
        [ width (em 0.6875) ]
    , selector ".svg-inline--fa.fa-w-12"
        [ width (em 0.75) ]
    , selector ".svg-inline--fa.fa-w-13"
        [ width (em 0.8125) ]
    , selector ".svg-inline--fa.fa-w-14"
        [ width (em 0.875) ]
    , selector ".svg-inline--fa.fa-w-15"
        [ width (em 0.9375) ]
    , selector ".svg-inline--fa.fa-w-16"
        [ width (em 1) ]
    , selector ".svg-inline--fa.fa-w-17"
        [ width (em 1.0625) ]
    , selector ".svg-inline--fa.fa-w-18"
        [ width (em 1.125) ]
    , selector ".svg-inline--fa.fa-w-19"
        [ width (em 1.1875) ]
    , selector ".svg-inline--fa.fa-w-20"
        [ width (em 1.25) ]
    , selector ".svg-inline--fa.fa-pull-left"
        [ marginRight (em 0.3)
        , width auto
        ]
    , selector ".svg-inline--fa.fa-pull-right"
        [ marginLeft (em 0.3)
        , width auto
        ]
    , selector ".svg-inline--fa.fa-border"
        [ height (em 1.5) ]
    , selector ".svg-inline--fa.fa-li"
        [ width (em 2) ]
    , selector ".svg-inline--fa.fa-fw"
        [ width (em 1.25) ]
    , selector ".fa-layers svg.svg-inline--fa"
        [ bottom zero
        , left zero
        , margin auto
        , position absolute
        , right zero
        , top zero
        ]
    , selector ".fa-layers"
        [ display inlineBlock
        , height (em 1)
        , position relative
        , textAlign center
        , property "vertical-align" "-0.125em"
        , width (em 1)
        ]
    , selector ".fa-layers svg.svg-inline--fa"
        [ property "-webkit-transform-origin" "center center"
        , property "transform-origin" "center center"
        ]
    , each
        [ selector ".fa-layers-tex"
        , selector ".fa-layers-counter"
        ]
        [ display inlineBlock
        , position absolute
        , textAlign center
        ]
    , selector ".fa-layers-text"
        [ left (pct 50)
        , top (pct 50)
        , property "-webkit-transform" "translate(-50%, -50%)"
        , property "transform" "translate(-50%, -50%)"
        , property "-webkit-transform-origin" "center center"
        , property "transform-origin" "center center"
        ]
    , selector ".fa-layers-counter"
        [ backgroundColor (hex "#ff253a")
        , borderRadius (em 1)
        , property "-webkit-box-sizing" "border-box"
        , boxSizing borderBox
        , color (hex "#fff")
        , height (em 1.5)
        , lineHeight (int 1)
        , maxWidth (em 5)
        , minWidth (em 1.5)
        , overflow hidden
        , padding (em 0.25)
        , right zero
        , textOverflow ellipsis
        , top zero
        , property "-webkit-transform" "scale(0.25)"
        , property "transform" "scale(0.25)"
        , property "-webkit-transform-origin" "top right"
        , property "transform-origin" "top right"
        ]
    , selector ".fa-layers-bottom-right"
        [ bottom zero
        , right zero
        , top auto
        , property "-webkit-transform" "scale(0.25)"
        , property "transform" "scale(0.25)"
        , property "-webkit-transform-origin" "bottom right"
        , property "transform-origin" "bottom right"
        ]
    , selector ".fa-layers-bottom-left"
        [ bottom zero
        , left zero
        , right auto
        , top auto
        , property "-webkit-transform" "scale(0.25)"
        , property "transform" "scale(0.25)"
        , property "-webkit-transform-origin" "bottom left"
        , property "transform-origin" "bottom left"
        ]
    , selector ".fa-layers-top-right"
        [ right zero
        , top zero
        , property "-webkit-transform" "scale(0.25)"
        , property "transform" "scale(0.25)"
        , property "-webkit-transform-origin" "top right"
        , property "transform-origin" "top right"
        ]
    , selector ".fa-layers-top-left"
        [ left zero
        , right auto
        , top zero
        , property "-webkit-transform" "scale(0.25)"
        , property "transform" "scale(0.25)"
        , property "-webkit-transform-origin" "top left"
        , property "transform-origin" "top left"
        ]
    , selector ".fa-lg"
        [ fontSize (em 1.33333)
        , lineHeight (em 0.75)
        , property "vertical-align" "-0.0667em"
        ]
    , selector ".fa-xs"
        [ fontSize (em 0.75) ]
    , selector ".fa-sm"
        [ fontSize (em 0.875) ]
    , selector ".fa-1x"
        [ fontSize (em 1) ]
    , selector ".fa-2x"
        [ fontSize (em 2) ]
    , selector ".fa-3x"
        [ fontSize (em 3) ]
    , selector ".fa-4x"
        [ fontSize (em 4) ]
    , selector ".fa-5x"
        [ fontSize (em 5) ]
    , selector ".fa-6x"
        [ fontSize (em 6) ]
    , selector ".fa-7x"
        [ fontSize (em 7) ]
    , selector ".fa-8x"
        [ fontSize (em 8) ]
    , selector ".fa-9x"
        [ fontSize (em 9) ]
    , selector ".fa-10x"
        [ fontSize (em 10) ]
    , selector ".fa-fw"
        [ textAlign center
        , width (em 1.25)
        ]
    , selector ".fa-ul"
        [ listStyleType none
        , marginLeft (em 2.5)
        , paddingLeft zero
        ]
    , selector ".fa-ul > li"
        [ position relative ]
    , selector ".fa-li"
        [ left (em -2)
        , position absolute
        , textAlign center
        , width (em 2)
        , lineHeight inherit
        ]
    , selector ".fa-border"
        [ border3 (em 0.08) solid (hex "#eee")
        , borderRadius (em 0.1)
        , padding3 (em 0.2) (em 0.25) (em 0.15)
        ]
    , selector ".fa-pull-left"
        [ float left ]
    , selector ".fa-pull-right"
        [ float right ]
    , each
        [ selector ".fa.fa-pull-lef"
        , selector ".fas.fa-pull-lef"
        , selector ".far.fa-pull-lef"
        , selector ".fal.fa-pull-lef"
        , selector ".fab.fa-pull-left"
        ]
        [ marginRight (em 0.3) ]
    , each
        [ selector ".fa.fa-pull-righ"
        , selector ".fas.fa-pull-righ"
        , selector ".far.fa-pull-righ"
        , selector ".fal.fa-pull-righ"
        , selector ".fab.fa-pull-right"
        ]
        [ marginLeft (em 0.3) ]
    , selector ".fa-spin"
        [ property "-webkit-animation" "fa-spin 2s infinite linear"
        , property "animation" "fa-spin 2s infinite linear"
        ]
    , let
        fa_spin =
            keyframes
                [ ( 0
                  , [ Animations.property "-webkit-transform" "rotate(0deg)"
                    , Animations.transform [ rotate (deg 0) ]
                    ]
                  )
                , ( 100
                  , [ Animations.property "-webkit-transform" "rotate(360deg)"
                    , Animations.transform [ rotate (deg 360) ]
                    ]
                  )
                ]
      in
      selector ".fa-pulse"
        [ property "-webkit-animation" "fa-spin 1s infinite steps(8)"
        , property "animation" "fa-spin 1s infinite steps(8)"
        , animationName fa_spin
        ]
    , selector ".fa-rotate-90"
        [ property "-ms-filter" "\"progid:DXImageTransform.Microsoft.BasicImage(rotation=1)\""
        , property "-webkit-transform" "rotate(90deg)"
        , property "transform" "rotate(90deg)"
        ]
    , selector ".fa-rotate-180"
        [ property "-ms-filter" "\"progid:DXImageTransform.Microsoft.BasicImage(rotation=2)\""
        , property "-webkit-transform" "rotate(180deg)"
        , property "transform" "rotate(180deg)"
        ]
    , selector ".fa-rotate-270"
        [ property "-ms-filter" "\"progid:DXImageTransform.Microsoft.BasicImage(rotation=3)\""
        , property "-webkit-transform" "rotate(270deg)"
        , property "transform" "rotate(270deg)"
        ]
    , selector ".fa-flip-horizontal"
        [ property "-ms-filter" "\"progid:DXImageTransform.Microsoft.BasicImage(rotation=0, mirror=1)\""
        , property "-webkit-transform" "scale(-1, 1)"
        , property "transform" "scale(-1, 1)"
        ]
    , selector ".fa-flip-vertical"
        [ property "-ms-filter" "\"progid:DXImageTransform.Microsoft.BasicImage(rotation=2, mirror=1)\""
        , property "-webkit-transform" "scale(1, -1)"
        , property "transform" "scale(1, -1)"
        ]
    , each
        [ selector ".fa-flip-bot"
        , selector ".fa-flip-horizontal.fa-flip-vertical"
        ]
        [ property "-ms-filter" "\"progid:DXImageTransform.Microsoft.BasicImage(rotation=2, mirror=1)\""
        , property "-webkit-transform" "scale(-1, -1)"
        , property "transform" "scale(-1, -1)"
        ]
    , each
        [ selector ":root .fa-rotate-90"
        , selector ":root .fa-rotate-180"
        , selector ":root .fa-rotate-270"
        , selector ":root .fa-flip-horizontal"
        , selector ":root .fa-flip-vertical"
        , selector ":root .fa-flip-both"
        ]
        [ property "-webkit-filter" "none"
        , property "filter" "none"
        ]
    , selector ".fa-stack"
        [ display inlineBlock
        , height (em 2)
        , position relative
        , width (em 2.5)
        ]
    , each
        [ selector ".fa-stack-1"
        , selector ".fa-stack-2x"
        ]
        [ bottom zero
        , left zero
        , margin auto
        , position absolute
        , right zero
        , top zero
        ]
    , selector ".svg-inline--fa.fa-stack-1x"
        [ height (em 1)
        , width (em 1.25)
        ]
    , selector ".svg-inline--fa.fa-stack-2x"
        [ height (em 2)
        , width (em 2.5)
        ]
    , selector ".fa-inverse"
        [ color (hex "#fff") ]
    , selector ".sr-only"
        [ border zero
        , property "clip" "rect(0, 0, 0, 0)"
        , height (px 1)
        , margin (px -1)
        , overflow hidden
        , padding zero
        , position absolute
        , width (px 1)
        ]
    , each
        [ selector ".sr-only-focusable:activ"
        , selector ".sr-only-focusable:focus"
        ]
        [ property "clip" "auto"
        , height auto
        , margin zero
        , overflow visible
        , position static
        , width auto
        ]
    , selector ".svg-inline--fa .fa-primary"
        [ property "fill" "var(--fa-primary-color, currentColor)"
        , opacity (int 1)
        , property "opacity" "var(--fa-primary-opacity, 1)"
        ]
    , selector ".svg-inline--fa .fa-secondary"
        [ property "fill" "var(--fa-secondary-color, currentColor)"
        , opacity (num 0.4)
        , property "opacity" "var(--fa-secondary-opacity, 0.4)"
        ]
    , selector ".svg-inline--fa.fa-swap-opacity .fa-primary"
        [ opacity (num 0.4)
        , property "opacity" "var(--fa-secondary-opacity, 0.4)"
        ]
    , selector ".svg-inline--fa.fa-swap-opacity .fa-secondary"
        [ opacity (int 1)
        , property "opacity" "var(--fa-primary-opacity, 1)"
        ]
    , each
        [ selector ".svg-inline--fa mask .fa-primar"
        , selector ".svg-inline--fa mask .fa-secondary"
        ]
        [ property "fill" "black" ]
    , selector ".fad.fa-inverse"
        [ color (hex "#fff") ]
    ]
