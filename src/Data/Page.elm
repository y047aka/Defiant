module Data.Page exposing (Page(..), all, toPageSummary)

import Data.PageSummary exposing (PageSummary)


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
            Data.PageSummary.notFound

        Top ->
            Data.PageSummary.top

        Site ->
            Data.PageSummary.site

        Button ->
            Data.PageSummary.button

        Container ->
            Data.PageSummary.container

        Divider ->
            Data.PageSummary.divider

        Header ->
            Data.PageSummary.header

        Icon ->
            Data.PageSummary.icon

        Image ->
            Data.PageSummary.image

        Input ->
            Data.PageSummary.input

        Label ->
            Data.PageSummary.label

        Placeholder ->
            Data.PageSummary.placeholder

        Rail ->
            Data.PageSummary.rail

        Segment ->
            Data.PageSummary.segment

        Step ->
            Data.PageSummary.step

        CircleStep ->
            Data.PageSummary.circleStep

        Text ->
            Data.PageSummary.text

        Breadcrumb ->
            Data.PageSummary.breadcrumb

        Form ->
            Data.PageSummary.form

        Grid ->
            Data.PageSummary.grid

        Menu ->
            Data.PageSummary.menu

        Message ->
            Data.PageSummary.message

        Table ->
            Data.PageSummary.table

        Card ->
            Data.PageSummary.card

        Item ->
            Data.PageSummary.item

        Accordion ->
            Data.PageSummary.accordion

        Checkbox ->
            Data.PageSummary.checkbox

        Dimmer ->
            Data.PageSummary.dimmer

        Modal ->
            Data.PageSummary.modal

        Progress ->
            Data.PageSummary.progress

        SortableTable ->
            Data.PageSummary.sortableTable
