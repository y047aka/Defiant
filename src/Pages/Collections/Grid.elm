module Pages.Collections.Grid exposing (page)

import Css exposing (..)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (css, src)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Grid as Grid exposing (eightWideColumn, fourWideColumn, grid, sixWideColumn, threeColumnsGrid, twoWideColumn)
import UI.Image exposing (smallImage)
import UI.Segment exposing (segment)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Grid"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
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
    [ example
        { title = "Grids"
        , description = """A grid is a structure with a long history used to align negative space in designs.
Using a grid makes content appear to flow more naturally on your page."""
        }
        [ grid [ css additionalStyles ]
            [ fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            ]
        ]
    , example
        { title = "Columns"
        , description = """Grids divide horizontal space into indivisible units called "columns". All columns in a grid must specify their width as proportion of the total available row width.
All grid systems choose an arbitrary column count to allow per row. Fomantic's default theme uses 16 columns.
The example below shows four four wide columns will fit in the first row, 16 / 4 = 4, and three various sized columns in the second row. 2 + 8 + 6 = 16
The default column count, and other arbitrary features of grids can be changed by adjusting Fomantic UI's underlying theming variables."""
        }
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
    , example
        { title = "Automatic Flow"
        , description = "Most grids do not need to specify rows. Content will automatically flow to the next row when all the grid columns are taken in the current row."
        }
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
    , example
        { title = "Column Content"
        , description = "Since columns use padding to create gutters, content stylings should not be applied directly to columns, but to elements inside of columns."
        }
        [ let
            imageSegment =
                segment { inverted = shared.darkMode }
                    []
                    [ smallImage [ src "/static/images/wireframe/image.png" ] [] ]
          in
          threeColumnsGrid []
            [ Grid.column [] [ imageSegment ]
            , Grid.column [] [ imageSegment ]
            , Grid.column [] [ imageSegment ]
            ]
        ]
    ]
