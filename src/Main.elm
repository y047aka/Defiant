module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document)
import Browser.Navigation as Nav exposing (Key)
import Css exposing (..)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Html.Styled exposing (Attribute, Html, a, div, h1, h2, h3, h4, h5, input, p, span, strong, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (css, for, href, id, rel, src, type_)
import Html.Styled.Events exposing (onClick, onInput)
import PageSummary exposing (Category(..), PageSummary)
import UI.Accordion as Accordion
import UI.Breadcrumb exposing (..)
import UI.Button exposing (..)
import UI.Card as Card exposing (..)
import UI.Checkbox as Checkbox exposing (..)
import UI.Container exposing (..)
import UI.Dimmer as Dimmer exposing (..)
import UI.Divider as Divider
import UI.Example exposing (..)
import UI.Grid as Grid exposing (..)
import UI.Header as Header exposing (..)
import UI.Icon as Icon exposing (..)
import UI.Image exposing (..)
import UI.Input as Input
import UI.Item as Item exposing (..)
import UI.Label as Label exposing (..)
import UI.Menu as Menu exposing (..)
import UI.Message exposing (..)
import UI.Modal as Modal exposing (..)
import UI.Placeholder exposing (line, placeholder)
import UI.Rail exposing (..)
import UI.Segment exposing (..)
import UI.SortableTable as Table
import UI.Table exposing (..)
import UI.Text exposing (..)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, s)



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        }



-- MODEL


type alias Model =
    { key : Key
    , page : Page
    , darkMode : Bool
    , count : Int
    , toggledItems : List String

    -- for SortableTable
    , people : List Person
    , tableState : Table.State
    , query : String
    }


type Page
    = NotFound
    | TopPage
    | SitePage
    | ButtonPage
    | ContainerPage
    | DividerPage
    | HeaderPage
    | IconPage
    | ImagePage
    | InputPage
    | LabelPage
    | PlaceholderPage
    | RailPage
    | SegmentPage
    | TextPage
    | BreadcrumbPage
    | GridPage
    | MenuPage
    | MessagePage
    | TablePage
    | CardPage
    | ItemPage
    | AccordionPage
    | CheckboxPage
    | DimmerPage
    | ModalPage
    | SortableTablePage


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    routing url
        { key = key
        , page = TopPage
        , darkMode = False
        , count = 0
        , toggledItems = []

        -- for SortableTable
        , people = presidents
        , tableState = Table.initialSort "Year"
        , query = ""
        }



-- ROUTER


type Route
    = Top
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
    | Text
    | Breadcrumb
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
    | SortableTable


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Top Parser.top
        , Parser.map Site (s "site")
        , Parser.map Button (s "button")
        , Parser.map Container (s "container")
        , Parser.map Divider (s "divider")
        , Parser.map Header (s "header")
        , Parser.map Icon (s "icon")
        , Parser.map Image (s "image")
        , Parser.map Input (s "input")
        , Parser.map Label (s "label")
        , Parser.map Placeholder (s "placeholder")
        , Parser.map Rail (s "rail")
        , Parser.map Segment (s "segment")
        , Parser.map Text (s "text")
        , Parser.map Breadcrumb (s "breadcrumb")
        , Parser.map Grid (s "grid")
        , Parser.map Menu (s "menu")
        , Parser.map Message (s "message")
        , Parser.map Table (s "table")
        , Parser.map Card (s "card")
        , Parser.map Item (s "item")
        , Parser.map Accordion (s "accordion")
        , Parser.map Checkbox (s "checkbox")
        , Parser.map Dimmer (s "dimmer")
        , Parser.map Modal (s "modal")
        , Parser.map SortableTable (s "sortable-table")
        ]


routing : Url -> Model -> ( Model, Cmd Msg )
routing url model =
    let
        maybeRoute : Maybe Route
        maybeRoute =
            Parser.parse parser url

        switchTo page =
            ( { model | page = page }, Cmd.none )
    in
    switchTo <|
        case maybeRoute of
            Nothing ->
                NotFound

            Just Top ->
                TopPage

            Just Site ->
                SitePage

            Just Button ->
                ButtonPage

            Just Container ->
                ContainerPage

            Just Divider ->
                DividerPage

            Just Header ->
                HeaderPage

            Just Icon ->
                IconPage

            Just Image ->
                ImagePage

            Just Input ->
                InputPage

            Just Label ->
                LabelPage

            Just Placeholder ->
                PlaceholderPage

            Just Rail ->
                RailPage

            Just Segment ->
                SegmentPage

            Just Text ->
                TextPage

            Just Breadcrumb ->
                BreadcrumbPage

            Just Grid ->
                GridPage

            Just Menu ->
                MenuPage

            Just Message ->
                MessagePage

            Just Table ->
                TablePage

            Just Card ->
                CardPage

            Just Item ->
                ItemPage

            Just Accordion ->
                AccordionPage

            Just Checkbox ->
                CheckboxPage

            Just Dimmer ->
                DimmerPage

            Just Modal ->
                ModalPage

            Just SortableTable ->
                SortableTablePage



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
    | ToggleDarkMode
    | Increment
    | Decrement
    | Toggle String
      -- for SortableTable
    | SetQuery String
    | SetTableState Table.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            routing url model

        ToggleDarkMode ->
            ( { model | darkMode = not model.darkMode }, Cmd.none )

        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        Toggle newItem ->
            ( { model
                | toggledItems =
                    if List.member newItem model.toggledItems then
                        List.filter ((/=) newItem) model.toggledItems

                    else
                        newItem :: model.toggledItems
              }
            , Cmd.none
            )

        SetQuery newQuery ->
            ( { model | query = newQuery }, Cmd.none )

        SetTableState newState ->
            ( { model | tableState = newState }, Cmd.none )



-- VIEW


