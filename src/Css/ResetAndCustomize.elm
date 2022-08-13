module Css.ResetAndCustomize exposing (additionalReset, globalCustomize)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (Snippet, each, everything, selector)
import Css.Typography_Outdated as Typography exposing (typography)


additionalReset : List Snippet
additionalReset =
    [ -- Border-Box
      each
        [ everything
        , selector "*:before"
        , selector "*:after"
        ]
        [ prefixed [] "box-sizing" "inherit" ]
    , Css.Global.html
        [ prefixed [] "box-sizing" "border-box" ]

    -- iPad Input Shadows
    , each
        [ selector "input[type=\"text\"]"
        , selector "input[type=\"email\"]"
        , selector "input[type=\"search\"]"
        , selector "input[type=\"password\"]"
        ]
        [ prefixed [ "-moz-" ] "appearance" "none" ]
    ]


globalCustomize : List Snippet
globalCustomize =
    [ -- Page
      each
        [ Css.Global.html
        , Css.Global.body
        ]
        [ height (pct 100) ]
    , Css.Global.html
        [ fontSize (px 14) ]
    , Css.Global.body
        [ margin zero
        , padding zero
        , overflowX hidden
        , minWidth (px 320)
        , property "background" "#FFFFFF"
        , color (rgba 0 0 0 0.87)
        , typography Typography.default
        ]

    -- Headers
    , each
        [ Css.Global.h1
        , Css.Global.h2
        , Css.Global.h3
        , Css.Global.h4
        , Css.Global.h5
        ]
        [ margin3 (calc (rem 2) minus (em 0.1428571428571429)) zero (rem 1)
        , padding zero
        , typography Typography.heading
        ]
    , Css.Global.h1
        [ minHeight (rem 1)
        , fontSize (rem 2)
        ]
    , Css.Global.h2
        [ fontSize (rem 1.71428571) ]
    , Css.Global.h3
        [ fontSize (rem 1.28571429) ]
    , Css.Global.h4
        [ fontSize (rem 1.07142857) ]
    , Css.Global.h5
        [ fontSize (rem 1) ]
    , each
        [ selector "h1:first-child"
        , selector "h2:first-child"
        , selector "h3:first-child"
        , selector "h4:first-child"
        , selector "h5:first-child"
        ]
        [ marginTop zero ]
    , each
        [ selector "h1:last-child"
        , selector "h2:last-child"
        , selector "h3:last-child"
        , selector "h4:last-child"
        , selector "h5:last-child"
        ]
        [ marginBottom zero ]

    -- Text
    , Css.Global.p
        [ margin3 zero zero (em 1)
        , typography Typography.default
        , firstChild
            [ marginTop zero ]
        , lastChild
            [ marginBottom zero ]
        ]

    -- Links
    , Css.Global.a
        [ color (hex "#4183C4")
        , textDecoration none
        , hover
            [ color (hex "#1e70bf")
            , textDecoration none
            ]
        ]

    -- Highlighting
    , -- Site
      selector "::-webkit-selection"
        [ backgroundColor (hex "#CCE2FF")
        , color (rgba 0 0 0 0.87)
        ]
    , selector "::-moz-selection"
        [ backgroundColor (hex "#CCE2FF")
        , color (rgba 0 0 0 0.87)
        ]
    , selector "::selection"
        [ backgroundColor (hex "#CCE2FF")
        , color (rgba 0 0 0 0.87)
        ]
    , -- Form
      each
        [ selector "textarea::-webkit-selection"
        , selector "input::-webkit-selection"
        ]
        [ backgroundColor (rgba 100 100 100 0.4)
        , color (rgba 0 0 0 0.87)
        ]
    , each
        [ selector "textarea::-moz-selection"
        , selector "input::-moz-selection"
        ]
        [ backgroundColor (rgba 100 100 100 0.4)
        , color (rgba 0 0 0 0.87)
        ]
    , each
        [ selector "textarea::selection"
        , selector "input::selection"
        ]
        [ backgroundColor (rgba 100 100 100 0.4)
        , color (rgba 0 0 0 0.87)
        ]
    , -- Force Simple Scrollbars
      selector "body ::-webkit-scrollbar"
        [ prefixed [] "appearance" "none"
        , width (px 10)
        , height (px 10)
        ]
    , selector "body ::-webkit-scrollbar-track"
        [ property "background" "rgba(0, 0, 0, 0.1)"
        , borderRadius zero
        ]
    , selector "body ::-webkit-scrollbar-thumb"
        [ cursor pointer
        , borderRadius (px 5)
        , property "background" "rgba(0, 0, 0, 0.25)"
        , property "-webkit-transition" "color 0.2s ease"
        , property "transition" "color 0.2s ease"
        ]
    , selector "body ::-webkit-scrollbar-thumb:window-inactive"
        [ property "background" "rgba(0, 0, 0, 0.15)" ]
    , selector "body ::-webkit-scrollbar-thumb:hover"
        [ property "background" "rgba(128, 135, 139, 0.8)" ]

    -- Inverted UI
    , selector "body .ui.inverted:not(.dimmer)::-webkit-scrollbar-track"
        [ property "background" "rgba(255, 255, 255, 0.1)" ]
    , selector "body .ui.inverted:not(.dimmer)::-webkit-scrollbar-thumb"
        [ property "background" "rgba(255, 255, 255, 0.25)" ]
    , selector "body .ui.inverted:not(.dimmer)::-webkit-scrollbar-thumb:window-inactive"
        [ property "background" "rgba(255, 255, 255, 0.15)" ]
    , selector "body .ui.inverted:not(.dimmer)::-webkit-scrollbar-thumb:hover"
        [ property "background" "rgba(255, 255, 255, 0.35)" ]
    ]
