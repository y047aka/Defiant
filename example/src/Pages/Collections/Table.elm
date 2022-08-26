module Pages.Collections.Table exposing (page)

import Html.Styled as Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Table exposing (..)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page
page _ _ =
    Page.static
        { view =
            { title = "Table"
            , body = view
            }
        }


view : List (Html msg)
view =
    [ configAndPreview
        { title = "Table"
        , preview =
            [ celledTable []
                [ thead []
                    [ tr [] <|
                        List.map (\item -> th [] [ text item ])
                            [ "Name", "Age", "Job" ]
                    ]
                , tbody [] <|
                    List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                        [ [ "James", "24", "Engineer" ]
                        , [ "Jill", "26", "Engineer" ]
                        , [ "Elyse", "24", "Designer" ]
                        ]
                ]
            ]
        , configs = []
        }
    , configAndPreview
        { title = "Striped"
        , preview =
            [ stripedTable []
                [ thead []
                    [ tr [] <|
                        List.map (\item -> th [] [ text item ])
                            [ "Name", "Date Joined", "E-mail", "Called" ]
                    ]
                , tbody [] <|
                    List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                        [ [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                        , [ "Jamie Harington", "January 11, 2014", "jamieharingonton@yahoo.com", "Yes" ]
                        , [ "Jill Lewis", "May 11, 2014", "jilsewris22@yahoo.com", "Yes" ]
                        , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                        , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                        , [ "Jamie Harington", "January 11, 2014", "jamieharingonton@yahoo.com", "Yes" ]
                        , [ "Jill Lewis", "May 11, 2014", "jilsewris22@yahoo.com", "Yes" ]
                        , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                        ]
                ]
            ]
        , configs = []
        }
    , configAndPreview
        { title = "Basic"
        , preview =
            [ basicTable []
                [ thead []
                    [ tr [] <|
                        List.map (\item -> th [] [ text item ])
                            [ "Name", "Status", "Notes" ]
                    ]
                , tbody [] <|
                    List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                        [ [ "John", "Approved", "None" ]
                        , [ "Jamie", "Approved", "Requires call" ]
                        , [ "Jill", "Denied", "None" ]
                        ]
                ]
            ]
        , configs = []
        }
    , configAndPreview
        { title = ""
        , preview =
            [ veryBasicTable []
                [ thead []
                    [ tr [] <|
                        List.map (\item -> th [] [ text item ])
                            [ "Name", "Status", "Notes" ]
                    ]
                , tbody [] <|
                    List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                        [ [ "John", "Approved", "None" ]
                        , [ "Jamie", "Approved", "Requires call" ]
                        , [ "Jill", "Denied", "None" ]
                        ]
                ]
            ]
        , configs = []
        }
    ]
