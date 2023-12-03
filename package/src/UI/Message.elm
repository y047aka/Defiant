module UI.Message exposing (message)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, descendants, selector)
import Css.Palette exposing (paletteWithBorder)
import Css.Typography as Typography exposing (setFontSize, setLineHeight, typography)
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.section
        [ position relative
        , margin2 (em 1) zero
        , padding2 (em 1) (em 1.5)
        , paletteWithBorder (border3 (px 1) solid)
            { background = Just (hex "#F8F8F9")
            , color = Just (rgba 0 0 0 0.87)
            , border = Just (rgba 34 36 38 0.22)
            }
        , borderRadius (rem 0.28571429)

        -- .ui.message
        , minHeight (em 1)
        , lineHeight (em 1.4285)
        , property "-webkit-transition" "opacity 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, color 0.1s ease, background 0.1s ease, -webkit-box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, color 0.1s ease, background 0.1s ease, box-shadow 0.1s ease"
        , property "transition" "opacity 0.1s ease, color 0.1s ease, background 0.1s ease, box-shadow 0.1s ease, -webkit-box-shadow 0.1s ease"

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
        , prefixed [] "display" "flex"
        , width (pct 100)
        , prefixed [] "align-items" "center"

        -- .ui.message > i.icon
        , children
            [ Css.Global.i
                [ marginRight (em 0.6)

                -- .ui.icon.message > i.icon:not(.close)
                , display block
                , prefixed [] "flex" "0 0 auto"
                , width auto
                , verticalAlign middle
                , typography
                    (Typography.init
                        |> setFontSize (em 3)
                        |> setLineHeight (num 1)
                    )
                , opacity (num 0.8)
                ]
            , Css.Global.div
                [ -- .ui.icon.message > .content
                  display block
                , prefixed [] "flex" "1 1 auto"
                , verticalAlign middle
                ]
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


message : List (Attribute msg) -> List (Html msg) -> Html msg
message =
    basis []
