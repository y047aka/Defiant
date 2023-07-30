module Layouts.Default exposing (view)

import Browser exposing (Document)
import Css exposing (..)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Palette as Palette exposing (darkPalette, palette, paletteWith, setBackground, setColor)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Data.PageSummary as PageSummary exposing (categoryToString)
import Data.Theme as Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, a, div, footer, header, li, main_, option, select, text, ul)
import Html.Styled.Attributes exposing (css, href, selected, value)
import Html.Styled.Events exposing (onInput)
import Shared
import UI.Breadcrumb exposing (BreadcrumbItem, Divider(..), breadcrumbWithProps)
import UI.Header as Header
import UI.Layout.Box as Box exposing (box)
import UI.Layout.Center as Center
import UI.Layout.Stack as Stack exposing (stack)
import UI.Segment exposing (basicSegment)
import Url exposing (Url)
import Url.Builder


view :
    { a | url : Url, shared : Shared.Model }
    -> (Shared.Msg -> contentMsg)
    -> { title : String, body : List (Html contentMsg) }
    -> Document contentMsg
view { url, shared } toContentMsg page =
    { title =
        case url.path of
            "/" ->
                "Defiant"

            _ ->
                page.title ++ " | Defiant"
    , body =
        List.map Html.toUnstyled <|
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
            , Html.map toContentMsg <|
                siteHeader shared Shared.ChangeTheme { title = page.title, url = url }
            , main_ []
                [ box (Box.defaultProps |> Box.setBorderWidth 0)
                    []
                    [ Center.center (Center.defaultProps |> Center.setMax 150)
                        []
                        [ stack (Stack.defaultProps |> Stack.setGap 1)
                            []
                            page.body
                        ]
                    ]
                ]
            , siteFooter shared
            ]
    }


siteHeader : Shared.Model -> (Theme -> msg) -> { title : String, url : Url } -> Html msg
siteHeader shared toMsg page =
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
        , div []
            [ select [ onInput (Theme.fromString >> Maybe.withDefault shared.theme >> (\theme -> toMsg theme)) ] <|
                List.map (\theme -> option [ value (Theme.toString theme), selected (shared.theme == theme) ] [ text (Theme.toString theme) ])
                    [ System, Light, Dark ]
            ]
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
                        List.map (\{ title, route } -> li [] [ a [ href (Url.Builder.absolute route []) ] [ text title ] ])
                            pages
                    ]
            )
            PageSummary.summariesByCagetgory
        )