view : Model -> Document Msg
view model =
    let
        document { summary, contents } =
            { title =
                if List.length summary.breadcrumbItems > 1 then
                    summary.title ++ " | Defiant"

                else
                    "Defiant"
            , body =
                [ toUnstyled <|
                    div []
                        [ global (normalize ++ additionalReset ++ globalCustomize ++ fontAwesome)
                        , basicSegment { inverted = False }
                            []
                            [ container []
                                [ summary.breadcrumbItems
                                    |> List.indexedMap (breadcrumbItem <| List.length summary.breadcrumbItems)
                                    |> breadcrumb { divider = text "/", inverted = model.darkMode }
                                ]
                            ]
                        , basicSegment { inverted = False }
                            []
                            [ container []
                                [ checkbox []
                                    [ input
                                        [ id "darkmode"
                                        , type_ "checkbox"
                                        , Attributes.checked model.darkMode
                                        , onClick ToggleDarkMode
                                        ]
                                        []
                                    , Checkbox.label [ for "darkmode" ] [ text "Dark mode" ]
                                    ]
                                ]
                            ]
                        , basicSegment { inverted = False }
                            []
                            [ container [] contents ]
                        ]
                ]
            }

        breadcrumbItem length index item =
            if index + 1 == length then
                activeSection [] [ text item ]

            else
                section [ href "/" ] [ text item ]
    in
    document <|
        case model.page of
            NotFound ->
                { summary = PageSummary.notFound
                , contents = []
                }

            TopPage ->
                { summary = PageSummary.root
                , contents = tableOfContents { inverted = model.darkMode }
                }

            SitePage ->
                { summary = PageSummary.site
                , contents = examplesForSite
                }

            ButtonPage ->
                { summary = PageSummary.button
                , contents = examplesForButton model
                }

            ContainerPage ->
                { summary = PageSummary.container
                , contents = examplesForContainer
                }

            DividerPage ->
                { summary = PageSummary.divider
                , contents = examplesForDivider
                }

            HeaderPage ->
                { summary = PageSummary.header
                , contents = examplesForHeader { inverted = model.darkMode }
                }

            IconPage ->
                { summary = PageSummary.icon
                , contents = examplesForIcon
                }

            ImagePage ->
                { summary = PageSummary.image
                , contents = examplesForImage
                }

            InputPage ->
                { summary = PageSummary.input
                , contents = examplesForInput
                }

            LabelPage ->
                { summary = PageSummary.label
                , contents = examplesForLabel
                }

            PlaceholderPage ->
                { summary = PageSummary.placeholder
                , contents = examplesForPlaceholder
                }

            RailPage ->
                { summary = PageSummary.rail
                , contents = examplesForRail { inverted = model.darkMode }
                }

            SegmentPage ->
                { summary = PageSummary.segment
                , contents = examplesForSegment { inverted = model.darkMode }
                }

            TextPage ->
                { summary = PageSummary.text
                , contents = examplesForText { inverted = model.darkMode }
                }

            BreadcrumbPage ->
                { summary = PageSummary.breadcrumb
                , contents = examplesForBreadcrumb { inverted = model.darkMode }
                }

            GridPage ->
                { summary = PageSummary.grid
                , contents = examplesForGrid
                }

            MenuPage ->
                { summary = PageSummary.menu
                , contents = examplesForMenu model
                }

            MessagePage ->
                { summary = PageSummary.message
                , contents = examplesForMessage { inverted = model.darkMode }
                }

            TablePage ->
                { summary = PageSummary.table
                , contents = examplesForTable
                }

            CardPage ->
                { summary = PageSummary.card
                , contents = examplesForCard { inverted = model.darkMode }
                }

            ItemPage ->
                { summary = PageSummary.item
                , contents = examplesForItem
                }

            AccordionPage ->
                { summary = PageSummary.accordion
                , contents = examplesForAccordion { inverted = model.darkMode }
                }

            CheckboxPage ->
                { summary = PageSummary.checkbox
                , contents = examplesForCheckbox
                }

            DimmerPage ->
                { summary = PageSummary.dimmer
                , contents = examplesForDimmer model
                }

            ModalPage ->
                { summary = PageSummary.modal
                , contents = examplesForModal model
                }

            SortableTablePage ->
                { summary = PageSummary.sortableTable
                , contents = examplesForSortableTable model
                }


tableOfContents : { inverted : Bool } -> List (Html msg)
tableOfContents options =
    let
        item { title, description, url } =
            card options
                []
                [ a [ href url ]
                    [ Card.content options
                        []
                        { header = [ text title ]
                        , meta = []
                        , description = [ text description ]
                        }
                    ]
                ]
    in
    List.map
        (\category ->
            basicSegment options
                []
                [ Header.header options [] [ text (PageSummary.categoryToString category) ]
                , cards []
                    (List.filter (.category >> (==) category) contents_
                        |> List.map item
                    )
                ]
        )
        [ Globals, Elements, Collections, Views, Modules, Defiant ]


contents_ : List PageSummary
contents_ =
    [ PageSummary.site
    , PageSummary.button
    , PageSummary.container
    , PageSummary.divider
    , PageSummary.header
    , PageSummary.icon
    , PageSummary.image
    , PageSummary.input
    , PageSummary.label
    , PageSummary.placeholder
    , PageSummary.rail
    , PageSummary.segment
    , PageSummary.text
    , PageSummary.breadcrumb
    , PageSummary.grid
    , PageSummary.menu
    , PageSummary.message
    , PageSummary.table
    , PageSummary.card
    , PageSummary.item
    , PageSummary.accordion
    , PageSummary.checkbox
    , PageSummary.dimmer
    , PageSummary.modal
    , PageSummary.sortableTable
    ]


examplesForSite : List (Html msg)
examplesForSite =
    [ example
        { title = "Headers"
        , description = "A site can define styles for headers"
        , contents =
            [ h1 [] [ text "First Header" ]
            , h2 [] [ text "Second Header" ]
            , h3 [] [ text "Third Header" ]
            , h4 [] [ text "Fourth Header" ]
            , h5 [] [ text "Fifth Header" ]
            ]
        }
    , example
        { title = "Page Font"
        , description = "A site can specify styles for page content."
        , contents =
            [ p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
            , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
            , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
            ]
        }
    , example
        { title = "Text Selection"
        , description = "A site can specify text selection styles."
        , contents =
            [ p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ] ]
        }
    , example
        { title = "Spacing"
        , description = "A site can define default spacing for headers and paragraphs"
        , contents =
            [ p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
            , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
            , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
            ]
        }
    ]


