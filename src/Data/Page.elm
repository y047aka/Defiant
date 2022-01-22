module Data.Page exposing (Page(..), PageSummary)

import Data.Category exposing (Category(..))


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
    | Loader
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
    | Tab
    | SortableTable
    | HolyGrail


type alias PageSummary =
    { page : Page
    , title : String
    , description : String
    , category : Category
    , route : List String
    }
