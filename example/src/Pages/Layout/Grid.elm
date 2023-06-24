module Pages.Layout.Grid exposing (Model, Msg, page)

import Css exposing (..)
import Effect
import Html.Styled exposing (Html)
import Html.Styled.Attributes exposing (css, src)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Grid as Grid exposing (eightWideColumn, fourWideColumn, grid, sixWideColumn, threeColumnsGrid, twoWideColumn)
import UI.Image exposing (smallImage)
import UI.Segment exposing (segment)


layout : Model -> Layout msg
layout model =
    Layouts.Default {}


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
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
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
    [ playground
        { title = "Grids"
        , theme = theme
        , inverted = False
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
    , playground
        { title = "Columns"
        , theme = theme
        , inverted = False
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
    , playground
        { title = "Automatic Flow"
        , theme = theme
        , inverted = False
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
    , playground
        { title = "Column Content"
        , theme = theme
        , inverted = False
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
