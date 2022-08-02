module Pages.Home_ exposing (page)

import Data.Category as Category exposing (Category(..))
import Data.Theme exposing (Theme)
import Gen.Route as Route exposing (Route)
import Html.Styled as Html exposing (Html, a, text)
import Html.Styled.Attributes exposing (href)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Card as Card exposing (card, cards)
import UI.Header as Header
import UI.Segment exposing (basicSegment)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Homepage"
            , body = view { theme = shared.theme }
            }
        }


view : { theme : Theme } -> List (Html msg)
view options =
    let
        item { title, description, route } =
            card options
                []
                [ a [ href (Route.toHref route) ]
                    [ Card.content options
                        []
                        { header = [ text title ]
                        , meta = []
                        , description = [ text description ]
                        }
                    ]
                ]
    in
    List.map
        (\( category, pages ) ->
            basicSegment options
                []
                [ Header.header options [] [ text (Category.toString category) ]
                , cards [] (List.map item pages)
                ]
        )
        pagesByCagetgory


pagesByCagetgory : List ( Category, List PageSummary )
pagesByCagetgory =
    List.map
        (\category ->
            ( category, List.filter (.category >> (==) category) allPages )
        )
        [ Globals, Elements, Collections, Views, Modules, Defiant ]


type alias PageSummary =
    { title : String
    , description : String
    , category : Category
    , route : Route
    }


allPages : List PageSummary
allPages =
    [ -- Globals
      sitePage

    -- Elements
    , buttonPage
    , containerPage
    , dividerPage
    , headerPage
    , iconPage
    , imagePage
    , inputPage
    , labelPage
    , loaderPage
    , placeholderPage
    , railPage
    , segmentPage
    , stepPage
    , circleStepPage
    , textPage

    -- Collections
    , breadcrumbPage
    , formPage
    , gridPage
    , menuPage
    , messagePage
    , tablePage

    -- Views
    , cardPage
    , itemPage

    -- Modules
    , accordionPage
    , checkboxPage
    , dimmerPage
    , modalPage
    , progressPage
    , tabPage

    -- Defiant
    , sortableDataPage
    , holyGrailPage
    ]


sitePage : PageSummary
sitePage =
    { title = "Site"
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Globals
    , route = Route.Globals__Site
    }


buttonPage : PageSummary
buttonPage =
    { title = "Button"
    , description = "A button indicates a possible user action"
    , category = Elements
    , route = Route.Elements__Button
    }


containerPage : PageSummary
containerPage =
    { title = "Container"
    , description = "A container limits content to a maximum width"
    , category = Elements
    , route = Route.Elements__Container
    }


dividerPage : PageSummary
dividerPage =
    { title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Elements
    , route = Route.Elements__Divider
    }


headerPage : PageSummary
headerPage =
    { title = "Header"
    , description = "A header provides a short summary of content"
    , category = Elements
    , route = Route.Elements__Header
    }


iconPage : PageSummary
iconPage =
    { title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Elements
    , route = Route.Elements__Icon
    }


imagePage : PageSummary
imagePage =
    { title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Elements
    , route = Route.Elements__Image
    }


inputPage : PageSummary
inputPage =
    { title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Elements
    , route = Route.Elements__Input
    }


labelPage : PageSummary
labelPage =
    { title = "Label"
    , description = "A label displays content classification"
    , category = Elements
    , route = Route.Elements__Label
    }


loaderPage : PageSummary
loaderPage =
    { title = "Loader"
    , description = "A loader alerts a user to wait for an activity to complete"
    , category = Elements
    , route = Route.Elements__Loader
    }


placeholderPage : PageSummary
placeholderPage =
    { title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Elements
    , route = Route.Elements__Placeholder
    }


railPage : PageSummary
railPage =
    { title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Elements
    , route = Route.Elements__Rail
    }


segmentPage : PageSummary
segmentPage =
    { title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Elements
    , route = Route.Elements__Segment
    }


stepPage : PageSummary
stepPage =
    { title = "Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = Route.Elements__Step
    }


circleStepPage : PageSummary
circleStepPage =
    { title = "Circle Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = Route.Elements__CircleStep
    }


textPage : PageSummary
textPage =
    { title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Elements
    , route = Route.Elements__Text
    }


breadcrumbPage : PageSummary
breadcrumbPage =
    { title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Collections
    , route = Route.Collections__Breadcrumb
    }


formPage : PageSummary
formPage =
    { title = "Form"
    , description = "A form displays a set of related user input fields in a structured way"
    , category = Collections
    , route = Route.Collections__Form
    }


gridPage : PageSummary
gridPage =
    { title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Collections
    , route = Route.Collections__Grid
    }


menuPage : PageSummary
menuPage =
    { title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Collections
    , route = Route.Collections__Menu
    }


messagePage : PageSummary
messagePage =
    { title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Collections
    , route = Route.Collections__Message
    }


tablePage : PageSummary
tablePage =
    { title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = Collections
    , route = Route.Collections__Table
    }


cardPage : PageSummary
cardPage =
    { title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = Views
    , route = Route.Views__Card
    }


itemPage : PageSummary
itemPage =
    { title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = Views
    , route = Route.Views__Item
    }


accordionPage : PageSummary
accordionPage =
    { title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Modules
    , route = Route.Modules__Accordion
    }


checkboxPage : PageSummary
checkboxPage =
    { title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Modules
    , route = Route.Modules__Checkbox
    }


dimmerPage : PageSummary
dimmerPage =
    { title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Modules
    , route = Route.Modules__Dimmer
    }


modalPage : PageSummary
modalPage =
    { title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Modules
    , route = Route.Modules__Modal
    }


progressPage : PageSummary
progressPage =
    { title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Modules
    , route = Route.Modules__Progress
    }


tabPage : PageSummary
tabPage =
    { title = "Tab"
    , description = "A tab is a hidden section of content activated by a menu"
    , category = Modules
    , route = Route.Modules__Tab
    }


sortableDataPage : PageSummary
sortableDataPage =
    { title = "SortableData"
    , description = "Sortable data"
    , category = Defiant
    , route = Route.Defiant__SortableData
    }


holyGrailPage : PageSummary
holyGrailPage =
    { title = "HolyGrail"
    , description = "Holy grail layout."
    , category = Defiant
    , route = Route.Defiant__HolyGrail
    }
