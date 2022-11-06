module Data.PageSummary exposing
    ( PageSummary, summariesByCagetgory
    , Category, categoryToString
    )

{-|

@docs PageSummary, summariesByCagetgory
@docs Category, categoryToString

-}

import Gen.Route as Route exposing (Route)


type alias PageSummary =
    { title : String
    , description : String
    , category : Category
    , route : Route
    }


summariesByCagetgory : List ( Category, List PageSummary )
summariesByCagetgory =
    List.map
        (\category ->
            ( category, List.filter (.category >> (==) category) all )
        )
        [ Global, Layout, Element, Navigation, Form, DataDisplay ]


all : List PageSummary
all =
    [ -- Globals
      sitePage

    -- Layout
    , containerPage
    , gridPage
    , holyGrailPage
    , modalPage
    , railPage

    -- Elements
    , buttonPage
    , dimmerPage
    , dividerPage
    , headerPage
    , iconPage
    , imagePage
    , labelPage
    , loaderPage
    , messagePage
    , placeholderPage
    , segmentPage
    , textPage

    -- Navigation
    , accordionPage
    , breadcrumbPage
    , menuPage
    , stepPage
    , progressPage
    , tabPage

    -- Form
    , checkboxPage
    , inputPage
    , formPage

    -- DataDisplay
    , cardPage
    , itemPage
    , sortableDataPage
    , tablePage
    ]


sitePage : PageSummary
sitePage =
    { title = "Site"
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Global
    , route = Route.Global__Site
    }


containerPage : PageSummary
containerPage =
    { title = "Container"
    , description = "A container limits content to a maximum width"
    , category = Layout
    , route = Route.Layout__Container
    }


gridPage : PageSummary
gridPage =
    { title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Layout
    , route = Route.Layout__Grid
    }


holyGrailPage : PageSummary
holyGrailPage =
    { title = "HolyGrail"
    , description = "Holy grail layout."
    , category = Layout
    , route = Route.Layout__HolyGrail
    }


modalPage : PageSummary
modalPage =
    { title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Layout
    , route = Route.Layout__Modal
    }


railPage : PageSummary
railPage =
    { title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Layout
    , route = Route.Layout__Rail
    }


buttonPage : PageSummary
buttonPage =
    { title = "Button"
    , description = "A button indicates a possible user action"
    , category = Element
    , route = Route.Element__Button
    }


dimmerPage : PageSummary
dimmerPage =
    { title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Element
    , route = Route.Element__Dimmer
    }


dividerPage : PageSummary
dividerPage =
    { title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Element
    , route = Route.Element__Divider
    }


headerPage : PageSummary
headerPage =
    { title = "Header"
    , description = "A header provides a short summary of content"
    , category = Element
    , route = Route.Element__Header
    }


iconPage : PageSummary
iconPage =
    { title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Element
    , route = Route.Element__Icon
    }


imagePage : PageSummary
imagePage =
    { title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Element
    , route = Route.Element__Image
    }


labelPage : PageSummary
labelPage =
    { title = "Label"
    , description = "A label displays content classification"
    , category = Element
    , route = Route.Element__Label
    }


loaderPage : PageSummary
loaderPage =
    { title = "Loader"
    , description = "A loader alerts a user to wait for an activity to complete"
    , category = Element
    , route = Route.Element__Loader
    }


messagePage : PageSummary
messagePage =
    { title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Element
    , route = Route.Element__Message
    }


placeholderPage : PageSummary
placeholderPage =
    { title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Element
    , route = Route.Element__Placeholder
    }


segmentPage : PageSummary
segmentPage =
    { title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Element
    , route = Route.Element__Segment
    }


textPage : PageSummary
textPage =
    { title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Element
    , route = Route.Element__Text
    }


accordionPage : PageSummary
accordionPage =
    { title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Navigation
    , route = Route.Navigation__Accordion
    }


breadcrumbPage : PageSummary
breadcrumbPage =
    { title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Navigation
    , route = Route.Navigation__Breadcrumb
    }


menuPage : PageSummary
menuPage =
    { title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Navigation
    , route = Route.Navigation__Menu
    }


stepPage : PageSummary
stepPage =
    { title = "Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Navigation
    , route = Route.Navigation__Step
    }


progressPage : PageSummary
progressPage =
    { title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Navigation
    , route = Route.Navigation__Progress
    }


tabPage : PageSummary
tabPage =
    { title = "Tab"
    , description = "A tab is a hidden section of content activated by a menu"
    , category = Navigation
    , route = Route.Navigation__Tab
    }


checkboxPage : PageSummary
checkboxPage =
    { title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Form
    , route = Route.Form__Checkbox
    }


inputPage : PageSummary
inputPage =
    { title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Form
    , route = Route.Form__Input
    }


formPage : PageSummary
formPage =
    { title = "Form"
    , description = "A form displays a set of related user input fields in a structured way"
    , category = Form
    , route = Route.Form__Form
    }


cardPage : PageSummary
cardPage =
    { title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = DataDisplay
    , route = Route.DataDisplay__Card
    }


itemPage : PageSummary
itemPage =
    { title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = DataDisplay
    , route = Route.DataDisplay__Item
    }


sortableDataPage : PageSummary
sortableDataPage =
    { title = "SortableData"
    , description = "Sortable data"
    , category = DataDisplay
    , route = Route.DataDisplay__SortableData
    }


tablePage : PageSummary
tablePage =
    { title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = DataDisplay
    , route = Route.DataDisplay__Table
    }



-- Category


type Category
    = None
    | Global
    | Layout
    | Element
    | Navigation
    | Form
    | DataDisplay


categoryToString : Category -> String
categoryToString category =
    case category of
        None ->
            "None"

        Global ->
            "Global"

        Layout ->
            "Layout"

        Element ->
            "Element"

        Navigation ->
            "Navigation"

        Form ->
            "Form"

        DataDisplay ->
            "Data Display"
