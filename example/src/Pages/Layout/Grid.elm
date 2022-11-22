module Pages.Layout.Grid exposing (Model, Msg, page)

import Config
import Css exposing (..)
import Effect
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (css, src)
import Layouts.Default exposing (layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Grid as Grid exposing (eightWideColumn, fourWideColumn, grid, sixWideColumn, threeColumnsGrid, twoWideColumn)
import UI.Image exposing (smallImage)
import UI.Segment exposing (segment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Grid"
                , body = view shared
                }
                    |> layout shared route
        }



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    let
        additionalStyles =
            [ position relative
            , before
                [ position absolute
                , top (rem 1)
                , left (rem 1)
                , backgroundColor (hex "FAFAFA")
                , property "content" (qt "")
                , width (calc (pct 100) minus (rem 2))
                , height (calc (pct 100) minus (rem 2))
                , property "box-shadow" "0px 0px 0px 1px #DDDDDD inset"
                ]
            ]

        dummyContent =
            css
                [ after
                    [ property "content" (qt "")
                    , display block
                    , minHeight (px 50)
                    , backgroundColor (rgba 86 61 124 0.1)
                    , property "box-shadow" "0px 0px 0px 1px rgba(86, 61, 124, 0.2) inset"
                    ]
                ]
    in
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Grids"
        , preview =
            [ grid [ css additionalStyles ]
                [ fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Columns"
        , preview =
            [ grid [ css additionalStyles ]
                [ fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , twoWideColumn [ dummyContent ] []
                , eightWideColumn [ dummyContent ] []
                , sixWideColumn [ dummyContent ] []
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Automatic Flow"
        , preview =
            [ grid [ css additionalStyles ]
                [ fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Column Content"
        , preview =
            [ let
                imageSegment =
                    segment { theme = theme }
                        []
                        [ smallImage [ src "/images/wireframe/image.png" ] [] ]
              in
              threeColumnsGrid []
                [ Grid.column [] [ imageSegment ]
                , Grid.column [] [ imageSegment ]
                , Grid.column [] [ imageSegment ]
                ]
            ]
        , configSections = []
        }
    ]
