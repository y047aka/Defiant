module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document)
import Browser.Navigation as Nav exposing (Key)
import Css exposing (..)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Html.Styled exposing (Attribute, Html, a, br, div, h1, h2, h3, h4, h5, input, p, span, strong, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (css, for, href, id, rel, src, type_)
import Html.Styled.Events exposing (onClick)
import Maybe.Extra
import UI.Breadcrumb as Breadcrumb exposing (..)
import UI.Button exposing (..)
import UI.Card as Card exposing (..)
import UI.Checkbox as Checkbox exposing (..)
import UI.Container exposing (..)
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
    | CheckboxPage
    | ModalPage


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    routing url
        { key = key
        , page = TopPage
        , darkMode = False
        , count = 0
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
    | Checkbox
    | Modal


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
        , Parser.map Checkbox (s "checkbox")
        , Parser.map Modal (s "modal")
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

            Just Checkbox ->
                CheckboxPage

            Just Modal ->
                ModalPage



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
    | ToggleDarkMode
    | Increment
    | Decrement


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



-- VIEW


view : Model -> Document Msg
view model =
    let
        document { title, breadcrumbItems, contents } =
            { title = Maybe.withDefault "" title ++ Maybe.Extra.unwrap "Defiant" (\_ -> " | Defiant") title
            , body =
                [ toUnstyled <|
                    div []
                        [ global (normalize ++ additionalReset ++ globalCustomize ++ fontAwesome)
                        , basicSegment { inverted = False }
                            []
                            [ container []
                                [ breadcrumbItems
                                    |> List.indexedMap (breadcrumbItem <| List.length breadcrumbItems)
                                    |> List.intersperse (Breadcrumb.divider [] [ text "/" ])
                                    |> breadcrumb
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
                { title = Just "Not Found"
                , breadcrumbItems = [ "Top", "Not Found" ]
                , contents = []
                }

            TopPage ->
                { title = Nothing
                , breadcrumbItems = [ "Top" ]
                , contents = tableOfContents model.darkMode
                }

            SitePage ->
                { title = Just "Site"
                , breadcrumbItems = [ "Top", "Site" ]
                , contents = examplesForSite
                }

            ButtonPage ->
                { title = Just "Button"
                , breadcrumbItems = [ "Top", "Button" ]
                , contents = examplesForButton model
                }

            ContainerPage ->
                { title = Just "Container"
                , breadcrumbItems = [ "Top", "Container" ]
                , contents = examplesForContainer
                }

            DividerPage ->
                { title = Just "Divider"
                , breadcrumbItems = [ "Top", "Divider" ]
                , contents = examplesForDivider
                }

            HeaderPage ->
                { title = Just "Header"
                , breadcrumbItems = [ "Top", "Header" ]
                , contents = examplesForHeader
                }

            IconPage ->
                { title = Just "Icon"
                , breadcrumbItems = [ "Top", "Icon" ]
                , contents = examplesForIcon
                }

            ImagePage ->
                { title = Just "Image"
                , breadcrumbItems = [ "Top", "Image" ]
                , contents = examplesForImage
                }

            InputPage ->
                { title = Just "Input"
                , breadcrumbItems = [ "Top", "Input" ]
                , contents = examplesForInput
                }

            LabelPage ->
                { title = Just "Label"
                , breadcrumbItems = [ "Top", "Label" ]
                , contents = examplesForLabel
                }

            PlaceholderPage ->
                { title = Just "Placeholder"
                , breadcrumbItems = [ "Top", "Placeholder" ]
                , contents = examplesForPlaceholder
                }

            RailPage ->
                { title = Just "Rail"
                , breadcrumbItems = [ "Top", "Rail" ]
                , contents = examplesForRail model.darkMode
                }

            SegmentPage ->
                { title = Just "Segment"
                , breadcrumbItems = [ "Top", "Segment" ]
                , contents = examplesForSegment model.darkMode
                }

            TextPage ->
                { title = Just "Text"
                , breadcrumbItems = [ "Top", "Text" ]
                , contents = examplesForText model.darkMode
                }

            BreadcrumbPage ->
                { title = Just "Breadcrumb"
                , breadcrumbItems = [ "Top", "Breadcrumb" ]
                , contents = examplesForBreadcrumb
                }

            GridPage ->
                { title = Just "Grid"
                , breadcrumbItems = [ "Top", "Grid" ]
                , contents = examplesForGrid
                }

            MenuPage ->
                { title = Just "Menu"
                , breadcrumbItems = [ "Top", "Menu" ]
                , contents = examplesForMenu model
                }

            MessagePage ->
                { title = Just "Message"
                , breadcrumbItems = [ "Top", "Message" ]
                , contents = examplesForMessage
                }

            TablePage ->
                { title = Just "Table"
                , breadcrumbItems = [ "Top", "Table" ]
                , contents = examplesForTable
                }

            CardPage ->
                { title = Just "Card"
                , breadcrumbItems = [ "Top", "Card" ]
                , contents = examplesForCard model.darkMode
                }

            ItemPage ->
                { title = Just "Item"
                , breadcrumbItems = [ "Top", "Item" ]
                , contents = examplesForItem
                }

            CheckboxPage ->
                { title = Just "Checkbox"
                , breadcrumbItems = [ "Top", "Checkbox" ]
                , contents = examplesForCheckbox
                }

            ModalPage ->
                { title = Just "Modal"
                , breadcrumbItems = [ "Top", "Modal" ]
                , contents = examplesForModal model.darkMode
                }


tableOfContents : Bool -> List (Html msg)
tableOfContents darkMode =
    [ cards [] <|
        List.map
            (\{ label, description, category, url } ->
                card { inverted = darkMode }
                    []
                    [ a [ href url ]
                        [ Card.content { inverted = darkMode }
                            []
                            [ Card.header { inverted = darkMode } [] [ text label ]
                            , Card.meta { inverted = darkMode } [] [ text category ]
                            , Card.description { inverted = darkMode } [] [ text description ]
                            ]
                        ]
                    ]
            )
            contents_
    ]


contents_ : List { label : String, description : String, category : String, url : String }
contents_ =
    [ { label = "Site"
      , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
      , category = "Globals"
      , url = "/site"
      }
    , { label = "Button"
      , description = "A button indicates a possible user action"
      , category = "Elements"
      , url = "/button"
      }
    , { label = "Container"
      , description = "A container limits content to a maximum width"
      , category = "Elements"
      , url = "/container"
      }
    , { label = "Divider"
      , description = "A divider visually segments content into groups"
      , category = "Elements"
      , url = "/divider"
      }
    , { label = "Header"
      , description = "A header provides a short summary of content"
      , category = "Elements"
      , url = "/header"
      }
    , { label = "Icon"
      , description = "An icon is a glyph used to represent something else"
      , category = "Elements"
      , url = "/icon"
      }
    , { label = "Image"
      , description = "An image is a graphic representation of something"
      , category = "Elements"
      , url = "/image"
      }
    , { label = "Input"
      , description = "An input is a field used to elicit a response from a user"
      , category = "Elements"
      , url = "/input"
      }
    , { label = "Label"
      , description = "A label displays content classification"
      , category = "Elements"
      , url = "/label"
      }
    , { label = "Placeholder"
      , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
      , category = "Elements"
      , url = "/placeholder"
      }
    , { label = "Rail"
      , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
      , category = "Elements"
      , url = "/rail"
      }
    , { label = "Segment"
      , description = "A segment is used to create a grouping of related content"
      , category = "Elements"
      , url = "/segment"
      }
    , { label = "Text"
      , description = "A text is used to style some inline text with a simple color"
      , category = "Elements"
      , url = "/text"
      }
    , { label = "Breadcrumb"
      , description = "A breadcrumb is used to show hierarchy between content"
      , category = "Collections"
      , url = "/breadcrumb"
      }
    , { label = "Grid"
      , description = "A grid is used to harmonize negative space in a layout"
      , category = "Collections"
      , url = "/grid"
      }
    , { label = "Menu"
      , description = "A menu displays grouped navigation actions"
      , category = "Collections"
      , url = "/menu"
      }
    , { label = "Message"
      , description = "A message displays information that explains nearby content"
      , category = "Collections"
      , url = "/message"
      }
    , { label = "Table"
      , description = "A table displays a collections of data grouped into rows"
      , category = "Collections"
      , url = "/table"
      }
    , { label = "Card"
      , description = "A card displays site content in a manner similar to a playing card"
      , category = "Views"
      , url = "/card"
      }
    , { label = "Item"
      , description = "An item view presents large collections of site content for display"
      , category = "Views"
      , url = "/item"
      }
    , { label = "Checkbox"
      , description = "A checkbox allows a user to select a value from a small set of options, often binary"
      , category = "Modules"
      , url = "/checkbox"
      }
    , { label = "Modal"
      , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
      , category = "Modules"
      , url = "/modal"
      }
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


examplesForHeader : List (Html msg)
examplesForHeader =
    [ example
        { title = "Content Headers"
        , description = "Headers may be oriented to give the importance of a section in the context of the content that surrounds it"
        , contents =
            [ massiveHeader [] [ text "Massive Header" ]
            , wireframeShortParagraph
            , hugeHeader [] [ text "Huge Header" ]
            , wireframeShortParagraph
            , bigHeader [] [ text "Big Header" ]
            , wireframeShortParagraph
            , largeHeader [] [ text "Large Header" ]
            , wireframeShortParagraph
            , mediumHeader [] [ text "Medium Header" ]
            , wireframeShortParagraph
            , smallHeader [] [ text "Small Header" ]
            , wireframeShortParagraph
            , tinyHeader [] [ text "Tiny Header" ]
            , wireframeShortParagraph
            , miniHeader [] [ text "Mini Header" ]
            , wireframeShortParagraph
            ]
        }
    , example
        { title = "Icon Headers"
        , description = "A header can be formatted to emphasize an icon"
        , contents =
            [ iconHeader []
                [ icon [] "fas fa-cogs"
                , iconHeaderContent []
                    [ text "Account Settings"
                    , subHeader [] [ text "Manage your account settings and set e-mail preferences." ]
                    ]
                ]
            ]
        }
    , example
        { title = "Subheader"
        , description = "Headers may contain subheaders"
        , contents =
            [ Header.header []
                [ text "Account Settings"
                , subHeader [] [ text "Manage your account settings and set e-mail preferences." ]
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


examplesForRail : Bool -> List (Html msg)
examplesForRail darkMode =
    [ example
        { title = "Rail"
        , description = "A rail can be presented on the left or right side of a container"
        , contents =
            [ segment { inverted = darkMode }
                [ css [ width (pct 45), left (pct 27.5) ] ]
                [ leftRail []
                    [ segment { inverted = darkMode } [] [ text "Left Rail Content" ] ]
                , rightRail []
                    [ segment { inverted = darkMode } [] [ text "Right Rail Content" ] ]
                , wireframeParagraph
                , wireframeParagraph
                ]
            ]
        }
    ]


examplesForSegment : Bool -> List (Html msg)
examplesForSegment darkMode =
    [ example
        { title = "Segment"
        , description = "A segment of content"
        , contents = [ segment { inverted = darkMode } [] [ wireframeShortParagraph ] ]
        }
    , example
        { title = "Vertical Segment"
        , description = "A vertical segment formats content to be aligned as part of a vertical group"
        , contents =
            [ verticalSegment { inverted = darkMode } [] [ wireframeShortParagraph ]
            , verticalSegment { inverted = darkMode } [] [ wireframeShortParagraph ]
            , verticalSegment { inverted = darkMode } [] [ wireframeShortParagraph ]
            ]
        }
    , example
        { title = "Disabled"
        , description = "A segment may show its content is disabled"
        , contents = [ disabledSegment { inverted = darkMode } [] [ wireframeShortParagraph ] ]
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
        , contents = [ paddedSegment { inverted = darkMode } [] [ wireframeShortParagraph ] ]
        }
    , example
        { title = ""
        , description = ""
        , contents = [ veryPaddedSegment { inverted = darkMode } [] [ wireframeShortParagraph ] ]
        }
    , example
        { title = "Basic"
        , description = "A basic segment has no special formatting"
        , contents =
            [ basicSegment { inverted = darkMode }
                []
                [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
            ]
        }
    ]


examplesForText : Bool -> List (Html msg)
examplesForText darkMode =
    [ example
        { title = "Text"
        , description = "A text is always used inline and uses one color from the FUI color palette"
        , contents =
            [ segment { inverted = darkMode }
                []
                [ text "This is "
                , redText { inverted = darkMode } "red"
                , text " inline text and this is "
                , blueText { inverted = darkMode } "blue"
                , text " inline text and this is "
                , purpleText { inverted = darkMode } "purple"
                , text " inline text"
                ]
            , segment { inverted = darkMode }
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
            [ segment { inverted = darkMode }
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


examplesForBreadcrumb : List (Html msg)
examplesForBreadcrumb =
    [ example
        { title = "Breadcrumb"
        , description = "A standard breadcrumb"
        , contents =
            [ breadcrumb
                [ section [] [ text "Home" ]
                , Breadcrumb.divider [] [ text "/" ]
                , section [] [ text "Store" ]
                , Breadcrumb.divider [] [ text "/" ]
                , activeSection [] [ text "T-Shirt" ]
                ]
            ]
        }
    , example
        { title = ""
        , description = ""
        , contents =
            [ breadcrumb
                [ section [] [ text "Home" ]
                , Breadcrumb.divider [] [ icon [] "fas fa-angle-right" ]
                , section [] [ text "Store" ]
                , Breadcrumb.divider [] [ icon [] "fas fa-angle-right" ]
                , activeSection [] [ text "T-Shirt" ]
                ]
            ]
        }
    , example
        { title = "Divider"
        , description = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
        , contents =
            [ breadcrumb
                [ section [] [ text "Home" ]
                , Breadcrumb.divider [] [ text "/" ]
                , section [] [ text "Registration" ]
                , Breadcrumb.divider [] [ text "/" ]
                , activeSection [] [ text "Personal Information" ]
                ]
            ]
        }
    , example
        { title = "Active"
        , description = "A section can be active"
        , contents =
            [ breadcrumb
                [ section [] [ text "Products" ]
                , Breadcrumb.divider [] [ text "/" ]
                , activeSection [] [ text "Paper Towels" ]
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


examplesForMessage : List (Html msg)
examplesForMessage =
    [ example
        { title = "Message"
        , description = "A basic message"
        , contents =
            [ message []
                [ div []
                    [ Header.header [] [ text "Changes in Service" ]
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
                    [ Header.header [] [ text "Have you heard about our mailing list?" ]
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
                    [ tr []
                        [ th [] [ text "Name" ]
                        , th [] [ text "Age" ]
                        , th [] [ text "Job" ]
                        ]
                    ]
                , tbody []
                    [ tr []
                        [ td [] [ text "James" ]
                        , td [] [ text "24" ]
                        , td [] [ text "Engineer" ]
                        ]
                    , tr []
                        [ td [] [ text "Jill" ]
                        , td [] [ text "26" ]
                        , td [] [ text "Engineer" ]
                        ]
                    , tr []
                        [ td [] [ text "Elyse" ]
                        , td [] [ text "24" ]
                        , td [] [ text "Designer" ]
                        ]
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
                    [ tr []
                        [ th [] [ text "Name" ]
                        , th [] [ text "Date Joined" ]
                        , th [] [ text "E-mail" ]
                        , th [] [ text "Called" ]
                        ]
                    ]
                , tbody []
                    [ tr []
                        [ td [] [ text "John Lilki" ]
                        , td [] [ text "September 14, 2013" ]
                        , td [] [ text "jhlilk22@yahoo.com" ]
                        , td [] [ text "No" ]
                        ]
                    , tr []
                        [ td [] [ text "Jamie Harington" ]
                        , td [] [ text "January 11, 2014" ]
                        , td [] [ text "jamieharingonton@yahoo.com" ]
                        , td [] [ text "Yes" ]
                        ]
                    , tr []
                        [ td [] [ text "Jill Lewis" ]
                        , td [] [ text "May 11, 2014" ]
                        , td [] [ text "jilsewris22@yahoo.com" ]
                        , td [] [ text "Yes" ]
                        ]
                    , tr []
                        [ td [] [ text "John Lilki" ]
                        , td [] [ text "September 14, 2013" ]
                        , td [] [ text "jhlilk22@yahoo.com" ]
                        , td [] [ text "No" ]
                        ]
                    , tr []
                        [ td [] [ text "John Lilki" ]
                        , td [] [ text "September 14, 2013" ]
                        , td [] [ text "jhlilk22@yahoo.com" ]
                        , td [] [ text "No" ]
                        ]
                    , tr []
                        [ td [] [ text "Jamie Harington" ]
                        , td [] [ text "January 11, 2014" ]
                        , td [] [ text "jamieharingonton@yahoo.com" ]
                        , td [] [ text "Yes" ]
                        ]
                    , tr []
                        [ td [] [ text "Jill Lewis" ]
                        , td [] [ text "May 11, 2014" ]
                        , td [] [ text "jilsewris22@yahoo.com" ]
                        , td [] [ text "Yes" ]
                        ]
                    , tr []
                        [ td [] [ text "John Lilki" ]
                        , td [] [ text "September 14, 2013" ]
                        , td [] [ text "jhlilk22@yahoo.com" ]
                        , td [] [ text "No" ]
                        ]
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
                    [ tr []
                        [ th [] [ text "Name" ]
                        , th [] [ text "Status" ]
                        , th [] [ text "Notes" ]
                        ]
                    ]
                , tbody []
                    [ tr []
                        [ td [] [ text "John" ]
                        , td [] [ text "Approved" ]
                        , td [] [ text "None" ]
                        ]
                    , tr []
                        [ td [] [ text "Jamie" ]
                        , td [] [ text "Approved" ]
                        , td [] [ text "Requires call" ]
                        ]
                    , tr []
                        [ td [] [ text "Jill" ]
                        , td [] [ text "Denied" ]
                        , td [] [ text "None" ]
                        ]
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
                    [ tr []
                        [ th [] [ text "Name" ]
                        , th [] [ text "Status" ]
                        , th [] [ text "Notes" ]
                        ]
                    ]
                , tbody []
                    [ tr []
                        [ td [] [ text "John" ]
                        , td [] [ text "Approved" ]
                        , td [] [ text "None" ]
                        ]
                    , tr []
                        [ td [] [ text "Jamie" ]
                        , td [] [ text "Approved" ]
                        , td [] [ text "Requires call" ]
                        ]
                    , tr []
                        [ td [] [ text "Jill" ]
                        , td [] [ text "Denied" ]
                        , td [] [ text "None" ]
                        ]
                    ]
                ]
            ]
        }
    ]


examplesForCard : Bool -> List (Html msg)
examplesForCard darkMode =
    [ example
        { title = "Card"
        , description = "A single card."
        , contents =
            [ card { inverted = darkMode }
                []
                [ image [ src "./static/images/avatar/kristy.png" ] []
                , Card.content { inverted = darkMode }
                    []
                    [ Card.header { inverted = darkMode } [] [ text "Kristy" ]
                    , Card.meta { inverted = darkMode } [] [ text "Joined in 2013" ]
                    , Card.description { inverted = darkMode } [] [ text "Kristy is an art director living in New York." ]
                    ]
                , extraContent { inverted = darkMode }
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
                        card { inverted = darkMode }
                            []
                            [ image [ src imageUrl ] []
                            , Card.content { inverted = darkMode }
                                []
                                [ Card.header { inverted = darkMode } [] [ text name ]
                                , Card.meta { inverted = darkMode } [] [ text type_ ]
                                , Card.description { inverted = darkMode } [] [ text description_ ]
                                ]
                            , extraContent { inverted = darkMode }
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
                        card { inverted = darkMode }
                            []
                            [ Card.content { inverted = darkMode }
                                []
                                [ Card.header { inverted = darkMode } [] [ text person.name ]
                                , Card.meta { inverted = darkMode } [] [ text person.type_ ]
                                , Card.description { inverted = darkMode } [] [ text person.description ]
                                ]
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
            [ card { inverted = darkMode }
                []
                [ Card.content { inverted = darkMode }
                    []
                    [ Card.header { inverted = darkMode } [] [ text "Cute Dog" ]
                    , Card.meta { inverted = darkMode }
                        []
                        [ text "2 days ago "
                        , a [] [ text "Animals" ]
                        ]
                    , wireframeParagraph
                    ]
                ]
            ]
        }
    , example
        { title = "Description"
        , description = "A card can contain a description with one or more paragraphs"
        , contents =
            [ card { inverted = darkMode }
                []
                [ Card.content { inverted = darkMode }
                    []
                    [ Card.header { inverted = darkMode } [] [ text "Cute Dog" ]
                    , Card.meta { inverted = darkMode } [] [ text "2 days ago " ]
                    , Card.description { inverted = darkMode }
                        []
                        [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                        , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                        ]
                    ]
                ]
            ]
        }
    , example
        { title = "Extra Content"
        , description = "A card can contain extra content meant to be formatted separately from the main content"
        , contents =
            [ card { inverted = darkMode }
                []
                [ Card.content { inverted = darkMode }
                    []
                    [ Card.header { inverted = darkMode } [] [ text "Cute Dog" ]
                    , Card.meta { inverted = darkMode } [] [ text "2 days ago " ]
                    , Card.description { inverted = darkMode }
                        []
                        [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                        , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                        ]
                    ]
                , extraContent { inverted = darkMode }
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
                            [ Item.header [] [ text "Header" ]
                            , Item.meta []
                                [ span [] [ text "Description" ] ]
                            , Item.description [] [ wireframeShortParagraph ]
                            , extra [] [ text "Additional Details" ]
                            ]
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
                                [ Item.header [] [ text plan.title ]
                                , Item.meta []
                                    [ span [] [ text plan.price ]
                                    , span [] [ text plan.stay ]
                                    ]
                                , Item.description [] [ wireframeShortParagraph ]
                                ]
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
                        [ Item.header [] [ text "Cute Dog" ]
                        , Item.description []
                            [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                            , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                            ]
                        ]
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
                        [ Item.header [] [ text "Cute Dog" ]
                        , Item.description []
                            [ wireframeShortParagraph
                            , wireframeShortParagraph
                            ]
                        , extra []
                            [ icon [] "fas fa-check"
                            , text "121 Votes"
                            ]
                        ]
                    ]
                ]
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


examplesForModal : Bool -> List (Html msg)
examplesForModal darkMode =
    [ example
        { title = "Modal"
        , description = "A standard modal"
        , contents =
            [ modal { inverted = darkMode }
                []
                [ Modal.header { inverted = darkMode } [] [ text "Select a Photo" ]
                , Modal.content { inverted = darkMode }
                    []
                    [ Modal.description []
                        [ p []
                            [ text "We've found the following "
                            , a [ href "https://www.gravatar.com", Attributes.target "_blank" ] [ text "gravatar" ]
                            , text " image associated with your e-mail address."
                            ]
                        , p [] [ text "Is it okay to use this photo?" ]
                        ]
                    ]
                , Modal.actions { inverted = darkMode }
                    []
                    [ blackButton [] [ text "Nope" ]
                    , greenButton [] [ text "Yep, that's me" ]
                    ]
                ]
            ]
        }
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , example
        { title = "Basic"
        , description = "A modal can reduce its complexity"
        , contents =
            [ basicModal []
                [ Modal.basicHeader [] [ text "Archive Old Messages" ]
                , Modal.basicContent []
                    [ Modal.description []
                        [ p [] [ text "Your inbox is getting full, would you like us to enable automatic archiving of old messages?" ] ]
                    ]
                , Modal.basicActions []
                    [ redButton [] [ text "No" ]
                    , greenButton [] [ text "Yes" ]
                    ]
                ]
            ]
        }
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    , br [] []
    ]
