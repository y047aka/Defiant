module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document)
import Browser.Navigation as Nav exposing (Key)
import Css exposing (..)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Html
import Html.Styled exposing (Html, a, div, h1, h2, h3, h4, h5, p, strong, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (css, href, rel, type_)
import Html.Styled.Events exposing (onClick)
import Maybe.Extra
import UI.Breadcrumb exposing (..)
import UI.Button exposing (..)
import UI.Card as Card exposing (..)
import UI.Container exposing (..)
import UI.Example exposing (..)
import UI.Grid exposing (..)
import UI.Header exposing (..)
import UI.Icon exposing (..)
import UI.Input as Input exposing (..)
import UI.Label as Label exposing (..)
import UI.Menu as Menu exposing (..)
import UI.Message exposing (..)
import UI.Modifier exposing (Palette(..))
import UI.Placeholder exposing (..)
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
    | InputPage
    | LabelPage
    | PlaceholderPage
    | SegmentPage
    | TextPage
    | BreadcrumbPage
    | GridPage
    | MenuPage
    | MessagePage
    | TablePage
    | CardPage


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
    | Input
    | Label
    | Placeholder
    | Segment
    | Text
    | Breadcrumb
    | Grid
    | Menu
    | Message
    | Table
    | Card


parser : Parser (Route -> a) a
parser =
    Parser.oneOf <|
        [ Parser.map Top Parser.top
        , Parser.map Site (s "site")
        , Parser.map Button (s "button")
        , Parser.map Container (s "container")
        , Parser.map Header (s "header")
        , Parser.map Icon (s "icon")
        , Parser.map Input (s "input")
        , Parser.map Label (s "label")
        , Parser.map Placeholder (s "placeholder")
        , Parser.map Segment (s "segment")
        , Parser.map Text (s "text")
        , Parser.map Breadcrumb (s "breadcrumb")
        , Parser.map Grid (s "grid")
        , Parser.map Menu (s "menu")
        , Parser.map Message (s "message")
        , Parser.map Table (s "table")
        , Parser.map Card (s "card")
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

            Just Input ->
                InputPage

            Just Label ->
                LabelPage

            Just Placeholder ->
                PlaceholderPage

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
                        [ global (normalize ++ additionalReset ++ globalCustomize)
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
                , contents = examplesForButtons model
                }

            ContainerPage ->
                { title = Just "Container"
                , breadcrumbItems = [ "Top", "Container" ]
                , contents = examplesForContainers
                }

            HeaderPage ->
                { title = Just "Header"
                , breadcrumbItems = [ "Top", "Header" ]
                , contents = examplesForHeaders
                }

            IconPage ->
                { title = Just "Icon"
                , breadcrumbItems = [ "Top", "Icon" ]
                , contents = examplesForIcons
                }

            InputPage ->
                { title = Just "Input"
                , breadcrumbItems = [ "Top", "Input" ]
                , contents = examplesForInputs
                }

            LabelPage ->
                { title = Just "Label"
                , breadcrumbItems = [ "Top", "Label" ]
                , contents = examplesForLabels
                }

            PlaceholderPage ->
                { title = Just "Placeholder"
                , breadcrumbItems = [ "Top", "Placeholder" ]
                , contents = examplesForPlaceholders
                }

            SegmentPage ->
                { title = Just "Segment"
                , breadcrumbItems = [ "Top", "Segment" ]
                , contents = examplesForSegments
                }

            TextPage ->
                { title = Just "Text"
                , breadcrumbItems = [ "Top", "Text" ]
                , contents = examplesForTexts
                }

            BreadcrumbPage ->
                { title = Just "Breadcrumb"
                , breadcrumbItems = [ "Top", "Breadcrumb" ]
                , contents = examplesForBreadcrumbs
                }

            GridPage ->
                { title = Just "Grid"
                , breadcrumbItems = [ "Top", "Grid" ]
                , contents = examplesForGrids
                }

            MenuPage ->
                { title = Just "Menu"
                , breadcrumbItems = [ "Top", "Menu" ]
                , contents = examplesForMenus
                }

            MessagePage ->
                { title = Just "Message"
                , breadcrumbItems = [ "Top", "Message" ]
                , contents = examplesForMessages
                }

            TablePage ->
                { title = Just "Table"
                , breadcrumbItems = [ "Top", "Table" ]
                , contents = examplesForTables
                }

            CardPage ->
                { title = Just "Card"
                , breadcrumbItems = [ "Top", "Card" ]
                , contents = examplesForCards
                }


tableOfContents : List (Html msg)
tableOfContents =
    [ cards [] <|
        List.map
            (\{ label, description, category, url } ->
                card []
                    [ a [ href url ]
                        [ Card.content []
                            [ header [] [ text label ]
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
    ]


examplesForSite : List (Html msg)
examplesForSite =
    [ example []
        [ header [] [ text "Headers" ]
        , p [] [ text "A site can define styles for headers" ]
        , h1 [] [ text "First Header" ]
        , h2 [] [ text "Second Header" ]
        , h3 [] [ text "Third Header" ]
        , h4 [] [ text "Fourth Header" ]
        , h5 [] [ text "Fifth Header" ]
        ]
    , example []
        [ header [] [ text "Page Font" ]
        , p [] [ text "A site can specify styles for page content." ]
        , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
        , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
        , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
        ]
    , example []
        [ header [] [ text "Text Selection" ]
        , p [] [ text "A site can specify text selection styles." ]
        , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
        ]
    , example []
        [ header [] [ text "Spacing" ]
        , p [] [ text "A site can define default spacing for headers and paragraphs" ]
        , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
        , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
        , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
        ]
    ]


examplesForButtons : Model -> List (Html Msg)
examplesForButtons { count } =
    [ example []
        [ header [] [ text "Button" ]
        , p [] [ text "A standard button" ]
        , button [] [ text "Follow" ]
        ]
    , example []
        [ button [] [ text "Button" ]
        , button [] [ text "Focusable" ]
        ]
    , example []
        [ header [] [ text "Animated" ]
        , p [] [ text "A button can animate to show hidden content" ]
        ]
    , example []
        [ header [] [ text "Labeled" ]
        , p [] [ text "A button can appear alongside a label" ]
        , labeledButton []
            [ button [] [ text "Like" ]
            , basicLabel [] [ text "2048" ]
            ]
        , labeledButton []
            [ button [ onClick Decrement ] [ text "-" ]
            , basicLabel [] [ text (String.fromInt count) ]
            , button [ onClick Increment ] [ text "+" ]
            ]
        ]
    , example []
        [ header [] [ text "Basic" ]
        , p [] [ text "A basic button is less pronounced" ]
        , basicButton [] [ text "Add Friend" ]
        ]
    , example [] <|
        [ header [] [ text "Colored" ]
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


examplesForContainers : List (Html msg)
examplesForContainers =
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
        [ header [] [ text "Container" ]
        , p [] [ text "A standard container" ]
        , container [] [ content ]
        ]
    , example []
        [ header [] [ text "Text Container" ]
        , p [] [ text "A container can reduce its maximum width to more naturally accomodate a single column of text" ]
        , textContainer []
            [ h2 [] [ text "Header" ]
            , content
            , content
            ]
        ]
    ]


examplesForHeaders : List (Html msg)
examplesForHeaders =
    [ example []
        [ header [] [ text "Content Headers" ]
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


examplesForIcons : List (Html msg)
examplesForIcons =
    [ example []
        [ header [] [ text "Accessibility" ]
        , p [] [ text "Icons can represent accessibility standards" ]
        , div []
            [ icon "fab" "accessible-icon"
            , icon "fas" "american-sign-language-interpreting"
            , icon "fas" "assistive-listening-systems"
            , icon "fas" "audio-description"
            , icon "fas" "blind"
            ]
        , div []
            [ icon "fas" "braille"
            , icon "fas" "closed-captioning"
            , icon "far" "closed-captioning"
            , icon "fas" "deaf"
            , icon "fas" "low-vision"
            ]
        , div []
            [ icon "fas" "phone-volume"
            , icon "fas" "question-circle"
            , icon "far" "question-circle"
            , icon "fas" "sign-language"
            , icon "fas" "tty"
            ]
        , div []
            [ icon "fas" "universal-access"
            , icon "fas" "wheelchair"
            ]
        ]
    ]


examplesForInputs : List (Html msg)
examplesForInputs =
    [ example []
        [ header [] [ text "Input" ]
        , p [] [ text "A standard input" ]
        , input []
            [ Html.Styled.input [ type_ "text", Attributes.placeholder "Search..." ] [] ]
        ]
    , example []
        [ header [] [ text "Labeled" ]
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


examplesForLabels : List (Html msg)
examplesForLabels =
    [ example []
        [ header [] [ text "Label" ]
        , p [] [ text "A label" ]
        , Label.label [] [ text "23" ]
        ]
    , example []
        [ header [] [ text "Basic" ]
        , p [] [ text "A label can reduce its complexity" ]
        , basicLabel [] [ text "Basic" ]
        ]
    , example [] <|
        [ header [] [ text "Colored" ]
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


examplesForPlaceholders : List (Html msg)
examplesForPlaceholders =
    [ example []
        [ header [] [ text "Lines" ]
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


examplesForSegments : List (Html msg)
examplesForSegments =
    [ example []
        [ header [] [ text "Segment" ]
        , p [] [ text "A segment of content" ]
        , segment [] [ wireframeShortParagraph ]
        ]
    , example []
        [ header [] [ text "Vertical Segment" ]
        , p [] [ text "A vertical segment formats content to be aligned as part of a vertical group" ]
        , verticalSegment [] [ wireframeShortParagraph ]
        , verticalSegment [] [ wireframeShortParagraph ]
        , verticalSegment [] [ wireframeShortParagraph ]
        ]
    , example []
        [ header [] [ text "Disabled" ]
        , p [] [ text "A segment may show its content is disabled" ]
        , disabledSegment [] [ wireframeShortParagraph ]
        ]
    , example []
        [ header [] [ text "Padded" ]
        , p [] [ text "A segment can increase its padding" ]
        , paddedSegment [] [ wireframeShortParagraph ]
        ]
    , example []
        [ veryPaddedSegment [] [ wireframeShortParagraph ] ]
    , example []
        [ header [] [ text "Basic" ]
        , p [] [ text "A basic segment has no special formatting\n\n" ]
        , basicSegment []
            [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
        ]
    ]


examplesForTexts : List (Html msg)
examplesForTexts =
    [ example []
        [ header [] [ text "Text" ]
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
        [ header [] [ text "Size" ]
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


examplesForBreadcrumbs : List (Html msg)
examplesForBreadcrumbs =
    [ example []
        [ header [] [ text "Breadcrumb" ]
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
        [ header [] [ text "Divider" ]
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
        [ header [] [ text "Active" ]
        , p [] [ text "A section can be active" ]
        , breadcrumb
            [ section [] [ text "Products" ]
            , divider [] [ text "/" ]
            , activeSection [] [ text "Paper Towels" ]
            ]
        ]
    ]


examplesForGrids : List (Html msg)
examplesForGrids =
    [ example []
        [ header [] [ text "Grids" ]
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


examplesForMenus : List (Html msg)
examplesForMenus =
    [ example []
        [ header [] [ text "Secondary Menu" ]
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
        [ header [] [ text "Vertical Menu" ]
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
        [ header [] [ text "Link Item" ]
        , p [] [ text "A menu may contain a link item, or an item formatted as if it is a link." ]
        , verticalMenu { inverted = False, additionalStyles = [] } [] <|
            [ verticalMenuLinkItem { inverted = False, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
            , verticalMenuLinkItem { inverted = False, additionalStyles = [] } [] [ text "Javascript Link" ]
            ]
        ]
    , example []
        [ header [] [ text "Inverted" ]
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


examplesForMessages : List (Html msg)
examplesForMessages =
    [ example []
        [ header [] [ text "Message" ]
        , p [] [ text "A basic message" ]
        , message []
            [ header [] [ text "Changes in Service" ]
            , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
            ]
        ]
    ]


examplesForTables : List (Html msg)
examplesForTables =
    [ example []
        [ header [] [ text "Table" ]
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
        [ header [] [ text "Striped" ]
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
        [ header [] [ text "Basic" ]
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


examplesForCards : List (Html msg)
examplesForCards =
    [ example []
        [ header [] [ text "Header" ]
        , p [] [ text "A card can contain a header" ]
        , cards []
            [ card []
                [ Card.content []
                    [ header [] [ text "Elliot Fu" ]
                    , meta [] [ text "Friend" ]
                    , description [] [ text "Elliot Fu is a film-maker from New York." ]
                    ]
                ]
            , card []
                [ Card.content []
                    [ header [] [ text "Veronika Ossi" ]
                    , meta [] [ text "Friend" ]
                    , description [] [ text "Veronika Ossi is a set designer living in New York who enjoys kittens, music, and partying." ]
                    ]
                ]
            , card []
                [ Card.content []
                    [ header [] [ text "Jenny Hess" ]
                    , meta [] [ text "Friend" ]
                    , description [] [ text "Jenny is a student studying Media Management at the New School" ]
                    ]
                ]
            ]
        ]
    , example []
        [ header [] [ text "Metadata" ]
        , p [] [ text "A card can contain content metadata" ]
        , card []
            [ Card.content []
                [ header [] [ text "Cute Dog" ]
                , meta []
                    [ text "2 days ago "
                    , a [] [ text "Animals" ]
                    ]
                , wireframeParagraph
                ]
            ]
        ]
    , example []
        [ header [] [ text "Description" ]
        , p [] [ text "A card can contain a description with one or more paragraphs" ]
        , card []
            [ Card.content []
                [ header [] [ text "Cute Dog" ]
                , meta [] [ text "2 days ago " ]
                , description []
                    [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                    , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                    ]
                ]
            ]
        ]
    ]
