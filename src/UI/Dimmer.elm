module UI.Dimmer exposing (content, dimmer, pageDimmer)

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Prefix as Prefix
import Html.Styled as Html exposing (Attribute, Html)


basis : Bool -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis isActive additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.dimmer
          position absolute
        , top zero |> important
        , left zero |> important
        , width (pct 100)
        , height (pct 100)
        , textAlign center
        , verticalAlign middle
        , padding (em 1)
        , property "background" "rgba(0, 0, 0, 0.85)"
        , if isActive then
            batch
                [ -- .dimmed.dimmable > .ui.animating.dimmer,
                  -- .dimmed.dimmable > .ui.visible.dimmer,
                  -- .ui.active.dimmer
                  property "display" "-webkit-box"
                , property "display" "-ms-flexbox"
                , displayFlex
                , opacity (int 1)
                ]

          else
            batch
                [ display none
                , opacity zero
                ]
        , lineHeight (int 1)
        , prefixed [] "animation-fill-mode" "both"
        , prefixed [] "animation-duration" "0.5s"
        , property "-webkit-transition" "background-color 0.5s linear"
        , property "transition" "background-color 0.5s linear"
        , property "-webkit-box-orient" "vertical"
        , property "-webkit-box-direction" "normal"
        , prefixed [] "flex-direction" "column"
        , Prefix.alignItems "center"
        , property "-webkit-box-pack" "center"
        , property "-ms-flex-pack" "center"
        , justifyContent center
        , prefixed [] "user-select" "none"
        , property "will-change" "opacity"
        , zIndex (int 1000)

        -- .ui.segment > .ui.dimmer:not(.page)
        , borderRadius inherit
        ]
            ++ additionalStyles


dimmer : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
dimmer isActive =
    basis isActive
        []


pageDimmer : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
pageDimmer isActive =
    basis isActive
        [ -- .ui.page.dimmer
          position fixed
        , property "-webkit-transform-style" "''"
        , property "transform-style" "''"
        , property "-webkit-perspective" "2000px"
        , property "perspective" "2000px"
        , property "-webkit-transform-origin" "center center"
        , property "transform-origin" "center center"
        ]


content : List (Attribute msg) -> List (Html msg) -> Html msg
content =
    Html.styled Html.div
        [ -- .ui.dimmer > .content
          property "-webkit-user-select" "text"
        , property "-moz-user-select" "text"
        , property "-ms-user-select" "text"
        , property "user-select" "text"
        , color (hex "#FFFFFF")
        ]
