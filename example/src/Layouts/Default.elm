module Layouts.Default exposing (Model, Msg, Settings, layout)

import Css exposing (..)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Palette as Palette exposing (darkPalette, palette, paletteWith, setBackground, setColor)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Data.PageSummary as PageSummary exposing (categoryToString)
import Data.Theme exposing (Theme(..))
import Effect exposing (Effect)
import Html.Styled as Html exposing (Html, a, footer, header, li, main_, text, ul)
import Html.Styled.Attributes exposing (css, href)
import Layout exposing (Layout)
import Route exposing (Route)
import Route.Path as Path
import Shared
import UI.Breadcrumb exposing (BreadcrumbItem, Divider(..), breadcrumbWithProps)
import UI.Container exposing (container)
import UI.Header as Header
import UI.Segment exposing (basicSegment)
import Url exposing (Url)
import View exposing (View)


type alias Settings =
    ()


layout : Settings -> Shared.Model -> Route () -> Layout Model Msg mainMsg
layout settings shared route =
    Layout.new
        { init = init
        , update = update
        , view = view settings route shared
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    {}


init : () -> ( Model, Effect Msg )
init _ =
    ( {}, Effect.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view :
    Settings
    -> Route ()
    -> Shared.Model
    ->
        { fromMsg : Msg -> mainMsg
        , content : View mainMsg
        , model : Model
        }
    -> View mainMsg
view settings route shared { fromMsg, model, content } =
    { title =
        case route.url.path of
            "/" ->
                "Defiant"

            _ ->
                content.title ++ " | Defiant"
    , body =
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
        , siteHeader shared { title = content.title, url = route.url }
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
                    content.body
                ]
            ]
        , siteFooter shared
        ]
    }


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
