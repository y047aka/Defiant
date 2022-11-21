module Layouts.Default exposing (layout)

import Css exposing (..)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Palette as Palette exposing (darkPalette, palette, paletteWith, setBackground, setColor)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Data.PageSummary as PageSummary exposing (categoryToString)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, a, footer, header, li, main_, text, ul)
import Html.Styled.Attributes exposing (css, href)
import Route exposing (Route)
import Route.Path as Path
import Shared
import UI.Breadcrumb exposing (BreadcrumbItem, Divider(..), breadcrumbWithProps)
import UI.Container exposing (container)
import UI.Header as Header
import UI.Segment exposing (basicSegment)
import Url exposing (Url)
import View exposing (View)


layout : Shared.Model -> Route () -> View msg -> View msg
layout shared route page =
    { title =
        case route.url.path of
            "/" ->
                "Defiant"

            _ ->
                page.title ++ " | Defiant"
    , body = skeleton shared route page
    }


skeleton : Shared.Model -> Route () -> View msg -> List (Html msg)
skeleton shared route { title, body } =
    [ global (normalize ++ additionalReset ++ globalCustomize ++ fontAwesome)
    , global
        [ Css.Global.body
            [ property "display" "grid"
            , property "grid-template-rows" "auto 1fr auto"
            , palette Palette.init
            , darkPalette shared.theme
                (Palette.init
                    |> setBackground (hex "#1B1C1D")
                    |> setColor (rgba 255 255 255 0.9)
                )
            ]
        ]
    , siteHeader shared { title = title, url = route.url }
    , main_ []
        [ basicSegment { theme = Light }
            []
            [ container
                [ css
                    [ displayFlex
                    , flexDirection column
                    , property "gap" "50px"
                    ]
                ]
                body
            ]
        ]
    , siteFooter shared
    ]


siteHeader : Shared.Model -> { title : String, url : Url } -> Html msg
siteHeader shared page =
    header
        [ css
            [ position sticky
            , top zero
            , zIndex (int 1)
            , displayFlex
            , justifyContent spaceBetween
            , padding (px 20)
            , paletteWith { border = borderBottom3 (px 1) solid }
                (Palette.init
                    |> setBackground (hex "#FFF")
                    |> Palette.setBorder (hex "#DDD")
                )
            , darkPalette shared.theme
                (Palette.init
                    |> setBackground (hex "#1B1C1D")
                    |> setColor (rgba 255 255 255 0.9)
                )
            ]
        ]
        [ breadcrumbWithProps { divider = Slash, size = Nothing, theme = shared.theme }
            (breadcrumbItems page)
        -- , div []
        --     [ select [ onInput (Theme.fromString >> Maybe.withDefault shared.theme >> (\theme -> Shared (Shared.ChangeTheme theme))) ] <|
        --         List.map (\theme -> option [ value (Theme.toString theme), selected (shared.theme == theme) ] [ text (Theme.toString theme) ])
        --             [ System, Light, Dark ]
        --     ]
        ]


breadcrumbItems : { title : String, url : Url } -> List BreadcrumbItem
breadcrumbItems { title, url } =
    case url.path of
        "/" ->
            [ { label = "Top", url = "/" } ]

        _ ->
            [ { label = "Top", url = "/" }
            , { label = title, url = Url.toString url }
            ]


siteFooter : Shared.Model -> Html msg
siteFooter options =
    footer
        [ css
            [ displayFlex
            , justifyContent spaceBetween
            , padding (px 20)
            , borderTop3 (px 1) solid (hex "#DDD")
            ]
        ]
        (List.map
            (\( category, pages ) ->
                basicSegment options
                    []
                    [ Header.header options [] [ text (categoryToString category) ]
                    , ul [ css [ padding zero, listStyle none ] ] <|
                        List.map (\{ title, path } -> li [] [ a [ href (Path.toString path) ] [ text title ] ])
                            pages
                    ]
            )
            PageSummary.summariesByCagetgory
        )
