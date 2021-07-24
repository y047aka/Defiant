module PageSummary exposing (..)


type alias PageSummary =
    { title : String
    , breadcrumbItems : List String
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


root : PageSummary
root =
    { title = "Top"
    , breadcrumbItems = [ "Top" ]
    , description = ""
    , category = None
    , url = "/"
    }


notFound : PageSummary
notFound =
    { title = "Not Found"
    , breadcrumbItems = [ "Top", "Not Found" ]
    , description = ""
    , category = None
    , url = "/404"
    }


site : PageSummary
site =
    { title = "Site"
    , breadcrumbItems = [ "Top", "Site" ]
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Globals
    , url = "/site"
    }


button : PageSummary
button =
    { title = "Button"
    , breadcrumbItems = [ "Top", "Button" ]
    , description = "A button indicates a possible user action"
    , category = Elements
    , url = "/button"
    }


container : PageSummary
container =
    { title = "Container"
    , breadcrumbItems = [ "Top", "Container" ]
    , description = "A container limits content to a maximum width"
    , category = Elements
    , url = "/container"
    }


divider : PageSummary
divider =
    { title = "Divider"
    , breadcrumbItems = [ "Top", "Divider" ]
    , description = "A divider visually segments content into groups"
    , category = Elements
    , url = "/divider"
    }


header : PageSummary
header =
    { title = "Header"
    , breadcrumbItems = [ "Top", "Header" ]
    , description = "A header provides a short summary of content"
    , category = Elements
    , url = "/header"
    }


icon : PageSummary
icon =
    { title = "Icon"
    , breadcrumbItems = [ "Top", "Icon" ]
    , description = "An icon is a glyph used to represent something else"
    , category = Elements
    , url = "/icon"
    }


image : PageSummary
image =
    { title = "Image"
    , breadcrumbItems = [ "Top", "Image" ]
    , description = "An image is a graphic representation of something"
    , category = Elements
    , url = "/image"
    }


input : PageSummary
input =
    { title = "Input"
    , breadcrumbItems = [ "Top", "Input" ]
    , description = "An input is a field used to elicit a response from a user"
    , category = Elements
    , url = "/input"
    }


label : PageSummary
label =
    { title = "Label"
    , breadcrumbItems = [ "Top", "Label" ]
    , description = "A label displays content classification"
    , category = Elements
    , url = "/label"
    }


placeholder : PageSummary
placeholder =
    { title = "Placeholder"
    , breadcrumbItems = [ "Top", "Placeholder" ]
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Elements
    , url = "/placeholder"
    }


rail : PageSummary
rail =
    { title = "Rail"
    , breadcrumbItems = [ "Top", "Rail" ]
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Elements
    , url = "/rail"
    }


segment : PageSummary
segment =
    { title = "Segment"
    , breadcrumbItems = [ "Top", "Segment" ]
    , description = "A segment is used to create a grouping of related content"
    , category = Elements
    , url = "/segment"
    }


text : PageSummary
text =
    { title = "Text"
    , breadcrumbItems = [ "Top", "Text" ]
    , description = "A text is used to style some inline text with a simple color"
    , category = Elements
    , url = "/text"
    }


breadcrumb : PageSummary
breadcrumb =
    { title = "Breadcrumb"
    , breadcrumbItems = [ "Top", "Breadcrumb" ]
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Collections
    , url = "/breadcrumb"
    }


grid : PageSummary
grid =
    { title = "Grid"
    , breadcrumbItems = [ "Top", "Grid" ]
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Collections
    , url = "/grid"
    }


menu : PageSummary
menu =
    { title = "Menu"
    , breadcrumbItems = [ "Top", "Menu" ]
    , description = "A menu displays grouped navigation actions"
    , category = Collections
    , url = "/menu"
    }


message : PageSummary
message =
    { title = "Message"
    , breadcrumbItems = [ "Top", "Message" ]
    , description = "A message displays information that explains nearby content"
    , category = Collections
    , url = "/message"
    }


table : PageSummary
table =
    { title = "Table"
    , breadcrumbItems = [ "Top", "Table" ]
    , description = "A table displays a collections of data grouped into rows"
    , category = Collections
    , url = "/table"
    }


card : PageSummary
card =
    { title = "Card"
    , breadcrumbItems = [ "Top", "Card" ]
    , description = "A card displays site content in a manner similar to a playing card"
    , category = Views
    , url = "/card"
    }


item : PageSummary
item =
    { title = "Item"
    , breadcrumbItems = [ "Top", "Item" ]
    , description = "An item view presents large collections of site content for display"
    , category = Views
    , url = "/item"
    }


checkbox : PageSummary
checkbox =
    { title = "Checkbox"
    , breadcrumbItems = [ "Top", "Checkbox" ]
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Modules
    , url = "/checkbox"
    }


dimmer : PageSummary
dimmer =
    { title = "Dimmer"
    , breadcrumbItems = [ "Top", "Dimmer" ]
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Modules
    , url = "/dimmer"
    }


modal : PageSummary
modal =
    { title = "Modal"
    , breadcrumbItems = [ "Top", "Modal" ]
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Modules
    , url = "/modal"
    }
