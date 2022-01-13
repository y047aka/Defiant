module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Navigation as Nav exposing (Key)
import Category.Collections as Collections
import Category.Defiant as Defiant
import Category.Elements as Elements
import Category.Globals as Globals
import Category.Modules as Modules
import Category.Views as Views
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Data.Page exposing (Page(..))
import Html.Styled as Html exposing (Html, a, div, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (for, href, id, type_)
import Html.Styled.Events exposing (onClick)
import UI.Breadcrumb exposing (BreadcrumbItem, breadcrumb)
import UI.Card as Card exposing (card, cards)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Container exposing (container)
import UI.Header as Header exposing (..)
import UI.Segment exposing (..)
import Url exposing (Url)
import Url.Builder as Builder
import Url.Parser as Parser exposing (Parser, s)



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view =
            view
                >> (\{ title, body } ->
                        { title = title
                        , body =
                            [ (global (normalize ++ additionalReset ++ globalCustomize ++ fontAwesome) :: body)
                                |> div []
                                |> toUnstyled
                            ]
                        }
                   )
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        }



-- MODEL


type alias Model =
    { key : Key
    , pageSummary : PageSummary
    , darkMode : Bool
    , subModel : SubModel
    }


type SubModel
    = NoneModel
    | ElementsModel Elements.Model
    | CollectionsModel Collections.Model
    | ViewsModel Views.Model
    | ModulesModel Modules.Model
    | DefiantModel Defiant.Model


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    { key = key
    , pageSummary = notFoundPage
    , darkMode = False
    , subModel = NoneModel
    }
        |> routing url



-- ROUTER


parser : Parser (PageSummary -> a) a
parser =
    let
        pageParser route =
            case route of
                [] ->
                    Parser.top

                [ string ] ->
                    s string

                _ ->
                    Parser.top
    in
    Parser.oneOf <|
        List.map (\summary -> Parser.map summary (pageParser summary.route)) allPages