examplesForButton : Model -> List (Html Msg)
examplesForButton { count } =
    [ example
        { title = "Button"
        , description = "A standard button"
        , contents = [ button [] [ text "Follow" ] ]
        }
    , example
        { title = ""
        , description = ""
        , contents =
            [ button [] [ text "Button" ]
            , button [] [ text "Focusable" ]
            ]
        }
    , example
        { title = "Emphasis"
        , description = "A button can be formatted to show different levels of emphasis"
        , contents =
            [ primaryButton [] [ text "Save" ]
            , button [] [ text "Discard" ]
            ]
        }
    , example
        { title = ""
        , description = ""
        , contents =
            [ secondaryButton [] [ text "Okay" ]
            , button [] [ text "Cancel" ]
            ]
        }
    , example
        { title = "Labeled"
        , description = "A button can appear alongside a label"
        , contents =
            [ labeledButton []
                [ button [] [ icon [] "fas fa-heart", text "Like" ]
                , basicLabel [] [ text "2048" ]
                ]
            , labeledButton []
                [ button [ onClick Decrement ] [ text "-" ]
                , basicLabel [] [ text (String.fromInt count) ]
                , button [ onClick Increment ] [ text "+" ]
                ]
            ]
        }
    , example
        { title = "Icon"
        , description = "A button can have only an icon"
        , contents = [ button [] [ icon [] "fas fa-cloud" ] ]
        }
    , example
        { title = "Basic"
        , description = "A basic button is less pronounced"
        , contents = [ basicButton [] [ icon [] "fas fa-user", text "Add Friend" ] ]
        }
    , example
        { title = "Colored"
        , description = "A button can have different colors"
        , contents =
            [ primaryButton [] [ text "Primary" ]
            , secondaryButton [] [ text "Secondary" ]
            , redButton [] [ text "Red" ]
            , orangeButton [] [ text "Orange" ]
            , yellowButton [] [ text "Yellow" ]
            , oliveButton [] [ text "Olive" ]
            , greenButton [] [ text "Green" ]
            , tealButton [] [ text "Teal" ]
            , blueButton [] [ text "Blue" ]
            , violetButton [] [ text "Violet" ]
            , purpleButton [] [ text "Purple" ]
            , pinkButton [] [ text "Pink" ]
            , brownButton [] [ text "Brown" ]
            , greyButton [] [ text "Grey" ]
            , blackButton [] [ text "Black" ]
            ]
        }
    ]


examplesForContainer : List (Html msg)
examplesForContainer =
    let
        content =
            p []
                [ text "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa "
                , strong [] [ text "strong" ]
                , text ". Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede "
                , a [ href "#" ] [ text "link" ]
                , text " mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi."
                ]
    in
    [ example
        { title = "Container"
        , description = "A standard container"
        , contents = [ container [] [ content ] ]
        }
    , example
        { title = "Text Container"
        , description = "A container can reduce its maximum width to more naturally accomodate a single column of text"
        , contents =
            [ textContainer []
                [ h2 [] [ text "Header" ]
                , content
                , content
                ]
            ]
        }
    ]


examplesForDivider : List (Html msg)
examplesForDivider =
    [ example
        { title = "Divider"
        , description = "A standard divider"
        , contents =
            [ wireframeShortParagraph
            , Divider.divider [] []
            , wireframeShortParagraph
            ]
        }
    ]


examplesForHeader : { inverted : Bool } -> List (Html msg)
examplesForHeader options =
    [ example
        { title = "Content Headers"
        , description = "Headers may be oriented to give the importance of a section in the context of the content that surrounds it"
        , contents =
            [ massiveHeader options [] [ text "Massive Header" ]
            , wireframeShortParagraph
            , hugeHeader options [] [ text "Huge Header" ]
            , wireframeShortParagraph
            , bigHeader options [] [ text "Big Header" ]
            , wireframeShortParagraph
            , largeHeader options [] [ text "Large Header" ]
            , wireframeShortParagraph
            , mediumHeader options [] [ text "Medium Header" ]
            , wireframeShortParagraph
            , smallHeader options [] [ text "Small Header" ]
            , wireframeShortParagraph
            , tinyHeader options [] [ text "Tiny Header" ]
            , wireframeShortParagraph
            , miniHeader options [] [ text "Mini Header" ]
            , wireframeShortParagraph
            ]
        }
    , example
        { title = "Icon Headers"
        , description = "A header can be formatted to emphasize an icon"
        , contents =
            [ iconHeader options
                []
                [ icon [] "fas fa-cogs"
                , iconHeaderContent []
                    [ text "Account Settings"
                    , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
                    ]
                ]
            ]
        }
    , example
        { title = "Subheader"
        , description = "Headers may contain subheaders"
        , contents =
            [ Header.header options
                []
                [ text "Account Settings"
                , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
                , wireframeShortParagraph
                ]
            ]
        }
    ]


examplesForIcon : List (Html msg)
examplesForIcon =
    let
        column : List (Attribute msg) -> List (Html msg) -> Html msg
        column attributes =
            Grid.column <|
                css
                    [ -- #example .icon.example .grid > .column
                      opacity (num 0.8)
                    , textAlign center
                    , color transparent
                    , property "-moz-align-items" "center"
                    , property "-ms-align-items" "center"
                    , property "align-items" "center"

                    -- #example .icon.example .grid .column
                    , color (hex "#333333")
                    ]
                    :: attributes

        icon =
            Icon.icon
                [ css
                    [ -- #example .icon.example .column .icon
                      opacity (num 1)
                    , height (em 1)
                    , color (hex "#333333")
                    , display block
                    , margin3 (em 0) auto (em 0.25)
                    , fontSize (em 2)
                    ]
                ]
    in
    [ example
        { title = "Accessibility"
        , description = "Icons can represent accessibility standards"
        , contents =
            [ fiveColumnsGrid []
                [ -- row 1
                  column [] [ icon "fab fa-accessible-icon", text "accessible icon" ]
                , column [] [ icon "fas fa-american-sign-language-interpreting", text "american sign language interpreting" ]
                , column [] [ icon "fas fa-assistive-listening-systems", text "assistive listening systems" ]
                , column [] [ icon "fas fa-audio-description", text "audio description" ]
                , column [] [ icon "fas fa-blind", text "blind" ]

                -- row 2
                , column [] [ icon "fas fa-braille", text "braille" ]
                , column [] [ icon "fas fa-closed-captioning", text "closed captioning" ]
                , column [] [ icon "far fa-closed-captioning", text "closed captioning" ]
                , column [] [ icon "fas fa-deaf", text "deaf" ]
                , column [] [ icon "fas fa-low-vision", text "low vision" ]

                -- row 3
                , column [] [ icon "fas fa-phone-volume", text "phone volume" ]
                , column [] [ icon "fas fa-question-circle", text "question circle" ]
                , column [] [ icon "far fa-question-circle", text "question circle" ]
                , column [] [ icon "fas fa-sign-language", text "sign language" ]
                , column [] [ icon "fas fa-tty", text "tty" ]

                -- row 4
                , column [] [ icon "fas fa-universal-access", text "universal access" ]
                , column [] [ icon "fas fa-wheelchair", text "wheelchair" ]
                ]
            ]
        }
    ]


