module Data.Page exposing (Page(..), all)


type Page
    = NotFound
    | Top
    | Site
    | Button
    | Container
    | Divider
    | Header
    | Icon
    | Image
    | Input
    | Label
    | Placeholder
    | Rail
    | Segment
    | Step
    | CircleStep
    | Text
    | Breadcrumb
    | Form
    | Grid
    | Menu
    | Message
    | Table
    | Card
    | Item
    | Accordion
    | Checkbox
    | Dimmer
    | Modal
    | Progress
    | SortableTable


all : List Page
all =
    [ Top

    -- Globals
    , Site

    -- Elements
    , Button
    , Container
    , Divider
    , Header
    , Icon
    , Image
    , Input
    , Label
    , Placeholder
    , Rail
    , Segment
    , Step
    , CircleStep
    , Text

    -- Collections
    , Breadcrumb
    , Form
    , Grid
    , Menu
    , Message
    , Table

    -- Views
    , Card
    , Item

    -- Modules
    , Accordion
    , Checkbox
    , Dimmer
    , Modal
    , Progress

    -- Defiant
    , SortableTable
    ]
