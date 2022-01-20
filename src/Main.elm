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
import Shared exposing (Shared)
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
    { pageSummary : PageSummary
    , subModel : SubModel
    }


type SubModel
    = NoneModel Shared
    | GlobalsModel Globals.Model
    | ElementsModel Elements.Model
    | CollectionsModel Collections.Model
    | ViewsModel Views.Model
    | ModulesModel Modules.Model
    | DefiantModel Defiant.Model


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    { pageSummary = notFoundPage
    , subModel = NoneModel (Shared.init key)
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
        List.map (\summary -> Parser.map summary (pageParser (getRoute summary))) allPages


routing : Url -> Model -> ( Model, Cmd Msg )
routing url prevModel =
    Parser.parse parser url
        |> Maybe.withDefault notFoundPage
        |> (\pageSummary ->
                let
                    shared =
                        getShared prevModel

                    model =
                        { prevModel
                            | pageSummary = pageSummary
                            , subModel = setShared shared prevModel.subModel
                        }
                in
                getInit pageSummary model
           )



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
    | ToggleDarkMode
    | GlobalsMsg Globals.Msg
    | ElementsMsg Elements.Msg
    | CollectionsMsg Collections.Msg
    | ViewsMsg Views.Msg
    | ModulesMsg Modules.Msg
    | DefiantMsg Defiant.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        shared =
            getShared model
    in
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Just id ->
                            ( model, Nav.load ("#" ++ id) )

                        Nothing ->
                            ( model, Nav.pushUrl shared.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            routing url model

        ToggleDarkMode ->
            let
                shared_ =
                    Shared.setDarkMode (not shared.darkMode) shared
            in
            ( { model | subModel = setShared shared_ model.subModel }
            , Cmd.none
            )

        _ ->
            getUpdate model.pageSummary msg model


updateWith : (subModel -> SubModel) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( { model | subModel = toModel subModel }
    , Cmd.map toMsg subCmd
    )


getShared : Model -> Shared
getShared model =
    case model.subModel of
        NoneModel shared ->
            shared

        GlobalsModel { shared } ->
            shared

        ElementsModel { shared } ->
            shared

        CollectionsModel { shared } ->
            shared

        ViewsModel { shared } ->
            shared

        ModulesModel { shared } ->
            shared

        DefiantModel { shared } ->
            shared


setShared : Shared -> SubModel -> SubModel
setShared shared subModel =
    case subModel of
        NoneModel _ ->
            NoneModel shared

        GlobalsModel model ->
            GlobalsModel { model | shared = shared }

        ElementsModel model ->
            ElementsModel { model | shared = shared }

        CollectionsModel model ->
            CollectionsModel { model | shared = shared }

        ViewsModel model ->
            ViewsModel { model | shared = shared }

        ModulesModel model ->
            ModulesModel { model | shared = shared }

        DefiantModel model ->
            DefiantModel { model | shared = shared }



-- VIEW


view : Model -> { title : String, body : List (Html Msg) }
view model =
    { title =
        case getRoute model.pageSummary of
            [] ->
                "Defiant"

            _ ->
                getTitle model.pageSummary ++ " | Defiant"
    , body =
        layout model <|
            getView model.pageSummary model
    }


layout : Model -> List (Html Msg) -> List (Html Msg)
layout model contents =
    let
        darkMode =
            getShared model |> .darkMode
    in
    [ basicSegment { inverted = False }
        []
        [ container []
            [ breadcrumb { divider = text "/", inverted = darkMode }
                (breadcrumbItems model.pageSummary)
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
breadcrumbItems ps =
    case getRoute ps of
        [] ->
            [ { label = "Top", url = "/" } ]

        _ ->
            [ { label = "Top", url = "/" }
            , { label = getTitle ps, url = Builder.absolute (getRoute ps) [] }
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
                    (List.filter (getCategory >> (==) category) allPages
                        |> List.map (\ps -> item (getCommon ps))
                    )
                ]
        )
        [ Globals, Elements, Collections, Views, Modules, Defiant ]


type PageSummary
    = Default Common Architecture
    | Globals_ Common Globals.Architecture
    | Elements_ Common Elements.Architecture
    | Collections_ Common Collections.Architecture
    | Views_ Common Views.Architecture
    | Modules_ Common Modules.Architecture
    | Defiant_ Common Defiant.Architecture


type alias Common =
    { page : Page
    , title : String
    , description : String
    , category : Category
    , route : List String
    }


type alias Architecture =
    { init : Model -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }


getCommon : PageSummary -> Common
getCommon ps =
    case ps of
        Default common _ ->
            common

        Globals_ common _ ->
            common

        Elements_ common _ ->
            common

        Collections_ common _ ->
            common

        Views_ common _ ->
            common

        Modules_ common _ ->
            common

        Defiant_ common _ ->
            common


getArchitecture : PageSummary -> Architecture
getArchitecture ps =
    case ps of
        Default _ architecture ->
            { init = architecture.init
            , update = architecture.update
            , view = architecture.view
            }

        Globals_ _ architecture ->
            { init =
                \model ->
                    case getCategory model.pageSummary of
                        Globals ->
                            architecture.init (getShared model)
                                |> updateWith GlobalsModel GlobalsMsg model

                        _ ->
                            ( model, Cmd.none )
            , update =
                \msg model ->
                    case ( model.subModel, msg ) of
                        ( GlobalsModel subModel, GlobalsMsg subMsg ) ->
                            architecture.update subMsg subModel
                                |> updateWith GlobalsModel GlobalsMsg model

                        _ ->
                            ( model, Cmd.none )
            , view =
                \{ subModel } ->
                    case subModel of
                        GlobalsModel model ->
                            architecture.view model
                                |> List.map (Html.map GlobalsMsg)

                        _ ->
                            []
            }

        Elements_ _ architecture ->
            { init =
                \model ->
                    case getCategory model.pageSummary of
                        Elements ->
                            architecture.init (getShared model)
                                |> updateWith ElementsModel ElementsMsg model

                        _ ->
                            ( model, Cmd.none )
            , update =
                \msg model ->
                    case ( model.subModel, msg ) of
                        ( ElementsModel subModel, ElementsMsg subMsg ) ->
                            architecture.update subMsg subModel
                                |> updateWith ElementsModel ElementsMsg model

                        _ ->
                            ( model, Cmd.none )
            , view =
                \{ subModel } ->
                    case subModel of
                        ElementsModel model ->
                            architecture.view model
                                |> List.map (Html.map ElementsMsg)

                        _ ->
                            []
            }

        Collections_ _ architecture ->
            { init =
                \model ->
                    case getCategory model.pageSummary of
                        Collections ->
                            architecture.init (getShared model)
                                |> updateWith CollectionsModel CollectionsMsg model

                        _ ->
                            ( model, Cmd.none )
            , update =
                \msg model ->
                    case ( model.subModel, msg ) of
                        ( CollectionsModel subModel, CollectionsMsg subMsg ) ->
                            architecture.update subMsg subModel
                                |> updateWith CollectionsModel CollectionsMsg model

                        _ ->
                            ( model, Cmd.none )
            , view =
                \{ subModel } ->
                    case subModel of
                        CollectionsModel model ->
                            architecture.view model
                                |> List.map (Html.map CollectionsMsg)

                        _ ->
                            []
            }

        Views_ _ architecture ->
            { init =
                \model ->
                    case getCategory model.pageSummary of
                        Views ->
                            architecture.init (getShared model)
                                |> updateWith ViewsModel ViewsMsg model

                        _ ->
                            ( model, Cmd.none )
            , update =
                \msg model ->
                    case ( model.subModel, msg ) of
                        ( ViewsModel subModel, ViewsMsg subMsg ) ->
                            architecture.update subMsg subModel
                                |> updateWith ViewsModel ViewsMsg model

                        _ ->
                            ( model, Cmd.none )
            , view =
                \{ subModel } ->
                    case subModel of
                        ViewsModel model ->
                            architecture.view model
                                |> List.map (Html.map ViewsMsg)

                        _ ->
                            []
            }

        Modules_ _ architecture ->
            { init =
                \model ->
                    case getCategory model.pageSummary of
                        Modules ->
                            architecture.init (getShared model)
                                |> updateWith ModulesModel ModulesMsg model

                        _ ->
                            ( model, Cmd.none )
            , update =
                \msg model ->
                    case ( model.subModel, msg ) of
                        ( ModulesModel subModel, ModulesMsg subMsg ) ->
                            architecture.update subMsg subModel
                                |> updateWith ModulesModel ModulesMsg model

                        _ ->
                            ( model, Cmd.none )
            , view =
                \{ subModel } ->
                    case subModel of
                        ModulesModel model ->
                            architecture.view model
                                |> List.map (Html.map ModulesMsg)

                        _ ->
                            []
            }

        Defiant_ _ architecture ->
            { init =
                \model ->
                    case getCategory model.pageSummary of
                        Defiant ->
                            Defiant.init (getShared model)
                                |> updateWith DefiantModel DefiantMsg model

                        _ ->
                            ( model, Cmd.none )
            , update =
                \msg model ->
                    case ( model.subModel, msg ) of
                        ( DefiantModel subModel, DefiantMsg subMsg ) ->
                            architecture.update subMsg subModel
                                |> updateWith DefiantModel DefiantMsg model

                        _ ->
                            ( model, Cmd.none )
            , view =
                \{ subModel } ->
                    case subModel of
                        DefiantModel model ->
                            architecture.view model
                                |> List.map (Html.map DefiantMsg)

                        _ ->
                            []
            }


getCategory : PageSummary -> Category
getCategory =
    getCommon >> .category


getRoute : PageSummary -> List String
getRoute =
    getCommon >> .route


getTitle : PageSummary -> String
getTitle =
    getCommon >> .title


getInit : PageSummary -> (Model -> ( Model, Cmd Msg ))
getInit =
    getArchitecture >> .init


getUpdate : PageSummary -> (Msg -> Model -> ( Model, Cmd Msg ))
getUpdate =
    getArchitecture >> .update


getView : PageSummary -> (Model -> List (Html Msg))
getView =
    getArchitecture >> .view


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
    Default
        { page = NotFound
        , title = "Not Found"
        , description = ""
        , category = None
        , route = [ "404" ]
        }
        { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
        , update = \msg model -> update msg model
        , view = \_ -> []
        }


topPage : PageSummary
topPage =
    Default
        { page = Top
        , title = "Top"
        , description = ""
        , category = None
        , route = []
        }
        { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
        , update = \msg model -> update msg model
        , view = \model -> tableOfContents { inverted = getShared model |> .darkMode }
        }


sitePage : PageSummary
sitePage =
    Globals_
        { page = Site
        , title = "Site"
        , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
        , category = Globals
        , route = [ "site" ]
        }
        { init = Globals.init
        , update = Globals.update
        , view = \_ -> Globals.examplesForSite
        }


buttonPage : PageSummary
buttonPage =
    Elements_
        { page = Button
        , title = "Button"
        , description = "A button indicates a possible user action"
        , category = Elements
        , route = [ "button" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = Elements.examplesForButton
        }


containerPage : PageSummary
containerPage =
    Elements_
        { page = Container
        , title = "Container"
        , description = "A container limits content to a maximum width"
        , category = Elements
        , route = [ "container" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForContainer
        }


dividerPage : PageSummary
dividerPage =
    Elements_
        { page = Divider
        , title = "Divider"
        , description = "A divider visually segments content into groups"
        , category = Elements
        , route = [ "divider" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForDivider
        }


headerPage : PageSummary
headerPage =
    Elements_
        { page = Header
        , title = "Header"
        , description = "A header provides a short summary of content"
        , category = Elements
        , route = [ "header" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \{ shared } -> Elements.examplesForHeader { inverted = shared.darkMode }
        }


iconPage : PageSummary
iconPage =
    Elements_
        { page = Icon
        , title = "Icon"
        , description = "An icon is a glyph used to represent something else"
        , category = Elements
        , route = [ "icon" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForIcon
        }


imagePage : PageSummary
imagePage =
    Elements_
        { page = Image
        , title = "Image"
        , description = "An image is a graphic representation of something"
        , category = Elements
        , route = [ "image" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForImage
        }


inputPage : PageSummary
inputPage =
    Elements_
        { page = Input
        , title = "Input"
        , description = "An input is a field used to elicit a response from a user"
        , category = Elements
        , route = [ "input" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForInput
        }


labelPage : PageSummary
labelPage =
    Elements_
        { page = Label
        , title = "Label"
        , description = "A label displays content classification"
        , category = Elements
        , route = [ "label" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForLabel
        }


loaderPage : PageSummary
loaderPage =
    Elements_
        { page = Loader
        , title = "Loader"
        , description = "A loader alerts a user to wait for an activity to complete"
        , category = Elements
        , route = [ "loader" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \{ shared } -> Elements.examplesForLoader { inverted = shared.darkMode }
        }


placeholderPage : PageSummary
placeholderPage =
    Elements_
        { page = Placeholder
        , title = "Placeholder"
        , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
        , category = Elements
        , route = [ "placeholder" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForPlaceholder
        }


railPage : PageSummary
railPage =
    Elements_
        { page = Rail
        , title = "Rail"
        , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
        , category = Elements
        , route = [ "rail" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \{ shared } -> Elements.examplesForRail { inverted = shared.darkMode }
        }


segmentPage : PageSummary
segmentPage =
    Elements_
        { page = Segment
        , title = "Segment"
        , description = "A segment is used to create a grouping of related content"
        , category = Elements
        , route = [ "segment" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \{ shared } -> Elements.examplesForSegment { inverted = shared.darkMode }
        }


stepPage : PageSummary
stepPage =
    Elements_
        { page = Step
        , title = "Step"
        , description = "A step shows the completion status of an activity in a series of activities"
        , category = Elements
        , route = [ "step" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForStep
        }


circleStepPage : PageSummary
circleStepPage =
    Elements_
        { page = CircleStep
        , title = "Circle Step"
        , description = "A step shows the completion status of an activity in a series of activities"
        , category = Elements
        , route = [ "circle-step" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \_ -> Elements.examplesForCircleStep
        }


textPage : PageSummary
textPage =
    Elements_
        { page = Text
        , title = "Text"
        , description = "A text is used to style some inline text with a simple color"
        , category = Elements
        , route = [ "text" ]
        }
        { init = Elements.init
        , update = Elements.update
        , view = \{ shared } -> Elements.examplesForText { inverted = shared.darkMode }
        }


breadcrumbPage : PageSummary
breadcrumbPage =
    Collections_
        { page = Breadcrumb
        , title = "Breadcrumb"
        , description = "A breadcrumb is used to show hierarchy between content"
        , category = Collections
        , route = [ "breadcrumb" ]
        }
        { init = Collections.init
        , update = Collections.update
        , view = \{ shared } -> Collections.examplesForBreadcrumb { inverted = shared.darkMode }
        }


formPage : PageSummary
formPage =
    Collections_
        { page = Form
        , title = "Form"
        , description = "A form displays a set of related user input fields in a structured way"
        , category = Collections
        , route = [ "form" ]
        }
        { init = Collections.init
        , update = Collections.update
        , view = \_ -> Collections.examplesForForm
        }


gridPage : PageSummary
gridPage =
    Collections_
        { page = Grid
        , title = "Grid"
        , description = "A grid is used to harmonize negative space in a layout"
        , category = Collections
        , route = [ "grid" ]
        }
        { init = Collections.init
        , update = Collections.update
        , view = \{ shared } -> Collections.examplesForGrid { inverted = shared.darkMode }
        }


menuPage : PageSummary
menuPage =
    Collections_
        { page = Menu
        , title = "Menu"
        , description = "A menu displays grouped navigation actions"
        , category = Collections
        , route = [ "menu" ]
        }
        { init = Collections.init
        , update = Collections.update
        , view = \{ shared } -> Collections.examplesForMenu { inverted = shared.darkMode }
        }


messagePage : PageSummary
messagePage =
    Collections_
        { page = Message
        , title = "Message"
        , description = "A message displays information that explains nearby content"
        , category = Collections
        , route = [ "message" ]
        }
        { init = Collections.init
        , update = Collections.update
        , view = \{ shared } -> Collections.examplesForMessage { inverted = shared.darkMode }
        }


tablePage : PageSummary
tablePage =
    Collections_
        { page = Table
        , title = "Table"
        , description = "A table displays a collections of data grouped into rows"
        , category = Collections
        , route = [ "table" ]
        }
        { init = Collections.init
        , update = Collections.update
        , view = \_ -> Collections.examplesForTable
        }


cardPage : PageSummary
cardPage =
    Views_
        { page = Card
        , title = "Card"
        , description = "A card displays site content in a manner similar to a playing card"
        , category = Views
        , route = [ "card" ]
        }
        { init = Views.init
        , update = Views.update
        , view = \{ shared } -> Views.examplesForCard { inverted = shared.darkMode }
        }


itemPage : PageSummary
itemPage =
    Views_
        { page = Item
        , title = "Item"
        , description = "An item view presents large collections of site content for display"
        , category = Views
        , route = [ "item" ]
        }
        { init = Views.init
        , update = Views.update
        , view = \_ -> Views.examplesForItem
        }


accordionPage : PageSummary
accordionPage =
    Modules_
        { page = Accordion
        , title = "Accordion"
        , description = "An accordion allows users to toggle the display of sections of content"
        , category = Modules
        , route = [ "accordion" ]
        }
        { init = Modules.init
        , update = Modules.update
        , view = \{ shared } -> Modules.examplesForAccordion { inverted = shared.darkMode }
        }


checkboxPage : PageSummary
checkboxPage =
    Modules_
        { page = Checkbox
        , title = "Checkbox"
        , description = "A checkbox allows a user to select a value from a small set of options, often binary"
        , category = Modules
        , route = [ "checkbox" ]
        }
        { init = Modules.init
        , update = Modules.update
        , view = \_ -> Modules.examplesForCheckbox
        }


dimmerPage : PageSummary
dimmerPage =
    Modules_
        { page = Dimmer
        , title = "Dimmer"
        , description = "A dimmer hides distractions to focus attention on particular content"
        , category = Modules
        , route = [ "dimmer" ]
        }
        { init = Modules.init
        , update = Modules.update
        , view = \{ shared, toggledItems } -> Modules.examplesForDimmer { toggledItems = toggledItems, darkMode = shared.darkMode }
        }


modalPage : PageSummary
modalPage =
    Modules_
        { page = Modal
        , title = "Modal"
        , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
        , category = Modules
        , route = [ "modal" ]
        }
        { init = Modules.init
        , update = Modules.update
        , view = \{ shared, toggledItems } -> Modules.examplesForModal { toggledItems = toggledItems, darkMode = shared.darkMode }
        }


progressPage : PageSummary
progressPage =
    Modules_
        { page = Progress
        , title = "Progress"
        , description = "A progress bar shows the progression of a task"
        , category = Modules
        , route = [ "progress" ]
        }
        { init = Modules.init
        , update = Modules.update
        , view = Modules.examplesForProgress
        }


tabPage : PageSummary
tabPage =
    Modules_
        { page = Tab
        , title = "Tab"
        , description = "A tab is a hidden section of content activated by a menu"
        , category = Modules
        , route = [ "tab" ]
        }
        { init = Modules.init
        , update = Modules.update
        , view = \_ -> Modules.examplesForTab
        }


sortableTablePage : PageSummary
sortableTablePage =
    Defiant_
        { page = SortableTable
        , title = "SortableTable"
        , description = "Sortable table"
        , category = Defiant
        , route = [ "sortable-table" ]
        }
        { init = Defiant.init
        , update = Defiant.update
        , view = Defiant.examplesForSortableTable
        }


holyGrailPage : PageSummary
holyGrailPage =
    Defiant_
        { page = HolyGrail
        , title = "HolyGrail"
        , description = "Holy grail layout."
        , category = Defiant
        , route = [ "holy-grail" ]
        }
        { init = Defiant.init
        , update = Defiant.update
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
