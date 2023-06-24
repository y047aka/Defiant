module Pages.DataDisplay.Table exposing (Model, Msg, page)

import Effect
import Html.Styled exposing (Html, text)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Table exposing (basicTable, tableWithProps, tbody, td, th, thead, tr, veryBasicTable)


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
            \model ->
                { title = "Table"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



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
    [ playground
        { title = "Table"
        , theme = theme
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
        , configSections =
            [ { label = "Variations"
              , configs =
                    [ Playground.bool
                        { label = "Striped"
                        , id = "striped"
                        , bool = model.striped
                        , onClick = (\c -> { c | striped = not c.striped }) |> UpdateConfig
                        , note = "A table can stripe alternate rows of content with a darker color to increase contrast"
                        }
                    , Playground.bool
                        { label = "Celled"
                        , id = "celled"
                        , bool = model.celled
                        , onClick = (\c -> { c | celled = not c.celled }) |> UpdateConfig
                        , note = "A table may be divided each row into separate cells"
                        }
                    ]
              }
            ]
        }
    , playground
        { title = "Basic"
        , theme = theme
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
        , configSections = []
        }
    , playground
        { title = ""
        , theme = theme
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
        , configSections = []
        }
    ]
