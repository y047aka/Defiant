module Page.DataDisplay.Table exposing (Model, Msg, init, update, view)

import Control
import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import UI.Header as Header
import UI.Table exposing (basicTable, tableWithProps, tbody, td, th, thead, tr, veryBasicTable)



-- INIT


type alias Model =
    { striped : Bool
    , celled : Bool
    }


init : Model
init =
    { striped = False
    , celled = True
    }



-- UPDATE


type Msg
    = UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ Header.header { theme = theme } [] [ text "Table" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ tableWithProps { border = True, striped = model.striped, celled = model.celled, thead = True }
                []
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
        , controlSections =
            [ { heading = "Variations"
              , controls =
                    [ Control.field "Striped"
                        (Control.bool
                            { id = "striped"
                            , value = model.striped
                            , onClick = (\ps -> { ps | striped = not ps.striped }) |> UpdateConfig
                            }
                        )
                    , Control.comment "A table can stripe alternate rows of content with a darker color to increase contrast"
                    , Control.field "Celled"
                        (Control.bool
                            { id = "celled"
                            , value = model.celled
                            , onClick = (\ps -> { ps | celled = not ps.celled }) |> UpdateConfig
                            }
                        )
                    , Control.comment "A table may be divided each row into separate cells"
                    ]
              }
            ]
        }
    , Header.header { theme = theme } [] [ text "Basic" ]
    , playground
        { theme = theme
        , inverted = False
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
        , controlSections = []
        }
    , playground
        { theme = theme
        , inverted = False
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
        , controlSections = []
        }
    ]