examplesForImage : List (Html msg)
examplesForImage =
    [ example
        { title = "Image"
        , description = "An image"
        , contents = [ smallImage [ src "./static/images/wireframe/image.png" ] [] ]
        }
    ]


examplesForInput : List (Html msg)
examplesForInput =
    [ example
        { title = "Input"
        , description = "A standard input"
        , contents =
            [ Input.input []
                [ input [ type_ "text", Attributes.placeholder "Search..." ] [] ]
            ]
        }
    , example
        { title = "Labeled"
        , description = "An input can be formatted with a label"
        , contents =
            [ Input.input []
                [ Input.label [] [ text "http://" ]
                , input [ type_ "text", Attributes.placeholder "mysite.com" ] []
                ]
            ]
        }
    , example
        { title = ""
        , description = ""
        , contents =
            [ Input.input []
                [ input [ type_ "text", Attributes.placeholder "Enter weight.." ] []
                , Input.label [] [ text "kg" ]
                ]
            ]
        }
    ]


examplesForLabel : List (Html msg)
examplesForLabel =
    [ example
        { title = "Label"
        , description = "A label"
        , contents = [ Label.label [] [ icon [] "fas fa-envelope", text "23" ] ]
        }
    , example
        { title = "Icon"
        , description = "A label can include an icon"
        , contents =
            [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
            , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
            , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
            , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
            ]
        }
    , example
        { title = ""
        , description = ""
        , contents =
            [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
            , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
            , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
            , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
            ]
        }
    , example
        { title = ""
        , description = ""
        , contents =
            [ Label.label [] [ icon [] "fas fa-envelope" ]
            , Label.label [] [ icon [] "fas fa-dog" ]
            , Label.label [] [ icon [] "fas fa-cat" ]
            ]
        }
    , example
        { title = "Basic"
        , description = "A label can reduce its complexity"
        , contents = [ basicLabel [] [ text "Basic" ] ]
        }
    , example
        { title = "Colored"
        , description = "A label can have different colors"
        , contents =
            [ primaryLabel [] [ text "Primary" ]
            , secondaryLabel [] [ text "Secondary" ]
            , redLabel [] [ text "Red" ]
            , orangeLabel [] [ text "Orange" ]
            , yellowLabel [] [ text "Yellow" ]
            , oliveLabel [] [ text "Olive" ]
            , greenLabel [] [ text "Green" ]
            , tealLabel [] [ text "Teal" ]
            , blueLabel [] [ text "Blue" ]
            , violetLabel [] [ text "Violet" ]
            , purpleLabel [] [ text "Purple" ]
            , pinkLabel [] [ text "Pink" ]
            , brownLabel [] [ text "Brown" ]
            , greyLabel [] [ text "Grey" ]
            , blackLabel [] [ text "Black" ]
            ]
        }
    ]


examplesForPlaceholder : List (Html msg)
examplesForPlaceholder =
    [ example
        { title = "Lines"
        , description = "A placeholder can contain have lines of text"
        , contents =
            [ placeholder []
                [ line [] []
                , line [] []
                , line [] []
                , line [] []
                , line [] []
                ]
            ]
        }
    ]


examplesForRail : { inverted : Bool } -> List (Html msg)
examplesForRail options =
    [ example
        { title = "Rail"
        , description = "A rail can be presented on the left or right side of a container"
        , contents =
            [ segment options
                [ css [ width (pct 45), left (pct 27.5) ] ]
                [ leftRail []
                    [ segment options [] [ text "Left Rail Content" ] ]
                , rightRail []
                    [ segment options [] [ text "Right Rail Content" ] ]
                , wireframeParagraph
                , wireframeParagraph
                ]
            ]
        }
    ]


