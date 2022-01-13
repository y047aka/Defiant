module Category.Collections exposing
    ( Model, init, Msg, update
    , examplesForBreadcrumb, examplesForForm, examplesForGrid, examplesForMenu, examplesForMessage, examplesForTable
    )

{-|

@docs Model, init, Msg, update
@docs examplesForBreadcrumb, examplesForForm, examplesForGrid, examplesForMenu, examplesForMessage, examplesForTable

-}

import Css exposing (..)
import Html.Styled as Html exposing (Html, div, input, p, text)
import Html.Styled.Attributes as Attributes exposing (css, for, href, id, name, placeholder, rel, rows, src, tabindex, type_)
import UI.Breadcrumb exposing (breadcrumb)
import UI.Button exposing (..)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Example exposing (..)
import UI.Form as Form exposing (State(..), checkboxLabel, field, fields, form, textarea, threeFields, twoFields)
import UI.Grid as Grid exposing (eightWideColumn, fourWideColumn, grid, sixWideColumn, threeColumnsGrid, twoWideColumn)
import UI.Header as Header exposing (..)
import UI.Icon exposing (icon)
import UI.Image exposing (smallImage)
import UI.Input as Input
import UI.Menu as Menu exposing (..)
import UI.Message exposing (message)
import UI.Segment exposing (..)
import UI.Table exposing (..)


type alias Model =
    { darkMode : Bool }


init : Bool -> ( Model, Cmd Msg )
init darkMode =
    ( { darkMode = darkMode }, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


examplesForBreadcrumb : { inverted : Bool } -> List (Html msg)
examplesForBreadcrumb { inverted } =
    [ example
        { title = "Breadcrumb"
        , description = "A standard breadcrumb"
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ breadcrumb { divider = icon [] "fas fa-angle-right", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        ]
    , example
        { title = "Divider"
        , description = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Registration", url = "/" }
            , { label = "Personal Information", url = "" }
            ]
        ]
    , example
        { title = "Active"
        , description = "A section can be active"
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Products", url = "/" }
            , { label = "Paper Towels", url = "" }
            ]
        ]
    , example
        { title = "Inverted"
        , description = "A breadcrumb can be inverted"
        }
        [ segment { inverted = True }
            []
            [ breadcrumb { divider = text "/", inverted = True }
                [ { label = "Home", url = "/" }
                , { label = "Registration", url = "/" }
                , { label = "Personal Information", url = "" }
                ]
            ]
        ]
    ]


examplesForForm : List (Html msg)
examplesForForm =
    let
        fieldsWithState options =
            [ twoFields []
                [ field
                    { type_ = "text"
                    , label = "First Name"
                    , state = options.state
                    }
                    []
                    [ Form.input { state = options.state } [ type_ "text", placeholder "First Name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Last Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                ]
            , field
                { type_ = "checkbox"
                , label = ""
                , state = options.state
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id options.id, type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = options.state } [ for options.id ] [ text "I agree to the Terms and Conditions" ]
                    ]
                ]
            ]
    in
    [ example
        { title = "Form"
        , description = "A form"
        }
        [ form []
            [ field
                { type_ = "text"
                , label = "First Name"
                , state = Default
                }
                []
                [ Form.input { state = Default } [ type_ "text", name "first-name", placeholder "First Name" ] [] ]
            , field
                { type_ = "text"
                , label = "Last Name"
                , state = Default
                }
                []
                [ Form.input { state = Default } [ type_ "text", name "last-name", placeholder "Last Name" ] [] ]
            , field
                { type_ = "checkbox"
                , label = ""
                , state = Default
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id "checkbox_example_1", type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = Default } [ for "checkbox_example_1" ] [ text "I agree to the Terms and Conditions" ]
                    ]
                ]
            , button [ type_ "submit" ] [ text "Submit" ]
            ]
        ]
    , example
        { title = "Field"
        , description = "A field is a form element containing a label and an input"
        }
        [ form []
            [ field
                { type_ = "text"
                , label = "User Input"
                , state = Default
                }
                []
                [ Form.input { state = Default } [ type_ "text" ] [] ]
            ]
        ]
    , example
        { title = "Fields"
        , description = "A set of fields can appear grouped together"
        }
        [ form []
            [ fields []
                [ field
                    { type_ = "text"
                    , label = "First Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "First Name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Middle name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Middle name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Last Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                ]
            ]
        ]
    , example
        { title = "", description = "" }
        [ form []
            [ threeFields []
                [ field
                    { type_ = "text"
                    , label = "First Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "First Name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Middle name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Middle name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Last Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                ]
            ]
        ]
    , example
        { title = "Text Area"
        , description = "A textarea can be used to allow for extended user input."
        }
        [ form []
            [ field
                { type_ = "textarea"
                , label = "Text"
                , state = Default
                }
                []
                [ textarea { state = Default } [] [] ]
            , field
                { type_ = "textarea"
                , label = "Short Text"
                , state = Default
                }
                []
                [ textarea { state = Default } [ rows 2 ] [] ]
            ]
        ]
    , example
        { title = "Checkbox"
        , description = "A form can contain a checkbox"
        }
        [ form []
            [ field
                { type_ = "checkbox"
                , label = ""
                , state = Default
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id "checkbox_example_2", type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = Default } [ for "checkbox_example_2" ] [ text "Checkbox" ]
                    ]
                ]
            ]
        ]
    , example
        { title = "Field Error"
        , description = "Individual fields may display an error state"
        }
        [ form [] (fieldsWithState { id = "state_example_1", state = Error }) ]
    , example
        { title = "Field Warning"
        , description = "Individual fields may display a warning state"
        }
        [ form [] (fieldsWithState { id = "state_example_2", state = Warning }) ]
    , example
        { title = "Field Success"
        , description = "Individual fields may display a Success state"
        }
        [ form [] (fieldsWithState { id = "state_example_3", state = Success }) ]
    , example
        { title = "Field Info"
        , description = "Individual fields may display an informational state"
        }
        [ form [] (fieldsWithState { id = "state_example_4", state = Info }) ]
    ]


