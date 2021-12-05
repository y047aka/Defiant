module Page exposing (Page(..), all, toPageSummary)

import PageSummary exposing (PageSummary)


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


toPageSummary : Page -> PageSummary
toPageSummary page =
    case page of
        NotFound ->
            PageSummary.notFound

        Top ->
            PageSummary.top

        Site ->
            PageSummary.site

        Button ->
            PageSummary.button

        Container ->
            PageSummary.container

        Divider ->
            PageSummary.divider

        Header ->
            PageSummary.header

        Icon ->
            PageSummary.icon

        Image ->
            PageSummary.image

        Input ->
            PageSummary.input

        Label ->
            PageSummary.label

        Placeholder ->
            PageSummary.placeholder

        Rail ->
            PageSummary.rail

        Segment ->
            PageSummary.segment

        Step ->
            PageSummary.step

        CircleStep ->
            PageSummary.circleStep

        Text ->
            PageSummary.text

        Breadcrumb ->
            PageSummary.breadcrumb

        Form ->
            PageSummary.form

        Grid ->
            PageSummary.grid

        Menu ->
            PageSummary.menu

        Message ->
            PageSummary.message

        Table ->
            PageSummary.table

        Card ->
            PageSummary.card

        Item ->
            PageSummary.item

        Accordion ->
            PageSummary.accordion

        Checkbox ->
            PageSummary.checkbox

        Dimmer ->
            PageSummary.dimmer

        Modal ->
            PageSummary.modal

        Progress ->
            PageSummary.progress

        SortableTable ->
            PageSummary.sortableTable