routing : Url -> Model -> ( Model, Cmd Msg )
routing url prevModel =
    Parser.parse parser url
        |> Maybe.withDefault notFoundPage
        |> (\pageSummary ->
                let
                    model =
                        { prevModel | pageSummary = pageSummary }
                in
                case pageSummary.category of
                    None ->
                        ( { model | subModel = NoneModel }, Cmd.none )

                    Elements ->
                        Elements.init model.darkMode
                            |> updateWith ElementsModel ElementsMsg model

                    Collections ->
                        Collections.init model.darkMode
                            |> updateWith CollectionsModel CollectionsMsg model

                    Views ->
                        Views.init model.darkMode
                            |> updateWith ViewsModel ViewsMsg model

                    Modules ->
                        Modules.init model.darkMode
                            |> updateWith ModulesModel ModulesMsg model

                    Defiant ->
                        Defiant.init
                            |> updateWith DefiantModel DefiantMsg model

                    _ ->
                        ( model, Cmd.none )
           )



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
    | ToggleDarkMode
    | ElementsMsg Elements.Msg
    | CollectionsMsg Collections.Msg
    | ViewsMsg Views.Msg
    | ModulesMsg Modules.Msg
    | DefiantMsg Defiant.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( model.subModel, msg ) of
        ( _, UrlRequested urlRequest ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Just id ->
                            ( model, Nav.load ("#" ++ id) )

                        Nothing ->
                            ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ( _, UrlChanged url ) ->
            routing url model

        ( _, ToggleDarkMode ) ->
            ( { model | darkMode = not model.darkMode }, Cmd.none )

        ( ElementsModel elements, ElementsMsg submsg ) ->
            Elements.update submsg elements
                |> updateWith ElementsModel ElementsMsg model

        ( CollectionsModel modules, CollectionsMsg submsg ) ->
            Collections.update submsg modules
                |> updateWith CollectionsModel CollectionsMsg model

        ( ViewsModel modules, ViewsMsg submsg ) ->
            Views.update submsg modules
                |> updateWith ViewsModel ViewsMsg model

        ( ModulesModel modules, ModulesMsg submsg ) ->
            Modules.update submsg modules
                |> updateWith ModulesModel ModulesMsg model

        ( DefiantModel defiant, DefiantMsg submsg ) ->
            Defiant.update submsg defiant
                |> updateWith DefiantModel DefiantMsg model

        _ ->
            ( model, Cmd.none )


updateWith : (subModel -> SubModel) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( { model | subModel = toModel subModel }
    , Cmd.map toMsg subCmd
    )



-- VIEW


view : Model -> { title : String, body : List (Html Msg) }
view model =
    { title =
        case model.pageSummary.page of
            Top ->
                "Defiant"

            _ ->
                model.pageSummary.title ++ " | Defiant"
    , body =
        layout model <|
            model.pageSummary.view model.subModel
    }


layout : Model -> List (Html Msg) -> List (Html Msg)
layout { pageSummary, darkMode } contents =
    [ basicSegment { inverted = False }
        []
        [ container []
            [ breadcrumb { divider = text "/", inverted = darkMode }
                (breadcrumbItems pageSummary)
            ]
        ]
    , basicSegment { inverted = False }
        []
        [ container []
            [ checkbox []
                [ Checkbox.input
                    [ id "darkmode"
                    , type_ "checkbox"
                    , Attributes.checked darkMode
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


breadcrumbItems : PageSummary -> List BreadcrumbItem
breadcrumbItems { title, route } =
    case route of
        [] ->
            [ { label = "Top", url = "/" } ]

        _ ->
            [ { label = "Top", url = "/" }
            , { label = title, url = Builder.absolute route [] }
            ]


tableOfContents : { inverted : Bool } -> List (Html msg)
tableOfContents options =
    let
        item { title, description, route } =
            card options
                []
                [ a [ href (Builder.absolute route []) ]
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
                [ Header.header options [] [ text (categoryToString category) ]
                , cards []
                    (List.filter (.category >> (==) category) allPages
                        |> List.map item
                    )
                ]
        )
        [ Globals, Elements, Collections, Views, Modules, Defiant ]


type alias PageSummary =
    { page : Page
    , title : String
    , description : String
    , category : Category
    , route : List String
    , view : SubModel -> List (Html Msg)
    }


type Category
    = None
    | Globals
    | Elements
    | Collections
    | Views
    | Modules
    | Defiant


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

        Defiant ->
            "Defiant"


notFoundPage : PageSummary
notFoundPage =
    { page = NotFound
    , title = "Not Found"
    , description = ""
    , category = None
    , route = [ "404" ]
    , view = \_ -> []
    }


topPage : PageSummary
topPage =
    { page = Top
    , title = "Top"
    , description = ""
    , category = None
    , route = []
    , view = \_ -> tableOfContents { inverted = False }
    }


sitePage : PageSummary
sitePage =
    { page = Site
    , title = "Site"
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Globals
    , route = [ "site" ]
    , view = \_ -> Globals.examplesForSite
    }


buttonPage : PageSummary
buttonPage =
    { page = Button
    , title = "Button"
    , description = "A button indicates a possible user action"
    , category = Elements
    , route = [ "button" ]
    , view =
        \model ->
            case model of
                ElementsModel elements ->
                    Elements.examplesForButton elements |> List.map (Html.map ElementsMsg)

                _ ->
                    []
    }


containerPage : PageSummary
containerPage =
    { page = Container
    , title = "Container"
    , description = "A container limits content to a maximum width"
    , category = Elements
    , route = [ "container" ]
    , view = \_ -> Elements.examplesForContainer
    }


dividerPage : PageSummary
dividerPage =
    { page = Divider
    , title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Elements
    , route = [ "divider" ]
    , view = \_ -> Elements.examplesForDivider
    }


headerPage : PageSummary
headerPage =
    { page = Header
    , title = "Header"
    , description = "A header provides a short summary of content"
    , category = Elements
    , route = [ "header" ]
    , view =
        \model ->
            case model of
                ElementsModel elements ->
                    Elements.examplesForHeader { inverted = elements.darkMode }

                _ ->
                    []
    }


iconPage : PageSummary
iconPage =
    { page = Icon
    , title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Elements
    , route = [ "icon" ]
    , view = \_ -> Elements.examplesForIcon
    }


imagePage : PageSummary
imagePage =
    { page = Image
    , title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Elements
    , route = [ "image" ]
    , view = \_ -> Elements.examplesForImage
    }


inputPage : PageSummary
inputPage =
    { page = Input
    , title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Elements
    , route = [ "input" ]
    , view = \_ -> Elements.examplesForInput
    }


labelPage : PageSummary
labelPage =
    { page = Label
    , title = "Label"
    , description = "A label displays content classification"
    , category = Elements
    , route = [ "label" ]
    , view = \_ -> Elements.examplesForLabel
    }


loaderPage : PageSummary
loaderPage =
    { page = Loader
    , title = "Loader"
    , description = "A loader alerts a user to wait for an activity to complete"
    , category = Elements
    , route = [ "loader" ]
    , view =
        \model ->
            case model of
                ElementsModel elements ->
                    Elements.examplesForLoader { inverted = elements.darkMode }

                _ ->
                    []
    }


placeholderPage : PageSummary
placeholderPage =
    { page = Placeholder
    , title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Elements
    , route = [ "placeholder" ]
    , view = \_ -> Elements.examplesForPlaceholder
    }


railPage : PageSummary
railPage =
    { page = Rail
    , title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Elements
    , route = [ "rail" ]
    , view =
        \model ->
            case model of
                ElementsModel elements ->
                    Elements.examplesForRail { inverted = elements.darkMode }

                _ ->
                    []
    }


segmentPage : PageSummary
segmentPage =
    { page = Segment
    , title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Elements
    , route = [ "segment" ]
    , view =
        \model ->
            case model of
                ElementsModel elements ->
                    Elements.examplesForSegment { inverted = elements.darkMode }

                _ ->
                    []
    }


stepPage : PageSummary
stepPage =
    { page = Step
    , title = "Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "step" ]
    , view = \_ -> Elements.examplesForStep
    }


circleStepPage : PageSummary
circleStepPage =
    { page = CircleStep
    , title = "Circle Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "circle-step" ]
    , view = \_ -> Elements.examplesForCircleStep
    }


textPage : PageSummary
textPage =
    { page = Text
    , title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Elements
    , route = [ "text" ]
    , view =
        \model ->
            case model of
                ElementsModel elements ->
                    Elements.examplesForText { inverted = elements.darkMode }

                _ ->
                    []
    }


breadcrumbPage : PageSummary
breadcrumbPage =
    { page = Breadcrumb
    , title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Collections
    , route = [ "breadcrumb" ]
    , view =
        \model ->
            case model of
                CollectionsModel collections ->
                    Collections.examplesForBreadcrumb { inverted = collections.darkMode }

                _ ->
                    []
    }


formPage : PageSummary
formPage =
    { page = Form
    , title = "Form"
    , description = "A form displays a set of related user input fields in a structured way"
    , category = Collections
    , route = [ "form" ]
    , view = \_ -> Collections.examplesForForm
    }


gridPage : PageSummary
gridPage =
    { page = Grid
    , title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Collections
    , route = [ "grid" ]
    , view =
        \model ->
            case model of
                CollectionsModel collections ->
                    Collections.examplesForGrid { inverted = collections.darkMode }

                _ ->
                    []
    }


menuPage : PageSummary
menuPage =
    { page = Menu
    , title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Collections
    , route = [ "menu" ]
    , view =
        \model ->
            case model of
                CollectionsModel collections ->
                    Collections.examplesForMenu collections

                _ ->
                    []
    }


messagePage : PageSummary
messagePage =
    { page = Message
    , title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Collections
    , route = [ "message" ]
    , view =
        \model ->
            case model of
                CollectionsModel collections ->
                    Collections.examplesForMessage { inverted = collections.darkMode }

                _ ->
                    []
    }


tablePage : PageSummary
tablePage =
    { page = Table
    , title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = Collections
    , route = [ "table" ]
    , view = \_ -> Collections.examplesForTable
    }


cardPage : PageSummary
cardPage =
    { page = Card
    , title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = Views
    , route = [ "card" ]
    , view =
        \model ->
            case model of
                ViewsModel views ->
                    Views.examplesForCard { inverted = views.darkMode }

                _ ->
                    []
    }


itemPage : PageSummary
itemPage =
    { page = Item
    , title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = Views
    , route = [ "item" ]
    , view = \_ -> Views.examplesForItem
    }


accordionPage : PageSummary
accordionPage =
    { page = Accordion
    , title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Modules
    , route = [ "accordion" ]
    , view =
        \model ->
            case model of
                ModulesModel modules ->
                    Modules.examplesForAccordion { inverted = modules.darkMode }

                _ ->
                    []
    }


checkboxPage : PageSummary
checkboxPage =
    { page = Checkbox
    , title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Modules
    , route = [ "checkbox" ]
    , view = \_ -> Modules.examplesForCheckbox
    }


dimmerPage : PageSummary
dimmerPage =
    { page = Dimmer
    , title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Modules
    , route = [ "dimmer" ]
    , view =
        \model ->
            case model of
                ModulesModel modules ->
                    Modules.examplesForDimmer modules |> List.map (Html.map ModulesMsg)

                _ ->
                    []
    }


modalPage : PageSummary
modalPage =
    { page = Modal
    , title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Modules
    , route = [ "modal" ]
    , view =
        \model ->
            case model of
                ModulesModel modules ->
                    Modules.examplesForModal modules |> List.map (Html.map ModulesMsg)

                _ ->
                    []
    }


progressPage : PageSummary
progressPage =
    { page = Progress
    , title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Modules
    , route = [ "progress" ]
    , view =
        \model ->
            case model of
                ModulesModel modules ->
                    Modules.examplesForProgress modules |> List.map (Html.map ModulesMsg)

                _ ->
                    []
    }


tabPage : PageSummary
tabPage =
    { page = Tab
    , title = "Tab"
    , description = "A tab is a hidden section of content activated by a menu"
    , category = Modules
    , route = [ "tab" ]
    , view = \_ -> Modules.examplesForTab
    }


sortableTablePage : PageSummary
sortableTablePage =
    { page = SortableTable
    , title = "SortableTable"
    , description = "Sortable table"
    , category = Defiant
    , route = [ "sortable-table" ]
    , view =
        \model ->
            case model of
                DefiantModel defiant ->
                    Defiant.examplesForSortableTable defiant |> List.map (Html.map DefiantMsg)

                _ ->
                    []
    }


holyGrailPage : PageSummary
holyGrailPage =
    { page = HolyGrail
    , title = "HolyGrail"
    , description = "Holy grail layout."
    , category = Defiant
    , route = [ "holy-grail" ]
    , view = \_ -> Defiant.examplesForHolyGrail
    }


allPages : List PageSummary
allPages =
    [ notFoundPage
    , topPage

    -- Globals
    , sitePage

    -- Elements
    , buttonPage
    , containerPage
    , dividerPage
    , headerPage
    , iconPage
    , imagePage
    , inputPage
    , labelPage
    , loaderPage
    , placeholderPage
    , railPage
    , segmentPage
    , stepPage
    , circleStepPage
    , textPage

    -- Collections
    , breadcrumbPage
    , formPage
    , gridPage
    , menuPage
    , messagePage
    , tablePage

    -- Views
    , cardPage
    , itemPage

    -- Modules
    , accordionPage
    , checkboxPage
    , dimmerPage
    , modalPage
    , progressPage
    , tabPage

    -- Defiant
    , sortableTablePage
    , holyGrailPage
    ]