examplesForGrid : { inverted : Bool } -> List (Html msg)
examplesForGrid { inverted } =
    let
        additionalStyles =
            [ position relative
            , before
                [ position absolute
                , top (rem 1)
                , left (rem 1)
                , backgroundColor (hex "FAFAFA")
                , property "content" (qt "")
                , width (calc (pct 100) minus (rem 2))
                , height (calc (pct 100) minus (rem 2))
                , property "box-shadow" "0px 0px 0px 1px #DDDDDD inset"
                ]
            ]

        dummyContent =
            css
                [ after
                    [ property "content" (qt "")
                    , display block
                    , minHeight (px 50)
                    , backgroundColor (rgba 86 61 124 0.1)
                    , property "box-shadow" "0px 0px 0px 1px rgba(86, 61, 124, 0.2) inset"
                    ]
                ]
    in
    [ example
        { title = "Grids"
        , description = """A grid is a structure with a long history used to align negative space in designs.
Using a grid makes content appear to flow more naturally on your page."""
        }
        [ grid [ css additionalStyles ]
            [ fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            ]
        ]
    , example
        { title = "Columns"
        , description = """Grids divide horizontal space into indivisible units called "columns". All columns in a grid must specify their width as proportion of the total available row width.
All grid systems choose an arbitrary column count to allow per row. Fomantic's default theme uses 16 columns.
The example below shows four four wide columns will fit in the first row, 16 / 4 = 4, and three various sized columns in the second row. 2 + 8 + 6 = 16
The default column count, and other arbitrary features of grids can be changed by adjusting Fomantic UI's underlying theming variables."""
        }
        [ grid [ css additionalStyles ]
            [ fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , twoWideColumn [ dummyContent ] []
            , eightWideColumn [ dummyContent ] []
            , sixWideColumn [ dummyContent ] []
            ]
        ]
    , example
        { title = "Automatic Flow"
        , description = "Most grids do not need to specify rows. Content will automatically flow to the next row when all the grid columns are taken in the current row."
        }
        [ grid [ css additionalStyles ]
            [ fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            ]
        ]
    , example
        { title = "Column Content"
        , description = "Since columns use padding to create gutters, content stylings should not be applied directly to columns, but to elements inside of columns."
        }
        [ let
            imageSegment =
                segment { inverted = inverted }
                    []
                    [ smallImage [ src "./static/images/wireframe/image.png" ] [] ]
          in
          threeColumnsGrid []
            [ Grid.column [] [ imageSegment ]
            , Grid.column [] [ imageSegment ]
            , Grid.column [] [ imageSegment ]
            ]
        ]
    ]


