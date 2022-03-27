module Pages.Defiant.Items exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, input)
import Html.Styled.Attributes exposing (placeholder, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Example exposing (example)
import UI.Items exposing (State, initialSort, intColumn, itemsToList, itemsToTable, stringColumn)


page : Shared.Model -> Request -> Page.With Model Msg
page _ _ =
    Page.element
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Items"
                , body = view model
                }
        , subscriptions = \_ -> Sub.none
        }



-- INIT


type alias Model =
    { people : List Person
    , tableState : State
    , query : String
    }


init : ( Model, Cmd Msg )
init =
    ( { people = presidents
      , tableState = initialSort "Year"
      , query = ""
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = SetQuery String
    | SetTableState State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetQuery newQuery ->
            ( { model | query = newQuery }, Cmd.none )

        SetTableState newState ->
            ( { model | tableState = newState }, Cmd.none )



-- VIEW


view : Model -> List (Html Msg)
view { people, tableState, query } =
    let
        config =
            { toId = .name
            , toMsg = SetTableState
            , columns =
                [ stringColumn { label = "Name", getter = .name }
                , intColumn { label = "Year", getter = .year }
                , stringColumn { label = "City", getter = .city }
                , stringColumn { label = "State", getter = .state }
                ]
            }

        lowerQuery =
            String.toLower query

        acceptablePeople =
            List.filter (String.contains lowerQuery << String.toLower << .name) people
    in
    [ example
        { title = "List"
        , description = ""
        }
        [ input [ value query, placeholder "Search by Name", onInput SetQuery ] []
        , itemsToList config tableState acceptablePeople
        ]
    , example
        { title = "Table"
        , description = ""
        }
        [ input [ value query, placeholder "Search by Name", onInput SetQuery ] []
        , itemsToTable config tableState acceptablePeople
        ]
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
