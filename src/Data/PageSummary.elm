module Data.PageSummary exposing (Category(..), PageSummary, all, categoryToString, notFound, top)

import Data.Page exposing (Page(..))
import Html.Styled exposing (Html)
import Page exposing (..)


type alias PageSummary =
    { page : Page
    , title : String
    , description : String
    , category : Category
    , route : List String
    , view : Page.Model -> List (Html Page.Msg)
    }


type Category
    = None
    | Globals
    | Elements
    | Collections
    | Views
    | Modules
    | Defiant


categoryToString : Category -> String
categoryToString category =
    case category of
        None ->
            "None"

        Globals ->
            "Globals"

        Elements ->
            "Elements"

        Collections ->
            "Collections"

        Views ->
            "Views"

        Modules ->
            "Modules"

        Defiant ->
            "Defiant"


notFound : PageSummary
notFound =
    { page = NotFound
    , title = "Not Found"
    , description = ""
    , category = None
    , route = [ "404" ]
    , view = \_ -> []
    }


top : PageSummary
top =
    { page = Top
    , title = "Top"
    , description = ""
    , category = None
    , route = []
    , view = \_ -> []
    }


site : PageSummary
site =
    { page = Site
    , title = "Site"
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Globals
    , route = [ "site" ]
    , view = \_ -> examplesForSite
    }


button : PageSummary
button =
    { page = Button
    , title = "Button"
    , description = "A button indicates a possible user action"
    , category = Elements
    , route = [ "button" ]
    , view = examplesForButton
    }


container : PageSummary
container =
    { page = Container
    , title = "Container"
    , description = "A container limits content to a maximum width"
    , category = Elements
    , route = [ "container" ]
    , view = \_ -> examplesForContainer
    }


divider : PageSummary
divider =
    { page = Divider
    , title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Elements
    , route = [ "divider" ]
    , view = \_ -> examplesForDivider
    }


header : PageSummary
header =
    { page = Header
    , title = "Header"
    , description = "A header provides a short summary of content"
    , category = Elements
    , route = [ "header" ]
    , view = \model -> examplesForHeader { inverted = model.darkMode }
    }


icon : PageSummary
icon =
    { page = Icon
    , title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Elements
    , route = [ "icon" ]
    , view = \_ -> examplesForIcon
    }


image : PageSummary
image =
    { page = Image
    , title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Elements
    , route = [ "image" ]
    , view = \_ -> examplesForImage
    }


input : PageSummary
input =
    { page = Input
    , title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Elements
    , route = [ "input" ]
    , view = \_ -> examplesForInput
    }


label : PageSummary
label =
    { page = Label
    , title = "Label"
    , description = "A label displays content classification"
    , category = Elements
    , route = [ "label" ]
    , view = \_ -> examplesForLabel
    }


loader : PageSummary
loader =
    { page = Loader
    , title = "Loader"
    , description = "A loader alerts a user to wait for an activity to complete"
    , category = Elements
    , route = [ "loader" ]
    , view = \model -> examplesForLoader { inverted = model.darkMode }
    }


placeholder : PageSummary
placeholder =
    { page = Placeholder
    , title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Elements
    , route = [ "placeholder" ]
    , view = \_ -> examplesForPlaceholder
    }


rail : PageSummary
rail =
    { page = Rail
    , title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Elements
    , route = [ "rail" ]
    , view = \model -> examplesForRail { inverted = model.darkMode }
    }


segment : PageSummary
segment =
    { page = Segment
    , title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Elements
    , route = [ "segment" ]
    , view = \model -> examplesForSegment { inverted = model.darkMode }
    }


step : PageSummary
step =
    { page = Step
    , title = "Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "step" ]
    , view = \_ -> examplesForStep
    }


circleStep : PageSummary
circleStep =
    { page = CircleStep
    , title = "Circle Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "circle-step" ]
    , view = \_ -> examplesForCircleStep
    }


text : PageSummary
text =
    { page = Text
    , title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Elements
    , route = [ "text" ]
    , view = \model -> examplesForText { inverted = model.darkMode }
    }


breadcrumb : PageSummary
breadcrumb =
    { page = Breadcrumb
    , title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Collections
    , route = [ "breadcrumb" ]
    , view = \model -> examplesForBreadcrumb { inverted = model.darkMode }
    }


form : PageSummary
form =
    { page = Form
    , title = "Form"
    , description = "A form displays a set of related user input fields in a structured way"
    , category = Collections
    , route = [ "form" ]
    , view = \_ -> examplesForForm
    }


grid : PageSummary
grid =
    { page = Grid
    , title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Collections
    , route = [ "grid" ]
    , view = \model -> examplesForGrid { inverted = model.darkMode }
    }


menu : PageSummary
menu =
    { page = Menu
    , title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Collections
    , route = [ "menu" ]
    , view = examplesForMenu
    }


message : PageSummary
message =
    { page = Message
    , title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Collections
    , route = [ "message" ]
    , view = \model -> examplesForMessage { inverted = model.darkMode }
    }


table : PageSummary
table =
    { page = Table
    , title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = Collections
    , route = [ "table" ]
    , view = \_ -> examplesForTable
    }


card : PageSummary
card =
    { page = Card
    , title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = Views
    , route = [ "card" ]
    , view = \model -> examplesForCard { inverted = model.darkMode }
    }


item : PageSummary
item =
    { page = Item
    , title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = Views
    , route = [ "item" ]
    , view = \_ -> examplesForItem
    }


accordion : PageSummary
accordion =
    { page = Accordion
    , title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Modules
    , route = [ "accordion" ]
    , view = \model -> examplesForAccordion { inverted = model.darkMode }
    }


checkbox : PageSummary
checkbox =
    { page = Checkbox
    , title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Modules
    , route = [ "checkbox" ]
    , view = \_ -> examplesForCheckbox
    }


dimmer : PageSummary
dimmer =
    { page = Dimmer
    , title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Modules
    , route = [ "dimmer" ]
    , view = examplesForDimmer
    }


modal : PageSummary
modal =
    { page = Modal
    , title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Modules
    , route = [ "modal" ]
    , view = examplesForModal
    }


progress : PageSummary
progress =
    { page = Progress
    , title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Modules
    , route = [ "progress" ]
    , view = examplesForProgress
    }


tab : PageSummary
tab =
    { page = Tab
    , title = "Tab"
    , description = "A tab is a hidden section of content activated by a menu"
    , category = Modules
    , route = [ "tab" ]
    , view = \_ -> examplesForTab
    }


sortableTable : PageSummary
sortableTable =
    { page = SortableTable
    , title = "SortableTable"
    , description = "Sortable table"
    , category = Defiant
    , route = [ "sortable-table" ]
    , view = examplesForSortableTable
    }


holyGrail : PageSummary
holyGrail =
    { page = HolyGrail
    , title = "HolyGrail"
    , description = "Holy grail layout."
    , category = Defiant
    , route = [ "holy-grail" ]
    , view = \_ -> examplesForHolyGrail
    }


all : List PageSummary
all =
    [ notFound
    , top

    -- Globals
    , site

    -- Elements
    , button
    , container
    , divider
    , header
    , icon
    , image
    , input
    , label
    , loader
    , placeholder
    , rail
    , segment
    , step
    , circleStep
    , text

    -- Collections
    , breadcrumb
    , form
    , grid
    , menu
    , message
    , table

    -- Views
    , card
    , item

    -- Modules
    , accordion
    , checkbox
    , dimmer
    , modal
    , progress
    , tab

    -- Defiant
    , sortableTable
    , holyGrail
    ]
