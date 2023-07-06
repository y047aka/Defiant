module Pages.DataDisplay.SortableData exposing (Model, Msg, init, update, view)

import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, div, input, strong, text)
import Html.Styled.Attributes exposing (placeholder, value)
import Html.Styled.Events exposing (onInput)
import Playground exposing (playground)
import Shared
import UI.Segment exposing (segment)
import UI.SortableData as SortableData exposing (intColumn, stringColumn)
import UI.SortableData.View exposing (list, table)



-- INIT


type alias Model =
    { mode : Mode
    , presidents : List Person
    , tableState : SortableData.Model Person (Html Msg)
    }


init : Model
init =
    { mode = Table
    , presidents = presidents
    , tableState = SortableData.init .name columns
    }


columns : List (SortableData.Column Person (Html Msg))
columns =
    [ stringColumn { label = "Name", getter = .name, renderer = text }
    , intColumn { label = "Year", getter = .year, renderer = text }
    , stringColumn { label = "City", getter = .city, renderer = text }
    , stringColumn { label = "State", getter = .state, renderer = text }
    ]



-- UPDATE


type Msg
    = TableMsg SortableData.Msg
    | UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        TableMsg tableMsg ->
            { model | tableState = SortableData.update tableMsg model.tableState }

        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } m =
    let
        toListItem =
            \{ name, year, city, state } ->
                [ segment { theme = Light } [] <|
                    [ div [] [ strong [] [ text "Name : " ], text name ]
                    , div [] [ strong [] [ text "Year : " ], text (String.fromInt year) ]
                    , div [] [ strong [] [ text "City : " ], text city ]
                    , div [] [ strong [] [ text "State : " ], text state ]
                    ]
                ]
    in
    [ playground
        { title = "List"
        , theme = theme
        , inverted = False
        , preview =
            [ input [ value m.tableState.filter.query, placeholder "Search by Name", onInput (SortableData.Filter "Name" >> TableMsg) ] []
            , case m.mode of
                List ->
                    list toListItem (SortableData.render m.tableState m.presidents)

                Table ->
                    table m.tableState TableMsg (SortableData.render m.tableState m.presidents)
            ]
        , configSections =
            [ { label = "Types"
              , configs =
                    [ Playground.select
                        { label = ""
                        , value = m.mode
                        , options = [ List, Table ]
                        , fromString = modeFromString
                        , toString = modeToString
                        , onChange = (\mode c -> { c | mode = mode }) >> UpdateConfig
                        , note = ""
                        }
                    ]
              }
            ]
        }
    ]


type alias Person =
    { name : String
    , year : Int
    , city : String
    , state : String
    }


presidents : List Person
presidents =
    [ Person "George Washington" 1732 "Westmoreland County" "Virginia"
    , Person "John Adams" 1735 "Braintree" "Massachusetts"
    , Person "Thomas Jefferson" 1743 "Shadwell" "Virginia"
    , Person "James Madison" 1751 "Port Conway" "Virginia"
    , Person "James Monroe" 1758 "Monroe Hall" "Virginia"
    , Person "Andrew Jackson" 1767 "Waxhaws Region" "South/North Carolina"
    , Person "John Quincy Adams" 1767 "Braintree" "Massachusetts"
    , Person "William Henry Harrison" 1773 "Charles City County" "Virginia"
    , Person "Martin Van Buren" 1782 "Kinderhook" "New York"
    , Person "Zachary Taylor" 1784 "Barboursville" "Virginia"
    , Person "John Tyler" 1790 "Charles City County" "Virginia"
    , Person "James Buchanan" 1791 "Cove Gap" "Pennsylvania"
    , Person "James K. Polk" 1795 "Pineville" "North Carolina"
    , Person "Millard Fillmore" 1800 "Summerhill" "New York"
    , Person "Franklin Pierce" 1804 "Hillsborough" "New Hampshire"
    , Person "Andrew Johnson" 1808 "Raleigh" "North Carolina"
    , Person "Abraham Lincoln" 1809 "Sinking spring" "Kentucky"
    , Person "Ulysses S. Grant" 1822 "Point Pleasant" "Ohio"
    , Person "Rutherford B. Hayes" 1822 "Delaware" "Ohio"
    , Person "Chester A. Arthur" 1829 "Fairfield" "Vermont"
    , Person "James A. Garfield" 1831 "Moreland Hills" "Ohio"
    , Person "Benjamin Harrison" 1833 "North Bend" "Ohio"
    , Person "Grover Cleveland" 1837 "Caldwell" "New Jersey"
    , Person "William McKinley" 1843 "Niles" "Ohio"
    , Person "Woodrow Wilson" 1856 "Staunton" "Virginia"
    , Person "William Howard Taft" 1857 "Cincinnati" "Ohio"
    , Person "Theodore Roosevelt" 1858 "New York City" "New York"
    , Person "Warren G. Harding" 1865 "Blooming Grove" "Ohio"
    , Person "Calvin Coolidge" 1872 "Plymouth" "Vermont"
    , Person "Herbert Hoover" 1874 "West Branch" "Iowa"
    , Person "Franklin D. Roosevelt" 1882 "Hyde Park" "New York"
    , Person "Harry S. Truman" 1884 "Lamar" "Missouri"
    , Person "Dwight D. Eisenhower" 1890 "Denison" "Texas"
    , Person "Lyndon B. Johnson" 1908 "Stonewall" "Texas"
    , Person "Ronald Reagan" 1911 "Tampico" "Illinois"
    , Person "Richard M. Nixon" 1913 "Yorba Linda" "California"
    , Person "Gerald R. Ford" 1913 "Omaha" "Nebraska"
    , Person "John F. Kennedy" 1917 "Brookline" "Massachusetts"
    , Person "George H. W. Bush" 1924 "Milton" "Massachusetts"
    , Person "Jimmy Carter" 1924 "Plains" "Georgia"
    , Person "George W. Bush" 1946 "New Haven" "Connecticut"
    , Person "Bill Clinton" 1946 "Hope" "Arkansas"
    , Person "Barack Obama" 1961 "Honolulu" "Hawaii"
    , Person "Donald Trump" 1946 "New York City" "New York"
    ]



-- HELPER


type Mode
    = List
    | Table


modeFromString : String -> Maybe Mode
modeFromString string =
    case string of
        "List" ->
            Just List

        "Table" ->
            Just Table

        _ ->
            Nothing


modeToString : Mode -> String
modeToString mode =
    case mode of
        List ->
            "List"

        Table ->
            "Table"
