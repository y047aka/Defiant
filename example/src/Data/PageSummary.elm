module Data.PageSummary exposing
    ( PageSummary, all, summariesByCagetgory
    , sitePage
    , gridPage, holyGrailPage, modalPage, railPage, boxPage, centerPage, clusterPage, stackPage
    , buttonPage, dimmerPage, dividerPage, headerPage, iconPage, imagePage, labelPage, loaderPage, messagePage, placeholderPage, segmentPage, textPage
    , accordionPage, breadcrumbPage, menuPage, progressPage, stepPage, tabPage
    , checkboxPage, formPage, inputPage
    , cardPage, itemPage, sortableDataPage, tablePage
    , Category(..), categoryToString
    )

{-|

@docs PageSummary, all, summariesByCagetgory
@docs sitePage
@docs gridPage, holyGrailPage, modalPage, railPage, boxPage, centerPage, clusterPage, stackPage
@docs buttonPage, dimmerPage, dividerPage, headerPage, iconPage, imagePage, labelPage, loaderPage, messagePage, placeholderPage, segmentPage, textPage
@docs accordionPage, breadcrumbPage, menuPage, progressPage, stepPage, tabPage
@docs checkboxPage, formPage, inputPage
@docs cardPage, itemPage, sortableDataPage, tablePage
@docs Category, categoryToString

-}


type alias PageSummary =
    { title : String
    , description : String
    , category : Category
    , route : List String
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
    , gridPage
    , holyGrailPage
    , modalPage
    , railPage
    , boxPage
    , centerPage
    , clusterPage
    , stackPage

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
    , progressPage
    , stepPage
    , tabPage

    -- Form
    , checkboxPage
    , formPage
    , inputPage

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
    , route = [ "global", "site" ]
    }


gridPage : PageSummary
gridPage =
    { title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Layout
    , route = [ "layout", "grid" ]
    }


holyGrailPage : PageSummary
holyGrailPage =
    { title = "Holy Grail"
    , description = "Holy grail layout."
    , category = Layout
    , route = [ "layout", "holy-grail" ]
    }


modalPage : PageSummary
modalPage =
    { title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Layout
    , route = [ "layout", "modal" ]
    }


railPage : PageSummary
railPage =
    { title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Layout
    , route = [ "layout", "rail" ]
    }


boxPage : PageSummary
boxPage =
    { title = "Box"
    , description = "Inspired by \"EVERY LAYOUT\""
    , category = Layout
    , route = [ "layout", "box" ]
    }


centerPage : PageSummary
centerPage =
    { title = "Center"
    , description = "Inspired by \"EVERY LAYOUT\""
    , category = Layout
    , route = [ "layout", "center" ]
    }


clusterPage : PageSummary
clusterPage =
    { title = "Cluster"
    , description = "Inspired by \"EVERY LAYOUT\""
    , category = Layout
    , route = [ "layout", "cluster" ]
    }


stackPage : PageSummary
stackPage =
    { title = "Stack"
    , description = "Inspired by \"EVERY LAYOUT\""
    , category = Layout
    , route = [ "layout", "stack" ]
    }


buttonPage : PageSummary
buttonPage =
    { title = "Button"
    , description = "A button indicates a possible user action"
    , category = Element
    , route = [ "element", "button" ]
    }


dimmerPage : PageSummary
dimmerPage =
    { title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Element
    , route = [ "element", "dimmer" ]
    }


dividerPage : PageSummary
dividerPage =
    { title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Element
    , route = [ "element", "divider" ]
    }


headerPage : PageSummary
headerPage =
    { title = "Header"
    , description = "A header provides a short summary of content"
    , category = Element
    , route = [ "element", "header" ]
    }


iconPage : PageSummary
iconPage =
    { title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Element
    , route = [ "element", "icon" ]
    }


imagePage : PageSummary
imagePage =
    { title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Element
    , route = [ "element", "image" ]
    }


labelPage : PageSummary
labelPage =
    { title = "Label"
    , description = "A label displays content classification"
    , category = Element
    , route = [ "element", "label" ]
    }


loaderPage : PageSummary
loaderPage =
    { title = "Loader"
    , description = "A loader alerts a user to wait for an activity to complete"
    , category = Element
    , route = [ "element", "loader" ]
    }


messagePage : PageSummary
messagePage =
    { title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Element
    , route = [ "element", "message" ]
    }


placeholderPage : PageSummary
placeholderPage =
    { title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Element
    , route = [ "element", "placeholder" ]
    }


segmentPage : PageSummary
segmentPage =
    { title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Element
    , route = [ "element", "segment" ]
    }


textPage : PageSummary
textPage =
    { title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Element
    , route = [ "element", "text" ]
    }


accordionPage : PageSummary
accordionPage =
    { title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Navigation
    , route = [ "navigation", "accordion" ]
    }


breadcrumbPage : PageSummary
breadcrumbPage =
    { title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Navigation
    , route = [ "navigation", "breadcrumb" ]
    }


menuPage : PageSummary
menuPage =
    { title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Navigation
    , route = [ "navigation", "menu" ]
    }


progressPage : PageSummary
progressPage =
    { title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Navigation
    , route = [ "navigation", "progress" ]
    }


stepPage : PageSummary
stepPage =
    { title = "Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Navigation
    , route = [ "navigation", "step" ]
    }


tabPage : PageSummary
tabPage =
    { title = "Tab"
    , description = "A tab is a hidden section of content activated by a menu"
    , category = Navigation
    , route = [ "navigation", "tab" ]
    }


checkboxPage : PageSummary
checkboxPage =
    { title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Form
    , route = [ "form", "checkbox" ]
    }


formPage : PageSummary
formPage =
    { title = "Form"
    , description = "A form displays a set of related user input fields in a structured way"
    , category = Form
    , route = [ "form", "form" ]
    }


inputPage : PageSummary
inputPage =
    { title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Form
    , route = [ "form", "input" ]
    }


cardPage : PageSummary
cardPage =
    { title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = DataDisplay
    , route = [ "data-display", "card" ]
    }


itemPage : PageSummary
itemPage =
    { title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = DataDisplay
    , route = [ "data-display", "item" ]
    }


sortableDataPage : PageSummary
sortableDataPage =
    { title = "Sortable Data"
    , description = "Sortable data"
    , category = DataDisplay
    , route = [ "data-display", "sortable-data" ]
    }


tablePage : PageSummary
tablePage =
    { title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = DataDisplay
    , route = [ "data-display", "table" ]
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