examplesForSegment : { inverted : Bool } -> List (Html msg)
examplesForSegment options =
    [ example
        { title = "Segment"
        , description = "A segment of content"
        , contents = [ segment options [] [ wireframeShortParagraph ] ]
        }
    , example
        { title = "Vertical Segment"
        , description = "A vertical segment formats content to be aligned as part of a vertical group"
        , contents =
            [ verticalSegment options [] [ wireframeShortParagraph ]
            , verticalSegment options [] [ wireframeShortParagraph ]
            , verticalSegment options [] [ wireframeShortParagraph ]
            ]
        }
    , example
        { title = "Disabled"
        , description = "A segment may show its content is disabled"
        , contents = [ disabledSegment options [] [ wireframeShortParagraph ] ]
        }
    , example
        { title = "Inverted"
        , description = "A segment can have its colors inverted for contrast"
        , contents =
            [ invertedSegment []
                [ p [] [ text "I'm here to tell you something, and you will probably read me first." ] ]
            ]
        }
    , example
        { title = "Padded"
        , description = "A segment can increase its padding"
        , contents = [ paddedSegment options [] [ wireframeShortParagraph ] ]
        }
    , example
        { title = ""
        , description = ""
        , contents = [ veryPaddedSegment options [] [ wireframeShortParagraph ] ]
        }
    , example
        { title = "Basic"
        , description = "A basic segment has no special formatting"
        , contents =
            [ basicSegment options
                []
                [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
            ]
        }
    ]


examplesForText : { inverted : Bool } -> List (Html msg)
examplesForText options =
    [ example
        { title = "Text"
        , description = "A text is always used inline and uses one color from the FUI color palette"
        , contents =
            [ segment options
                []
                [ text "This is "
                , redText options "red"
                , text " inline text and this is "
                , blueText options "blue"
                , text " inline text and this is "
                , purpleText options "purple"
                , text " inline text"
                ]
            , segment options
                []
                [ text "This is "
                , infoText "info"
                , text " inline text and this is "
                , successText "success"
                , text " inline text and this is "
                , warningText "warning"
                , text " inline text and this is "
                , errorText "error"
                , text " inline text"
                ]
            ]
        }
    , example
        { title = "Size"
        , description = "Text can vary in the same sizes as icons"
        , contents =
            [ segment options
                []
                [ p [] [ text "Starting with ", miniText "mini", text " text" ]
                , p [] [ text "which turns into ", tinyText "tiny", text " text" ]
                , p [] [ text "changing to ", smallText "small", text " text until it is" ]
                , p [] [ text "the default ", mediumText "medium", text " text" ]
                , p [] [ text "and could be ", largeText "large", text " text" ]
                , p [] [ text "to turn into ", bigText "big", text " text" ]
                , p [] [ text "then growing to ", hugeText "huge", text " text" ]
                , p [] [ text "to finally become ", massiveText "massive", text " text" ]
                ]
            ]
        }
    ]


examplesForBreadcrumb : { inverted : Bool } -> List (Html msg)
examplesForBreadcrumb { inverted } =
    [ example
        { title = "Breadcrumb"
        , description = "A standard breadcrumb"
        , contents =
            [ breadcrumb { divider = text "/", inverted = inverted }
                [ section [] [ text "Home" ]
                , section [] [ text "Store" ]
                , activeSection [] [ text "T-Shirt" ]
                ]
            ]
        }
    , example
        { title = ""
        , description = ""
        , contents =
            [ breadcrumb { divider = icon [] "fas fa-angle-right", inverted = inverted }
                [ section [] [ text "Home" ]
                , section [] [ text "Store" ]
                , activeSection [] [ text "T-Shirt" ]
                ]
            ]
        }
    , example
        { title = "Divider"
        , description = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
        , contents =
            [ breadcrumb { divider = text "/", inverted = inverted }
                [ section [] [ text "Home" ]
                , section [] [ text "Registration" ]
                , activeSection [] [ text "Personal Information" ]
                ]
            ]
        }
    , example
        { title = "Active"
        , description = "A section can be active"
        , contents =
            [ breadcrumb { divider = text "/", inverted = inverted }
                [ section [] [ text "Products" ]
                , activeSection [] [ text "Paper Towels" ]
                ]
            ]
        }
    , example
        { title = "Inverted"
        , description = "A breadcrumb can be inverted"
        , contents =
            [ segment { inverted = True }
                []
                [ breadcrumb { divider = text "/", inverted = True }
                    [ section [] [ text "Home" ]
                    , section [] [ text "Registration" ]
                    , activeSection [] [ text "Personal Information" ]
                    ]
                ]
            ]
        }
    ]


examplesForGrid : List (Html msg)
examplesForGrid =
    [ example
        { title = "Grids"
        , description = """A grid is a structure with a long history used to align negative space in designs.
Using a grid makes content appear to flow more naturally on your page."""
        , contents =
            [ let
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
              grid
                [ css
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
                ]
                [ fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                ]
            ]
        }
    ]


examplesForMenu : Model -> List (Html msg)
examplesForMenu model =
    [ example
        { title = "Secondary Menu"
        , description = "A menu can adjust its appearance to de-emphasize its contents"
        , contents =
            [ secondaryMenu { inverted = False } [] <|
                [ secondaryMenuActiveItem [] [ text "Home" ]
                , secondaryMenuItem [] [] [ text "Messages" ]
                , secondaryMenuItem [] [] [ text "Friends" ]
                , rightMenu []
                    [ secondaryMenuItem [] [] <|
                        [ Input.input []
                            [ input [ type_ "text", Attributes.placeholder "Search..." ] [] ]
                        ]
                    , secondaryMenuItem [] [] [ text "Logout" ]
                    ]
                ]
            ]
        }
    , example
        { title = "Vertical Menu"
        , description = "A vertical menu displays elements vertically.."
        , contents =
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
        }
    , example
        { title = "Link Item"
        , description = "A menu may contain a link item, or an item formatted as if it is a link."
        , contents =
            [ verticalMenu { inverted = model.darkMode, additionalStyles = [] } [] <|
                [ verticalMenuLinkItem { inverted = model.darkMode, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
                , verticalMenuLinkItem { inverted = model.darkMode, additionalStyles = [] } [] [ text "Javascript Link" ]
                ]
            ]
        }
    , example
        { title = "Inverted"
        , description = "A menu may have its colors inverted to show greater contrast"
        , contents =
            [ Menu.menu { inverted = True } [] <|
                [ linkItem { inverted = True } [] [ text "Home" ]
                , linkItem { inverted = True } [] [ text "Messages" ]
                , linkItem { inverted = True } [] [ text "Friends" ]
                ]
            ]
        }
    , example
        { title = ""
        , description = ""
        , contents =
            [ invertedSegment []
                [ secondaryMenu { inverted = False } [] <|
                    [ linkItem { inverted = True } [] [ text "Home" ]
                    , linkItem { inverted = True } [] [ text "Messages" ]
                    , linkItem { inverted = True } [] [ text "Friends" ]
                    ]
                ]
            ]
        }
    ]


examplesForMessage : { inverted : Bool } -> List (Html msg)
examplesForMessage options =
    [ example
        { title = "Message"
        , description = "A basic message"
        , contents =
            [ message []
                [ div []
                    [ Header.header options [] [ text "Changes in Service" ]
                    , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                    ]
                ]
            ]
        }
    , example
        { title = "Icon Message"
        , description = "A message can contain an icon."
        , contents =
            [ message []
                [ icon [] "fas fa-inbox"
                , div []
                    [ Header.header options [] [ text "Have you heard about our mailing list?" ]
                    , p [] [ text "Get the best news in your e-mail every day." ]
                    ]
                ]
            ]
        }
    ]


examplesForTable : List (Html msg)
examplesForTable =
    [ example
        { title = "Table"
        , description = "A standard table"
        , contents =
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
        }
    , example
        { title = "Striped"
        , description = "A table can stripe alternate rows of content with a darker color to increase contrast"
        , contents =
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
        }
    , example
        { title = "Basic"
        , description = "A table can reduce its complexity to increase readability."
        , contents =
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
        }
    , example
        { title = ""
        , description = ""
        , contents =
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
        }
    ]


examplesForCard : { inverted : Bool } -> List (Html msg)
examplesForCard options =
    [ example
        { title = "Card"
        , description = "A single card."
        , contents =
            [ card options
                []
                [ image [ src "./static/images/avatar/kristy.png" ] []
                , Card.content options
                    []
                    { header = [ text "Kristy" ]
                    , meta = [ text "Joined in 2013" ]
                    , description = [ text "Kristy is an art director living in New York." ]
                    }
                , extraContent options
                    []
                    [ icon [] "fas fa-user"
                    , text "22 Friends"
                    ]
                ]
            ]
        }
    , example
        { title = "Cards"
        , description = "A group of cards."
        , contents =
            [ cards [] <|
                List.map
                    (\{ name, type_, description_, friends, imageUrl } ->
                        card options
                            []
                            [ image [ src imageUrl ] []
                            , Card.content options
                                []
                                { header = [ text name ]
                                , meta = [ text type_ ]
                                , description = [ text description_ ]
                                }
                            , extraContent options
                                []
                                [ icon [] "fas fa-user"
                                , text (String.fromInt friends ++ " Friends")
                                ]
                            ]
                    )
                    [ { name = "Matt Giampietro"
                      , type_ = "Friends"
                      , description_ = "Matthew is an interior designer living in New York."
                      , friends = 75
                      , imageUrl = "./static/images/avatar/matthew.png"
                      }
                    , { name = "Molly"
                      , type_ = "Coworker"
                      , description_ = "Molly is a personal assistant living in Paris."
                      , friends = 35
                      , imageUrl = "./static/images/avatar/molly.png"
                      }
                    , { name = "Elyse"
                      , type_ = "Coworker"
                      , description_ = "Elyse is a copywriter working in New York."
                      , friends = 151
                      , imageUrl = "./static/images/avatar/elyse.png"
                      }
                    ]
            ]
        }
    , example
        { title = "Header"
        , description = "A card can contain a header"
        , contents =
            [ cards [] <|
                List.map
                    (\person ->
                        card options
                            []
                            [ Card.content options
                                []
                                { header = [ text person.name ]
                                , meta = [ text person.type_ ]
                                , description = [ text person.description ]
                                }
                            ]
                    )
                    [ { name = "Elliot Fu"
                      , type_ = "Friend"
                      , description = "Elliot Fu is a film-maker from New York."
                      }
                    , { name = "Veronika Ossi"
                      , type_ = "Friend"
                      , description = "Veronika Ossi is a set designer living in New York who enjoys kittens, music, and partying."
                      }
                    , { name = "Jenny Hess"
                      , type_ = "Friend"
                      , description = "Jenny is a student studying Media Management at the New School"
                      }
                    ]
            ]
        }
    , example
        { title = "Metadata"
        , description = "A card can contain content metadata"
        , contents =
            [ card options
                []
                [ Card.content options
                    []
                    { header = [ text "Cute Dog" ]
                    , meta =
                        [ text "2 days ago "
                        , a [] [ text "Animals" ]
                        ]
                    , description = [ wireframeParagraph ]
                    }
                ]
            ]
        }
    , example
        { title = "Description"
        , description = "A card can contain a description with one or more paragraphs"
        , contents =
            [ card options
                []
                [ Card.content options
                    []
                    { header = [ text "Cute Dog" ]
                    , meta = [ text "2 days ago " ]
                    , description =
                        [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                        , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                        ]
                    }
                ]
            ]
        }
    , example
        { title = "Extra Content"
        , description = "A card can contain extra content meant to be formatted separately from the main content"
        , contents =
            [ card options
                []
                [ Card.content options
                    []
                    { header = [ text "Cute Dog" ]
                    , meta = [ text "2 days ago " ]
                    , description =
                        [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                        , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                        ]
                    }
                , extraContent options
                    []
                    [ icon [] "fas fa-check"
                    , text "121 Votes"
                    ]
                ]
            ]
        }
    ]


examplesForItem : List (Html msg)
examplesForItem =
    [ example
        { title = "Metadata"
        , description = "An item can contain content metadata"
        , contents =
            [ items [] <|
                List.repeat 2
                    (Item.item []
                        [ image [ src "./static/images/wireframe/image.png" ] []
                        , Item.content []
                            { header = [ text "Header" ]
                            , meta = [ span [] [ text "Description" ] ]
                            , description = [ wireframeShortParagraph ]
                            , extra = [ text "Additional Details" ]
                            }
                        ]
                    )
            ]
        }
    , example
        { title = "Image"
        , description = "An item can contain an image"
        , contents =
            [ dividedItems [] <|
                List.repeat 3
                    (Item.item []
                        [ image [ src "./static/images/wireframe/image.png" ] [] ]
                    )
            ]
        }
    , example
        { title = "Content"
        , description = "An item can contain content"
        , contents =
            [ dividedItems [] <|
                List.map
                    (\{ content } ->
                        Item.item []
                            [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                            , middleAlignedContent [] [ text content ]
                            ]
                    )
                    [ { content = "Content A" }
                    , { content = "Content B" }
                    , { content = "Content C" }
                    ]
            ]
        }
    , example
        { title = "Header"
        , description = "An item can contain a header"
        , contents =
            [ items [] <|
                List.map
                    (\{ title } ->
                        Item.item []
                            [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                            , middleAlignedContent [] [ Item.header [] [ text title ] ]
                            ]
                    )
                    [ { title = "12 Years a Slave" }
                    , { title = "My Neighbor Totoro" }
                    , { title = "Watchmen" }
                    ]
            ]
        }
    , example
        { title = "Metadata"
        , description = "An item can contain content metadata"
        , contents =
            [ items [] <|
                List.map
                    (\plan ->
                        Item.item []
                            [ smallImage [ src "./static/images/wireframe/image.png" ] []
                            , Item.content []
                                { header = [ text plan.title ]
                                , meta =
                                    [ span [] [ text plan.price ]
                                    , span [] [ text plan.stay ]
                                    ]
                                , description = [ wireframeShortParagraph ]
                                , extra = []
                                }
                            ]
                    )
                    [ { title = "Arrowhead Valley Camp"
                      , price = "$1200"
                      , stay = "1 Month"
                      }
                    , { title = "Buck's Homebrew Stayaway"
                      , price = "$1000"
                      , stay = "2 Weeks"
                      }
                    , { title = "Astrology Camp"
                      , price = "$1600"
                      , stay = "6 Weeks"
                      }
                    ]
            ]
        }
    , example
        { title = "Description"
        , description = "An item can contain a description with a single or multiple paragraphs"
        , contents =
            [ items []
                [ Item.item []
                    [ smallImage [ src "./static/images/wireframe/image.png" ] []
                    , Item.content []
                        { header = [ text "Cute Dog" ]
                        , meta = []
                        , description =
                            [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                            , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                            ]
                        , extra = []
                        }
                    ]
                ]
            ]
        }
    , example
        { title = "Extra Content"
        , description = "An item can contain extra content meant to be formatted separately from the main content"
        , contents =
            [ items []
                [ Item.item []
                    [ Item.content []
                        { header = [ text "Cute Dog" ]
                        , meta = []
                        , description =
                            [ wireframeShortParagraph
                            , wireframeShortParagraph
                            ]
                        , extra =
                            [ icon [] "fas fa-check"
                            , text "121 Votes"
                            ]
                        }
                    ]
                ]
            ]
        }
    ]


examplesForAccordion : { inverted : Bool } -> List (Html Msg)
examplesForAccordion options =
    let
        items =
            [ { title = "What is a dog?"
              , contents = [ "A dog is a type of domesticated animal. Known for its loyalty and faithfulness, it can be found as a welcome guest in many households across the world." ]
              }
            , { title = "What kinds of dogs are there?"
              , contents = [ "There are many breeds of dogs. Each breed varies in size and temperament. Owners often select a breed of dog that they find to be compatible with their own lifestyle and desires from a companion." ]
              }
            , { title = "How do you acquire a dog?"
              , contents =
                    [ "Three common ways for a prospective owner to acquire a dog is from pet shops, private owners, or shelters."
                    , "A pet shop may be the most convenient way to buy a dog. Buying a dog from a private owner allows you to assess the pedigree and upbringing of your dog before choosing to take it home. Lastly, finding your dog from a shelter, helps give a good home to a dog who may not find one so readily."
                    ]
              }
            ]
                |> List.map
                    (\{ title, contents } ->
                        { title = [ text title ]
                        , content = List.map (\c -> p [] [ text c ]) contents
                        }
                    )
    in
    [ example
        { title = "Accordion"
        , description = "A standard accordion"
        , contents = [ Accordion.accordion options [] items ]
        }
    , example
        { title = "Inverted"
        , description = "An accordion can be formatted to appear on dark backgrounds"
        , contents =
            [ segment { inverted = True }
                []
                [ Accordion.accordion { inverted = True } [] items ]
            ]
        }
    ]


examplesForCheckbox : List (Html msg)
examplesForCheckbox =
    [ example
        { title = "Checkbox"
        , description = "A checkbox allows a user to select a value from a small set of options, often binary"
        , contents =
            [ checkbox []
                [ input [ id "checkbox_example", type_ "checkbox" ] []
                , Checkbox.label [ for "checkbox_example" ] [ text "Make my profile visible" ]
                ]
            ]
        }
    ]


examplesForDimmer : { a | toggledItems : List String, darkMode : Bool } -> List (Html Msg)
examplesForDimmer { toggledItems, darkMode } =
    let
        options =
            { inverted = darkMode }
    in
    [ example
        { title = "Dimmer"
        , description = "A simple dimmer displays no content"
        , contents =
            [ segment options
                []
                [ Header.header options [] [ text "Overlayable Section" ]
                , div [] <|
                    List.repeat 1 (smallImage [ src "./static/images/wireframe/image.png" ] [])
                , wireframeMediaParagraph
                , dimmer (List.member "dimmer" toggledItems) [ onClick (Toggle "dimmer") ] []
                ]
            , button [ onClick (Toggle "dimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
            ]
        }
    , example
        { title = "Content Dimmer"
        , description = "A dimmer can display content"
        , contents =
            [ segment options
                []
                [ Header.header options [] [ text "Overlayable Section" ]
                , div [] <|
                    List.repeat 1 (smallImage [ src "./static/images/wireframe/image.png" ] [])
                , wireframeMediaParagraph
                , dimmer (List.member "contentDimmer" toggledItems)
                    [ onClick (Toggle "contentDimmer") ]
                    [ Dimmer.content []
                        [ iconHeader { inverted = True }
                            []
                            [ icon [] "fas fa-heart", text "Dimmed Message!" ]
                        ]
                    ]
                ]
            , button [ onClick (Toggle "contentDimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
            ]
        }
    , example
        { title = "Page Dimmer"
        , description = "A dimmer can be formatted to be fixed to the page"
        , contents =
            [ button [ onClick (Toggle "pageDimmer") ] [ icon [] "fas fa-plus", text "Show" ]
            , pageDimmer (List.member "pageDimmer" toggledItems)
                [ onClick (Toggle "pageDimmer") ]
                [ iconHeader { inverted = True }
                    []
                    [ icon [] "fas fa-envelope"
                    , text "Dimmer Message"
                    , subHeader { inverted = True }
                        []
                        [ text "Dimmer sub-header" ]
                    ]
                ]
            ]
        }
    ]


examplesForModal : { a | toggledItems : List String, darkMode : Bool } -> List (Html Msg)
examplesForModal { toggledItems, darkMode } =
    let
        options =
            { inverted = darkMode }
    in
    [ example
        { title = "Modal"
        , description = "A standard modal"
        , contents =
            [ button [ onClick (Toggle "modal") ] [ icon [] "fas fa-plus", text "Show" ]
            , pageDimmer (List.member "modal" toggledItems)
                [ onClick (Toggle "modal") ]
                [ modal options
                    []
                    { header = [ text "Select a Photo" ]
                    , content =
                        [ Modal.description []
                            [ p []
                                [ text "We've found the following "
                                , a [ href "https://www.gravatar.com", Attributes.target "_blank" ] [ text "gravatar" ]
                                , text " image associated with your e-mail address."
                                ]
                            , p [] [ text "Is it okay to use this photo?" ]
                            ]
                        ]
                    , actions =
                        [ blackButton [] [ text "Nope" ]
                        , greenButton [] [ text "Yep, that's me" ]
                        ]
                    }
                ]
            ]
        }
    , example
        { title = "Basic"
        , description = "A modal can reduce its complexity"
        , contents =
            [ button [ onClick (Toggle "basicModal") ] [ icon [] "fas fa-plus", text "Show" ]
            , pageDimmer (List.member "basicModal" toggledItems)
                [ onClick (Toggle "basicModal") ]
                [ basicModal []
                    { header = [ text "Archive Old Messages" ]
                    , content =
                        [ Modal.description []
                            [ p [] [ text "Your inbox is getting full, would you like us to enable automatic archiving of old messages?" ] ]
                        ]
                    , actions =
                        [ redButton [] [ text "No" ]
                        , greenButton [] [ text "Yes" ]
                        ]
                    }
                    []
                ]
            ]
        }
    ]


examplesForSortableTable : Model -> List (Html Msg)
examplesForSortableTable { people, tableState, query } =
    [ example
        { title = "Sortable Table"
        , description = ""
        , contents =
            let
                config =
                    Table.config
                        { toId = .name
                        , toMsg = SetTableState
                        , columns =
                            [ Table.stringColumn "Name" .name
                            , Table.intColumn "Year" .year
                            , Table.stringColumn "City" .city
                            , Table.stringColumn "State" .state
                            ]
                        }

                lowerQuery =
                    String.toLower query

                acceptablePeople =
                    List.filter (String.contains lowerQuery << String.toLower << .name) people
            in
            [ input [ Attributes.placeholder "Search by Name", onInput SetQuery ] []
            , Table.view config tableState acceptablePeople
            ]
        }
    ]


type alias Person =
    { name : String
    , year : Int
    , city : String
    , state : String
    }


presidents : List Person
presidents =
    [ Person "George Washington" 1732 "Westmoreland County" "Virginia"
    , Person "John Adams" 1735 "Braintree" "Massachusetts"
    , Person "Thomas Jefferson" 1743 "Shadwell" "Virginia"
    , Person "James Madison" 1751 "Port Conway" "Virginia"
    , Person "James Monroe" 1758 "Monroe Hall" "Virginia"
    , Person "Andrew Jackson" 1767 "Waxhaws Region" "South/North Carolina"
    , Person "John Quincy Adams" 1767 "Braintree" "Massachusetts"
    , Person "William Henry Harrison" 1773 "Charles City County" "Virginia"
    , Person "Martin Van Buren" 1782 "Kinderhook" "New York"
    , Person "Zachary Taylor" 1784 "Barboursville" "Virginia"
    , Person "John Tyler" 1790 "Charles City County" "Virginia"
    , Person "James Buchanan" 1791 "Cove Gap" "Pennsylvania"
    , Person "James K. Polk" 1795 "Pineville" "North Carolina"
    , Person "Millard Fillmore" 1800 "Summerhill" "New York"
    , Person "Franklin Pierce" 1804 "Hillsborough" "New Hampshire"
    , Person "Andrew Johnson" 1808 "Raleigh" "North Carolina"
    , Person "Abraham Lincoln" 1809 "Sinking spring" "Kentucky"
    , Person "Ulysses S. Grant" 1822 "Point Pleasant" "Ohio"
    , Person "Rutherford B. Hayes" 1822 "Delaware" "Ohio"
    , Person "Chester A. Arthur" 1829 "Fairfield" "Vermont"
    , Person "James A. Garfield" 1831 "Moreland Hills" "Ohio"
    , Person "Benjamin Harrison" 1833 "North Bend" "Ohio"
    , Person "Grover Cleveland" 1837 "Caldwell" "New Jersey"
    , Person "William McKinley" 1843 "Niles" "Ohio"
    , Person "Woodrow Wilson" 1856 "Staunton" "Virginia"
    , Person "William Howard Taft" 1857 "Cincinnati" "Ohio"
    , Person "Theodore Roosevelt" 1858 "New York City" "New York"
    , Person "Warren G. Harding" 1865 "Blooming Grove" "Ohio"
    , Person "Calvin Coolidge" 1872 "Plymouth" "Vermont"
    , Person "Herbert Hoover" 1874 "West Branch" "Iowa"
    , Person "Franklin D. Roosevelt" 1882 "Hyde Park" "New York"
    , Person "Harry S. Truman" 1884 "Lamar" "Missouri"
    , Person "Dwight D. Eisenhower" 1890 "Denison" "Texas"
    , Person "Lyndon B. Johnson" 1908 "Stonewall" "Texas"
    , Person "Ronald Reagan" 1911 "Tampico" "Illinois"
    , Person "Richard M. Nixon" 1913 "Yorba Linda" "California"
    , Person "Gerald R. Ford" 1913 "Omaha" "Nebraska"
    , Person "John F. Kennedy" 1917 "Brookline" "Massachusetts"
    , Person "George H. W. Bush" 1924 "Milton" "Massachusetts"
    , Person "Jimmy Carter" 1924 "Plains" "Georgia"
    , Person "George W. Bush" 1946 "New Haven" "Connecticut"
    , Person "Bill Clinton" 1946 "Hope" "Arkansas"
    , Person "Barack Obama" 1961 "Honolulu" "Hawaii"
    , Person "Donald Trump" 1946 "New York City" "New York"
    ]
