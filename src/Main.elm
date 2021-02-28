module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document)
import Browser.Navigation as Nav exposing (Key)
import Css exposing (..)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Html
import Html.Styled exposing (Attribute, Html, a, div, h1, h2, h3, h4, h5, p, span, strong, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (css, href, rel, src, type_)
import Html.Styled.Events exposing (onClick)
import Maybe.Extra
import UI.Breadcrumb exposing (..)
import UI.Button exposing (..)
import UI.Card as Card exposing (..)
import UI.Container exposing (..)
import UI.Example exposing (..)
import UI.Grid as Grid exposing (..)
import UI.Header as Header exposing (..)
import UI.Icon as Icon exposing (..)
import UI.Image exposing (..)
import UI.Input as Input exposing (..)
import UI.Item as Item exposing (..)
import UI.Label as Label exposing (..)
import UI.Menu as Menu exposing (..)
import UI.Message exposing (..)
import UI.Placeholder exposing (line, placeholder)
import UI.Rail exposing (..)
import UI.Segment exposing (..)
import UI.Table exposing (..)
import UI.Text exposing (..)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, s)



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
    , count : Int
    }


type Page
    = NotFound
    | TopPage
    | SitePage
    | ButtonPage
    | ContainerPage
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


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    routing url
        { key = key
        , page = TopPage
        , count = 0
        }



-- ROUTER


type Route
    = Top
    | Site
    | Button
    | Container
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


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Top Parser.top
        , Parser.map Site (s "site")
        , Parser.map Button (s "button")
        , Parser.map Container (s "container")
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



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
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
                        , basicSegment []
                            [ container []
                                [ breadcrumbItems
                                    |> List.indexedMap (breadcrumbItem <| List.length breadcrumbItems)
                                    |> List.intersperse (divider [] [ text "/" ])
                                    |> breadcrumb
                                ]
                            ]
                        , basicSegment []
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
                , contents = tableOfContents
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
                , contents = examplesForRail
                }

            SegmentPage ->
                { title = Just "Segment"
                , breadcrumbItems = [ "Top", "Segment" ]
                , contents = examplesForSegment
                }

            TextPage ->
                { title = Just "Text"
                , breadcrumbItems = [ "Top", "Text" ]
                , contents = examplesForText
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
                , contents = examplesForMenu
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
                , contents = examplesForCard
                }

            ItemPage ->
                { title = Just "Item"
                , breadcrumbItems = [ "Top", "Item" ]
                , contents = examplesForItem
                }


