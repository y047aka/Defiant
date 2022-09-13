module Pages.DataDisplay.Table exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, text)
import Page
import Request exposing (Request)
import Shared
import UI.Table exposing (basicTable, tableWithProps, tbody, td, th, thead, tr, veryBasicTable)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Table"
                , body = view shared model
                }
        }



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
    = UpdateConfig (Config.Msg Model Msg)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ configAndPreview UpdateConfig { theme = theme } <|
        { title = "Table"
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
                    [ { label = ""
                      , config =
                            Config.bool
                                { id = "striped"
                                , label = "Striped"
                                , bool = model.striped
                                , setter = \m -> { m | striped = not m.striped }
                                }
                      , note = "A table can stripe alternate rows of content with a darker color to increase contrast"
                      }
                    , { label = ""
                      , config =
                            Config.bool
                                { id = "celled"
                                , label = "Celled"
                                , bool = model.celled
                                , setter = \m -> { m | celled = not m.celled }
                                }
                      , note = "A table may be divided each row into separate cells"
                      }
                    ]
              }
            ]
        }
    , configAndPreview UpdateConfig { theme = theme } <|
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
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme } <|
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
        , configSections = []
        }
    ]
