module Pages.Collections.Grid exposing (page)

import Css exposing (..)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes exposing (css, src)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Grid as Grid exposing (eightWideColumn, fourWideColumn, grid, sixWideColumn, threeColumnsGrid, twoWideColumn)
import UI.Image exposing (smallImage)
import UI.Segment exposing (segment)
import View.ConfigAndPreview exposing (configAndPreview)


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
    [ configAndPreview { title = "Grids" }
        [ grid [ css additionalStyles ]
            [ fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            ]
        ]
        []
    , configAndPreview { title = "Columns" }
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
        []
    , configAndPreview { title = "Automatic Flow" }
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
        []
    , configAndPreview { title = "Column Content" }
        [ let
            imageSegment =
                segment { theme = shared.theme }
                    []
                    [ smallImage [ src "/static/images/wireframe/image.png" ] [] ]
          in
          threeColumnsGrid []
            [ Grid.column [] [ imageSegment ]
            , Grid.column [] [ imageSegment ]
            , Grid.column [] [ imageSegment ]
            ]
        ]
        []
    ]