tableOfContents : List (Html msg)
tableOfContents =
    [ cards [] <|
        List.map
            (\{ label, description, category, url } ->
                card []
                    [ a [ href url ]
                        [ Card.content []
                            [ Header.header [] [ text label ]
                            , Card.meta [] [ text category ]
                            , Card.description [] [ text description ]
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
    ]


examplesForSite : List (Html msg)
examplesForSite =
    [ example []
        [ Header.header [] [ text "Headers" ]
        , p [] [ text "A site can define styles for headers" ]
        , h1 [] [ text "First Header" ]
        , h2 [] [ text "Second Header" ]
        , h3 [] [ text "Third Header" ]
        , h4 [] [ text "Fourth Header" ]
        , h5 [] [ text "Fifth Header" ]
        ]
    , example []
        [ Header.header [] [ text "Page Font" ]
        , p [] [ text "A site can specify styles for page content." ]
        , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
        , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
        , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
        ]
    , example []
        [ Header.header [] [ text "Text Selection" ]
        , p [] [ text "A site can specify text selection styles." ]
        , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
        ]
    , example []
        [ Header.header [] [ text "Spacing" ]
        , p [] [ text "A site can define default spacing for headers and paragraphs" ]
        , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
        , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
        , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
        ]
    ]


examplesForButton : Model -> List (Html Msg)
examplesForButton { count } =
    [ example []
        [ Header.header [] [ text "Button" ]
        , p [] [ text "A standard button" ]
        , button [] [ text "Follow" ]
        ]
    , example []
        [ button [] [ text "Button" ]
        , button [] [ text "Focusable" ]
        ]
    , example []
        [ Header.header [] [ text "Emphasis" ]
        , p [] [ text "A button can be formatted to show different levels of emphasis" ]
        , primaryButton [] [ text "Save" ]
        , button [] [ text "Discard" ]
        ]
    , example []
        [ secondaryButton [] [ text "Okay" ]
        , button [] [ text "Cancel" ]
        ]
    , example []
        [ Header.header [] [ text "Labeled" ]
        , p [] [ text "A button can appear alongside a label" ]
        , labeledButton []
            [ button [] [ icon [] "fas fa-heart", text "Like" ]
            , basicLabel [] [ text "2048" ]
            ]
        , labeledButton []
            [ button [ onClick Decrement ] [ text "-" ]
            , basicLabel [] [ text (String.fromInt count) ]
            , button [ onClick Increment ] [ text "+" ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Icon" ]
        , p [] [ text "A button can have only an icon" ]
        , button [] [ icon [] "fas fa-cloud" ]
        ]
    , example []
        [ Header.header [] [ text "Basic" ]
        , p [] [ text "A basic button is less pronounced" ]
        , basicButton [] [ icon [] "fas fa-user", text "Add Friend" ]
        ]
    , example [] <|
        [ Header.header [] [ text "Colored" ]
        , p [] [ text "A button can have different colors" ]
        , primaryButton [] [ text "Primary" ]
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
    [ example []
        [ Header.header [] [ text "Container" ]
        , p [] [ text "A standard container" ]
        , container [] [ content ]
        ]
    , example []
        [ Header.header [] [ text "Text Container" ]
        , p [] [ text "A container can reduce its maximum width to more naturally accomodate a single column of text" ]
        , textContainer []
            [ h2 [] [ text "Header" ]
            , content
            , content
            ]
        ]
    ]


examplesForHeader : List (Html msg)
examplesForHeader =
    [ example []
        [ Header.header [] [ text "Content Headers" ]
        , p [] [ text "Headers may be oriented to give the importance of a section in the context of the content that surrounds it" ]
        , massiveHeader [] [ text "Massive Header" ]
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
    [ example []
        [ Header.header [] [ text "Accessibility" ]
        , p [] [ text "Icons can represent accessibility standards" ]
        , fiveColumnsGrid []
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
    ]


examplesForImage : List (Html msg)
examplesForImage =
    [ example []
        [ Header.header [] [ text "Image" ]
        , p [] [ text "An image" ]
        , smallImage [ src "./static/images/wireframe/image.png" ] []
        ]
    ]


examplesForInput : List (Html msg)
examplesForInput =
    [ example []
        [ Header.header [] [ text "Input" ]
        , p [] [ text "A standard input" ]
        , input []
            [ Html.Styled.input [ type_ "text", Attributes.placeholder "Search..." ] [] ]
        ]
    , example []
        [ Header.header [] [ text "Labeled" ]
        , p [] [ text "An input can be formatted with a label" ]
        , input []
            [ Input.label [] [ text "http://" ]
            , Html.Styled.input [ type_ "text", Attributes.placeholder "mysite.com" ] []
            ]
        ]
    , example []
        [ input []
            [ Html.Styled.input [ type_ "text", Attributes.placeholder "Enter weight.." ] []
            , Input.label [] [ text "kg" ]
            ]
        ]
    ]


examplesForLabel : List (Html msg)
examplesForLabel =
    [ example []
        [ Header.header [] [ text "Label" ]
        , p [] [ text "A label" ]
        , Label.label [] [ icon [] "fas fa-envelope", text "23" ]
        ]
    , example []
        [ Header.header [] [ text "Icon" ]
        , p [] [ text "A label can include an icon" ]
        , Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
        , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
        , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
        , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
        ]
    , example []
        [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
        , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
        , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
        , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
        ]
    , example []
        [ Label.label [] [ icon [] "fas fa-envelope" ]
        , Label.label [] [ icon [] "fas fa-dog" ]
        , Label.label [] [ icon [] "fas fa-cat" ]
        ]
    , example []
        [ Header.header [] [ text "Basic" ]
        , p [] [ text "A label can reduce its complexity" ]
        , basicLabel [] [ text "Basic" ]
        ]
    , example []
        [ Header.header [] [ text "Colored" ]
        , p [] [ text "A label can have different colors" ]
        , primaryLabel [] [ text "Primary" ]
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
    ]


examplesForPlaceholder : List (Html msg)
examplesForPlaceholder =
    [ example []
        [ Header.header [] [ text "Lines" ]
        , p [] [ text "A placeholder can contain have lines of text" ]
        , placeholder []
            [ line [] []
            , line [] []
            , line [] []
            , line [] []
            , line [] []
            ]
        ]
    ]


examplesForRail : List (Html msg)
examplesForRail =
    [ example []
        [ Header.header [] [ text "Rail" ]
        , p [] [ text "A rail can be presented on the left or right side of a container" ]
        , segment [ css [ width (pct 45), left (pct 27.5) ] ]
            [ leftRail []
                [ segment [] [ text "Left Rail Content" ] ]
            , rightRail []
                [ segment [] [ text "Right Rail Content" ] ]
            , wireframeParagraph
            , wireframeParagraph
            ]
        ]
    ]


examplesForSegment : List (Html msg)
examplesForSegment =
    [ example []
        [ Header.header [] [ text "Segment" ]
        , p [] [ text "A segment of content" ]
        , segment [] [ wireframeShortParagraph ]
        ]
    , example []
        [ Header.header [] [ text "Vertical Segment" ]
        , p [] [ text "A vertical segment formats content to be aligned as part of a vertical group" ]
        , verticalSegment [] [ wireframeShortParagraph ]
        , verticalSegment [] [ wireframeShortParagraph ]
        , verticalSegment [] [ wireframeShortParagraph ]
        ]
    , example []
        [ Header.header [] [ text "Disabled" ]
        , p [] [ text "A segment may show its content is disabled" ]
        , disabledSegment [] [ wireframeShortParagraph ]
        ]
    , example []
        [ Header.header [] [ text "Inverted" ]
        , p [] [ text "A segment can have its colors inverted for contrast" ]
        , invertedSegment []
            [ p [] [ text "I'm here to tell you something, and you will probably read me first." ] ]
        ]
    , example []
        [ Header.header [] [ text "Padded" ]
        , p [] [ text "A segment can increase its padding" ]
        , paddedSegment [] [ wireframeShortParagraph ]
        ]
    , example []
        [ veryPaddedSegment [] [ wireframeShortParagraph ] ]
    , example []
        [ Header.header [] [ text "Basic" ]
        , p [] [ text "A basic segment has no special formatting\n\n" ]
        , basicSegment []
            [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
        ]
    ]


examplesForText : List (Html msg)
examplesForText =
    [ example []
        [ Header.header [] [ text "Text" ]
        , p [] [ text "A text is always used inline and uses one color from the FUI color palette" ]
        , segment []
            [ text "This is "
            , redText { inverted = False } "red"
            , text " inline text and this is "
            , blueText { inverted = False } "blue"
            , text " inline text and this is "
            , purpleText { inverted = False } "purple"
            , text " inline text"
            ]
        , invertedSegment []
            [ text "This is "
            , redText { inverted = True } "red"
            , text " inline text and this is "
            , blueText { inverted = True } "blue"
            , text " inline text and this is "
            , purpleText { inverted = True } "purple"
            , text " inline text"
            ]
        , segment []
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
        , invertedSegment []
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
    , example []
        [ Header.header [] [ text "Size" ]
        , p [] [ text "Text can vary in the same sizes as icons" ]
        , segment []
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
    ]


examplesForBreadcrumb : List (Html msg)
examplesForBreadcrumb =
    [ example []
        [ Header.header [] [ text "Breadcrumb" ]
        , p [] [ text "A standard breadcrumb" ]
        , breadcrumb
            [ section [] [ text "Home" ]
            , divider [] [ text "/" ]
            , section [] [ text "Store" ]
            , divider [] [ text "/" ]
            , activeSection [] [ text "T-Shirt" ]
            ]
        ]
    , example []
        [ breadcrumb
            [ section [] [ text "Home" ]
            , divider [] [ icon [] "fas fa-angle-right" ]
            , section [] [ text "Store" ]
            , divider [] [ icon [] "fas fa-angle-right" ]
            , activeSection [] [ text "T-Shirt" ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Divider" ]
        , p [] [ text "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text." ]
        , breadcrumb
            [ section [] [ text "Home" ]
            , divider [] [ text "/" ]
            , section [] [ text "Registration" ]
            , divider [] [ text "/" ]
            , activeSection [] [ text "Personal Information" ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Active" ]
        , p [] [ text "A section can be active" ]
        , breadcrumb
            [ section [] [ text "Products" ]
            , divider [] [ text "/" ]
            , activeSection [] [ text "Paper Towels" ]
            ]
        ]
    ]


examplesForGrid : List (Html msg)
examplesForGrid =
    [ example []
        [ Header.header [] [ text "Grids" ]
        , p [] [ text "A grid is a structure with a long history used to align negative space in designs." ]
        , p [] [ text "Using a grid makes content appear to flow more naturally on your page." ]
        , let
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
    ]


examplesForMenu : List (Html msg)
examplesForMenu =
    [ example []
        [ Header.header [] [ text "Secondary Menu" ]
        , p [] [ text "A menu can adjust its appearance to de-emphasize its contents" ]
        , secondaryMenu { inverted = False } [] <|
            [ secondaryMenuActiveItem [] [ text "Home" ]
            , secondaryMenuItem [] [] [ text "Messages" ]
            , secondaryMenuItem [] [] [ text "Friends" ]
            , rightMenu []
                [ secondaryMenuItem [] [] <|
                    [ input []
                        [ Html.Styled.input [ type_ "text", Attributes.placeholder "Search..." ] [] ]
                    ]
                , secondaryMenuItem [] [] [ text "Logout" ]
                ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Vertical Menu" ]
        , p [] [ text "A vertical menu displays elements vertically.." ]
        , verticalMenu { inverted = False, additionalStyles = [] } [] <|
            [ verticalMenuActiveItem []
                [ text "Inbox"
                , verticalMenuActiveItemLabel [] [ text "1" ]
                ]
            , verticalMenuItem { inverted = False, additionalStyles = [] } [] <|
                [ text "Spam"
                , verticalMenuActiveItemLabel [] [ text "51" ]
                ]
            , verticalMenuItem { inverted = False, additionalStyles = [] } [] <|
                [ text "Updates"
                , verticalMenuActiveItemLabel [] [ text "1" ]
                ]
            , verticalMenuItem { inverted = False, additionalStyles = [] } [] [ text "Search mail..." ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Link Item" ]
        , p [] [ text "A menu may contain a link item, or an item formatted as if it is a link." ]
        , verticalMenu { inverted = False, additionalStyles = [] } [] <|
            [ verticalMenuLinkItem { inverted = False, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
            , verticalMenuLinkItem { inverted = False, additionalStyles = [] } [] [ text "Javascript Link" ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Inverted" ]
        , p [] [ text "A menu may have its colors inverted to show greater contrast" ]
        , Menu.menu { inverted = True } [] <|
            [ linkItem { inverted = True } [] [ text "Home" ]
            , linkItem { inverted = True } [] [ text "Messages" ]
            , linkItem { inverted = True } [] [ text "Friends" ]
            ]
        ]
    , example []
        [ verticalInvertedMenu []
            [ verticalMenuLinkItem { inverted = True, additionalStyles = [] } [] [ text "Home" ]
            , verticalMenuLinkItem { inverted = True, additionalStyles = [] } [] [ text "Messages" ]
            , verticalMenuLinkItem { inverted = True, additionalStyles = [] } [] [ text "Friends" ]
            ]
        ]
    , example []
        [ invertedSegment []
            [ secondaryMenu { inverted = False } [] <|
                [ linkItem { inverted = True } [] [ text "Home" ]
                , linkItem { inverted = True } [] [ text "Messages" ]
                , linkItem { inverted = True } [] [ text "Friends" ]
                ]
            ]
        ]
    ]


examplesForMessage : List (Html msg)
examplesForMessage =
    [ example []
        [ Header.header [] [ text "Message" ]
        , p [] [ text "A basic message" ]
        , message []
            [ div []
                [ Header.header [] [ text "Changes in Service" ]
                , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Icon Message" ]
        , p [] [ text "A message can contain an icon." ]
        , message []
            [ icon [] "fas fa-inbox"
            , div []
                [ Header.header [] [ text "Have you heard about our mailing list?" ]
                , p [] [ text "Get the best news in your e-mail every day." ]
                ]
            ]
        ]
    ]


examplesForTable : List (Html msg)
examplesForTable =
    [ example []
        [ Header.header [] [ text "Table" ]
        , p [] [ text "A standard table" ]
        , celledTable []
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
    , example []
        [ Header.header [] [ text "Striped" ]
        , p [] [ text "A table can stripe alternate rows of content with a darker color to increase contrast" ]
        , stripedTable []
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
    , example []
        [ Header.header [] [ text "Basic" ]
        , p [] [ text "A table can reduce its complexity to increase readability." ]
        , basicTable []
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
    , example []
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
    ]


examplesForCard : List (Html msg)
examplesForCard =
    [ example []
        [ Header.header [] [ text "Card" ]
        , p [] [ text "A single card." ]
        , card []
            [ image [ src "./static/images/avatar/kristy.png" ] []
            , Card.content []
                [ Header.header [] [ text "Kristy" ]
                , Card.meta [] [ text "Joined in 2013" ]
                , Card.description [] [ text "Kristy is an art director living in New York." ]
                ]
            , extraContent []
                [ icon [] "fas fa-user"
                , text "22 Friends"
                ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Cards" ]
        , p [] [ text "A group of cards." ]
        , cards [] <|
            List.map
                (\{ name, type_, description_, friends, imageUrl } ->
                    card []
                        [ image [ src imageUrl ] []
                        , Card.content []
                            [ Header.header [] [ text name ]
                            , Card.meta [] [ text type_ ]
                            , Card.description [] [ text description_ ]
                            ]
                        , extraContent []
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
    , example []
        [ Header.header [] [ text "Header" ]
        , p [] [ text "A card can contain a header" ]
        , cards [] <|
            List.map
                (\{ name, type_, description_ } ->
                    card []
                        [ Card.content []
                            [ Header.header [] [ text name ]
                            , Card.meta [] [ text type_ ]
                            , Card.description [] [ text description_ ]
                            ]
                        ]
                )
                [ { name = "Elliot Fu"
                  , type_ = "Friend"
                  , description_ = "Elliot Fu is a film-maker from New York."
                  }
                , { name = "Veronika Ossi"
                  , type_ = "Friend"
                  , description_ = "Veronika Ossi is a set designer living in New York who enjoys kittens, music, and partying."
                  }
                , { name = "Jenny Hess"
                  , type_ = "Friend"
                  , description_ = "Jenny is a student studying Media Management at the New School"
                  }
                ]
        ]
    , example []
        [ Header.header [] [ text "Metadata" ]
        , p [] [ text "A card can contain content metadata" ]
        , card []
            [ Card.content []
                [ Header.header [] [ text "Cute Dog" ]
                , Card.meta []
                    [ text "2 days ago "
                    , a [] [ text "Animals" ]
                    ]
                , wireframeParagraph
                ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Description" ]
        , p [] [ text "A card can contain a description with one or more paragraphs" ]
        , card []
            [ Card.content []
                [ Header.header [] [ text "Cute Dog" ]
                , Card.meta [] [ text "2 days ago " ]
                , Card.description []
                    [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                    , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                    ]
                ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Extra Content" ]
        , p [] [ text "A card can contain extra content meant to be formatted separately from the main content" ]
        , card []
            [ Card.content []
                [ Header.header [] [ text "Cute Dog" ]
                , Card.meta [] [ text "2 days ago " ]
                , Card.description []
                    [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                    , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                    ]
                ]
            , extraContent []
                [ icon [] "fas fa-check"
                , text "121 Votes"
                ]
            ]
        ]
    ]


examplesForItem : List (Html msg)
examplesForItem =
    [ example []
        [ Header.header [] [ text "Image" ]
        , p [] [ text "An item can contain an image" ]
        , dividedItems []
            [ Item.item []
                [ image [ src "./static/images/wireframe/image.png" ] [] ]
            , Item.item []
                [ image [ src "./static/images/wireframe/image.png" ] [] ]
            , Item.item []
                [ image [ src "./static/images/wireframe/image.png" ] [] ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Content" ]
        , p [] [ text "An item can contain content" ]
        , dividedItems []
            [ Item.item []
                [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                , middleAlignedContent [] [ text "Content A" ]
                ]
            , Item.item []
                [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                , middleAlignedContent [] [ text "Content B" ]
                ]
            , Item.item []
                [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                , middleAlignedContent [] [ text "Content C" ]
                ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Header" ]
        , p [] [ text "An item can contain a header" ]
        , items []
            [ Item.item []
                [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                , middleAlignedContent []
                    [ Item.header [] [ text "12 Years a Slave" ] ]
                ]
            , Item.item []
                [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                , middleAlignedContent []
                    [ Item.header [] [ text "My Neighbor Totoro" ] ]
                ]
            , Item.item []
                [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                , middleAlignedContent []
                    [ Item.header [] [ text "Watchmen" ] ]
                ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Metadata" ]
        , p [] [ text "An item can contain content metadata" ]
        , items []
            [ Item.item []
                [ smallImage [ src "./static/images/wireframe/image.png" ] []
                , Item.content []
                    [ Item.header [] [ text "Arrowhead Valley Camp" ]
                    , Item.meta []
                        [ span [] [ text "$1200" ]
                        , span [] [ text "1 Month" ]
                        ]
                    , Item.description [] [ wireframeShortParagraph ]
                    ]
                ]
            , Item.item []
                [ smallImage [ src "./static/images/wireframe/image.png" ] []
                , Item.content []
                    [ Item.header [] [ text "Buck's Homebrew Stayaway" ]
                    , Item.meta []
                        [ span [] [ text "$1000" ]
                        , span [] [ text "2 Weeks" ]
                        ]
                    , Item.description [] [ wireframeShortParagraph ]
                    ]
                ]
            , Item.item []
                [ smallImage [ src "./static/images/wireframe/image.png" ] []
                , Item.content []
                    [ Item.header [] [ text "Astrology Camp" ]
                    , Item.meta []
                        [ span [] [ text "$1600" ]
                        , span [] [ text "6 Weeks" ]
                        ]
                    , Item.description [] [ wireframeShortParagraph ]
                    ]
                ]
            ]
        ]
    , example []
        [ Header.header [] [ text "Description" ]
        , p [] [ text "An item can contain a description with a single or multiple paragraphs" ]
        , items []
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
    ]
