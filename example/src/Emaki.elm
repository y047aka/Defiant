module Emaki exposing (Model, Msg, runChapter)

import Emaki.Chapter as Chapter exposing (Chapter)
import Html.Styled as Html
import Page exposing (Page)


type Model props
    = ChapterModel (Chapter.Model props)


type Msg
    = ChapterMsg Chapter.Msg


runChapter : String -> Chapter props -> Page (Model props) Msg
runChapter title { init, view, update } =
    Page.sandbox
        { init = ChapterModel init
        , update = \(ChapterMsg subMsg) (ChapterModel subModel) -> ChapterModel (update subMsg subModel)
        , view =
            \(ChapterModel chapterModel) ->
                { title = title
                , body =
                    [ view chapterModel
                        |> Html.map ChapterMsg
                        |> Html.toUnstyled
                    ]
                }
        }