examplesForMenu : Model -> List (Html msg)
examplesForMenu model =
    [ example
        { title = "Secondary Menu"
        , description = "A menu can adjust its appearance to de-emphasize its contents"
        }
        [ secondaryMenu { inverted = False } [] <|
            [ secondaryMenuActiveItem [] [ text "Home" ]
            , secondaryMenuItem [] [] [ text "Messages" ]
            , secondaryMenuItem [] [] [ text "Friends" ]
            , rightMenu []
                [ secondaryMenuItem [] [] <|
                    [ Input.input []
                        [ input [ type_ "text", placeholder "Search..." ] [] ]
                    ]
                , secondaryMenuItem [] [] [ text "Logout" ]
                ]
            ]
        ]
    , example
        { title = "Vertical Menu"
        , description = "A vertical menu displays elements vertically.."
        }
        [ verticalMenu { inverted = model.darkMode, additionalStyles = [] } [] <|
            [ verticalMenuActiveItem { inverted = model.darkMode } [] <|
                [ text "Inbox"
                , verticalMenuActiveItemLabel [] [ text "1" ]
                ]
            , verticalMenuItem { inverted = model.darkMode, additionalStyles = [] } [] <|
                [ text "Spam"
                , verticalMenuActiveItemLabel [] [ text "51" ]
                ]
            , verticalMenuItem { inverted = model.darkMode, additionalStyles = [] } [] <|
                [ text "Updates"
                , verticalMenuActiveItemLabel [] [ text "1" ]
                ]
            , verticalMenuItem { inverted = model.darkMode, additionalStyles = [] } [] [ text "Search mail..." ]
            ]
        ]
    , example
        { title = "Link Item"
        , description = "A menu may contain a link item, or an item formatted as if it is a link."
        }
        [ verticalMenu { inverted = model.darkMode, additionalStyles = [] } [] <|
            [ verticalMenuLinkItem { inverted = model.darkMode, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
            , verticalMenuLinkItem { inverted = model.darkMode, additionalStyles = [] } [] [ text "Javascript Link" ]
            ]
        ]
    , example
        { title = "Inverted"
        , description = "A menu may have its colors inverted to show greater contrast"
        }
        [ Menu.menu { inverted = True } [] <|
            [ linkItem { inverted = True } [] [ text "Home" ]
            , linkItem { inverted = True } [] [ text "Messages" ]
            , linkItem { inverted = True } [] [ text "Friends" ]
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ invertedSegment []
            [ secondaryMenu { inverted = False } [] <|
                [ linkItem { inverted = True } [] [ text "Home" ]
                , linkItem { inverted = True } [] [ text "Messages" ]
                , linkItem { inverted = True } [] [ text "Friends" ]
                ]
            ]
        ]
    ]


examplesForMessage : { inverted : Bool } -> List (Html msg)
examplesForMessage options =
    [ example
        { title = "Message"
        , description = "A basic message"
        }
        [ message []
            [ div []
                [ Header.header options [] [ text "Changes in Service" ]
                , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                ]
            ]
        ]
    , example
        { title = "Icon Message"
        , description = "A message can contain an icon."
        }
        [ message []
            [ icon [] "fas fa-inbox"
            , div []
                [ Header.header options [] [ text "Have you heard about our mailing list?" ]
                , p [] [ text "Get the best news in your e-mail every day." ]
                ]
            ]
        ]
    ]


examplesForTable : List (Html msg)
examplesForTable =
    [ example
        { title = "Table"
        , description = "A standard table"
        }
        [ celledTable []
            [ thead []
                [ tr [] <|
                    List.map (\item -> th [] [ text item ])
                        [ "Name", "Age", "Job" ]
                ]
            , tbody [] <|
                List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                    [ [ "James", "24", "Engineer" ]
                    , [ "Jill", "26", "Engineer" ]
                    , [ "Elyse", "24", "Designer" ]
                    ]
            ]
        ]
    , example
        { title = "Striped"
        , description = "A table can stripe alternate rows of content with a darker color to increase contrast"
        }
        [ stripedTable []
            [ thead []
                [ tr [] <|
                    List.map (\item -> th [] [ text item ])
                        [ "Name", "Date Joined", "E-mail", "Called" ]
                ]
            , tbody [] <|
                List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                    [ [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                    , [ "Jamie Harington", "January 11, 2014", "jamieharingonton@yahoo.com", "Yes" ]
                    , [ "Jill Lewis", "May 11, 2014", "jilsewris22@yahoo.com", "Yes" ]
                    , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                    , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                    , [ "Jamie Harington", "January 11, 2014", "jamieharingonton@yahoo.com", "Yes" ]
                    , [ "Jill Lewis", "May 11, 2014", "jilsewris22@yahoo.com", "Yes" ]
                    , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                    ]
            ]
        ]
    , example
        { title = "Basic"
        , description = "A table can reduce its complexity to increase readability."
        }
        [ basicTable []
            [ thead []
                [ tr [] <|
                    List.map (\item -> th [] [ text item ])
                        [ "Name", "Status", "Notes" ]
                ]
            , tbody [] <|
                List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                    [ [ "John", "Approved", "None" ]
                    , [ "Jamie", "Approved", "Requires call" ]
                    , [ "Jill", "Denied", "None" ]
                    ]
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ veryBasicTable []
            [ thead []
                [ tr [] <|
                    List.map (\item -> th [] [ text item ])
                        [ "Name", "Status", "Notes" ]
                ]
            , tbody [] <|
                List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                    [ [ "John", "Approved", "None" ]
                    , [ "Jamie", "Approved", "Requires call" ]
                    , [ "Jill", "Denied", "None" ]
                    ]
            ]
        ]
    ]
