module Page.Layout.Grid exposing (Model, Msg, init, update, view)

import Css exposing (..)
import Html.Styled exposing (Html, text)
import Html.Styled.Attributes exposing (css, src)
import Playground exposing (playground)
import Shared
import UI.Grid as Grid exposing (eightWideColumn, fourWideColumn, grid, sixWideColumn, threeColumnsGrid, twoWideColumn)
import UI.Header as Header
import UI.Image exposing (smallImage)
import UI.Segment exposing (segment)



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type alias Msg =
    ()


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
    [ Header.header { theme = theme } [] [ text "Grids" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ grid [ css additionalStyles ]
                [ fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                ]
            ]
        , controlSections = []
        }
    , Header.header { theme = theme } [] [ text "Columns" ]
    , playground
        { theme = theme
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
        , controlSections = []
        }
    , Header.header { theme = theme } [] [ text "Automatic Flow" ]
    , playground
        { theme = theme
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
        , controlSections = []
        }
    , Header.header { theme = theme } [] [ text "Column Content" ]
    , playground
        { theme = theme
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
        , controlSections = []
        }
    ]
