module UI.Message exposing (message)

import Css exposing (..)
import Css.Global exposing (children, descendants, selector)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)
import UI.Internal exposing (chassis)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    chassis { tag = Html.section, border = True, borderColor = rgba 34 36 38 0.22 } <|
        [ -- .ui.message
          position relative
        , minHeight (em 1)
        , margin2 (em 1) zero
        , property "background" "#F8F8F9"
        , padding2 (em 1) (em 1.5)
        , lineHeight (em 1.4285)
        , color (rgba 0 0 0 0.87)
        , property "-webkit-transition" "opacity 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, color 0.1s ease, background 0.1s ease, box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, color 0.1s ease, background 0.1s ease, box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"
        , borderRadius (rem 0.28571429)
        , Prefix.boxShadow "0 0 0 0 rgba(0, 0, 0, 0)"

        -- .ui.message:first-child
        , firstChild
            [ marginTop zero ]

        -- .ui.message:last-child
        , lastChild
            [ marginBottom zero ]

        --
        , descendants
            [ -- .ui.message .header:not(.ui)
              Css.Global.header
                [ fontSize (em 1.14285714) ]

            -- .ui.message p
            , Css.Global.p
                [ opacity (num 0.85)
                , margin2 (em 0.75) zero

                -- .ui.message p:first-child
                , firstChild
                    [ marginTop zero ]

                -- .ui.message p:last-child
                , lastChild
                    [ marginBottom zero ]
                ]

            -- .ui.message .header + p
            , selector "header + p"
                [ marginTop (em 0.25) ]
            ]

        -- .ui.icon.message {
        , Prefix.displayFlex
        , width (pct 100)
        , Prefix.alignItems "center"

        -- .ui.message > i.icon
        , children
            [ Css.Global.i
                [ marginRight (em 0.6)

                -- .ui.icon.message > i.icon:not(.close)
                , display block
                , Prefix.flex "0 0 auto"
                , width auto
                , lineHeight (int 1)
                , verticalAlign middle
                , fontSize (em 3)
                , opacity (num 0.8)
                ]
            , Css.Global.div
                [ -- .ui.icon.message > .content
                  display block
                , Prefix.flex "1 1 auto"
                , verticalAlign middle
                ]
            ]
        ]
            ++ additionalStyles


message : List (Attribute msg) -> List (Html msg) -> Html msg
message =
    basis []
