module UI.Container exposing (container, textContainer)

import Css exposing (..)
import Css.Global exposing (children)
import Css.Media as Media exposing (only, screen, withMedia)
import Css.Typography exposing (fomanticFontFamilies)
import Html.Styled as Html exposing (Attribute, Html)


basis : List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
basis additionalStyles =
    Html.styled Html.div
        [ -- .ui.container
          display block
        , maxWidth (pct 100)

        -- Mobile
        , withMedia [ only screen [ Media.maxWidth (px 767.98) ] ]
            [ -- .ui.ui.ui.container:not(.fluid)
              width auto
            , marginLeft (em 1)
            , marginRight (em 1)
            ]

        -- Tablet
        , withMedia [ only screen [ Media.minWidth (px 768), Media.maxWidth (px 991.98) ] ]
            [ -- .ui.ui.ui.container:not(.fluid)
              width (px 723)
            , marginLeft auto
            , marginRight auto
            ]

        -- Small Monitor
        , withMedia [ only screen [ Media.minWidth (px 992), Media.maxWidth (px 1199.98) ] ]
            [ -- .ui.ui.ui.container:not(.fluid)
              width (px 933)
            , marginLeft auto
            , marginRight auto
            ]

        -- Large Monitor
        , withMedia [ only screen [ Media.minWidth (px 1200) ] ]
            [ -- .ui.ui.ui.container:not(.fluid)
              width (px 1127)
            , marginLeft auto
            , marginRight auto
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


container : List (Attribute msg) -> List (Html msg) -> Html msg
container =
    basis []


textContainer : List (Attribute msg) -> List (Html msg) -> Html msg
textContainer =
    basis
        [ -- .ui.text.container
          fontFamilies fomanticFontFamilies
        , maxWidth (px 700)
        , lineHeight (num 1.5)
        , fontSize (rem 1.14285714)

        -- orverride
        , children
            [ Css.Global.p
                [ fontSize (rem 1.14285714) ]
            ]
        ]
