module PageSummary exposing (..)


type alias PageSummary =
    { title : String
    , description : String
    , category : Category
    , url : String
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


root : PageSummary
root =
    { title = "Top"
    , description = ""
    , category = None
    , url = "/"
    }


notFound : PageSummary
notFound =
    { title = "Not Found"
    , description = ""
    , category = None
    , url = "/404"
    }


site : PageSummary
site =
    { title = "Site"
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Globals
    , url = "/site"
    }


button : PageSummary
button =
    { title = "Button"
    , description = "A button indicates a possible user action"
    , category = Elements
    , url = "/button"
    }


container : PageSummary
container =
    { title = "Container"
    , description = "A container limits content to a maximum width"
    , category = Elements
    , url = "/container"
    }


divider : PageSummary
divider =
    { title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Elements
    , url = "/divider"
    }


header : PageSummary
header =
    { title = "Header"
    , description = "A header provides a short summary of content"
    , category = Elements
    , url = "/header"
    }


icon : PageSummary
icon =
    { title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Elements
    , url = "/icon"
    }


image : PageSummary
image =
    { title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Elements
    , url = "/image"
    }


input : PageSummary
input =
    { title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Elements
    , url = "/input"
    }


label : PageSummary
label =
    { title = "Label"
    , description = "A label displays content classification"
    , category = Elements
    , url = "/label"
    }


placeholder : PageSummary
placeholder =
    { title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Elements
    , url = "/placeholder"
    }


rail : PageSummary
rail =
    { title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Elements
    , url = "/rail"
    }


segment : PageSummary
segment =
    { title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Elements
    , url = "/segment"
    }


text : PageSummary
text =
    { title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Elements
    , url = "/text"
    }


breadcrumb : PageSummary
breadcrumb =
    { title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Collections
    , url = "/breadcrumb"
    }


grid : PageSummary
grid =
    { title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Collections
    , url = "/grid"
    }


menu : PageSummary
menu =
    { title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Collections
    , url = "/menu"
    }


message : PageSummary
message =
    { title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Collections
    , url = "/message"
    }


table : PageSummary
table =
    { title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = Collections
    , url = "/table"
    }


card : PageSummary
card =
    { title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = Views
    , url = "/card"
    }


item : PageSummary
item =
    { title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = Views
    , url = "/item"
    }


accordion : PageSummary
accordion =
    { title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Modules
    , url = "/accordion"
    }


checkbox : PageSummary
checkbox =
    { title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Modules
    , url = "/checkbox"
    }


dimmer : PageSummary
dimmer =
    { title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Modules
    , url = "/dimmer"
    }


modal : PageSummary
modal =
    { title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Modules
    , url = "/modal"
    }


progress : PageSummary
progress =
    { title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Modules
    , url = "/progress"
    }


sortableTable : PageSummary
sortableTable =
    { title = "SortableTable"
    , description = "Sortable table"
    , category = Defiant
    , url = "/sortable-table"
    }
