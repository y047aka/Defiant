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
        List.map (\summary -> Parser.map summary (pageParser summary.route)) allPages


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
                getInit pageSummary.architecture model
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
            getUpdate model.pageSummary.architecture msg model


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
        case model.pageSummary.route of
            [] ->
                "Defiant"

            _ ->
                model.pageSummary.title ++ " | Defiant"
    , body =
        layout model <|
            getView model.pageSummary.architecture model
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
    , architecture : Architecture_
    }


type Architecture_
    = Default Architecture


type alias Architecture =
    { init : Model -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }


getArchitecture : Architecture_ -> Architecture
getArchitecture (Default architecture) =
    architecture


toArchitecture_Globals : Globals.Architecture -> Architecture
toArchitecture_Globals architecture =
    { init =
        \model ->
            case model.pageSummary.category of
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


toArchitecture_Elements : Elements.Architecture -> Architecture
toArchitecture_Elements architecture =
    { init =
        \model ->
            case model.pageSummary.category of
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


toArchitecture_Collections : Collections.Architecture -> Architecture
toArchitecture_Collections architecture =
    { init =
        \model ->
            case model.pageSummary.category of
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


toArchitecture_Views : Views.Architecture -> Architecture
toArchitecture_Views architecture =
    { init =
        \model ->
            case model.pageSummary.category of
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


toArchitecture_Modules : Modules.Architecture -> Architecture
toArchitecture_Modules architecture =
    { init =
        \model ->
            case model.pageSummary.category of
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


toArchitecture_Defiant : Defiant.Architecture -> Architecture
toArchitecture_Defiant architecture =
    { init =
        \model ->
            case model.pageSummary.category of
                Defiant ->
                    architecture.init (getShared model)
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


getInit : Architecture_ -> (Model -> ( Model, Cmd Msg ))
getInit =
    getArchitecture >> .init


getUpdate : Architecture_ -> (Msg -> Model -> ( Model, Cmd Msg ))
getUpdate =
    getArchitecture >> .update


getView : Architecture_ -> (Model -> List (Html Msg))
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
    { page = NotFound
    , title = "Not Found"
    , description = ""
    , category = None
    , route = [ "404" ]
    , architecture =
        Default
            { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
            , update = \msg model -> update msg model
            , view = \_ -> []
            }
    }


topPage : PageSummary
topPage =
    { page = Top
    , title = "Top"
    , description = ""
    , category = None
    , route = []
    , architecture =
        Default
            { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
            , update = \msg model -> update msg model
            , view = \model -> tableOfContents { inverted = getShared model |> .darkMode }
            }
    }


sitePage : PageSummary
sitePage =
    { page = Site
    , title = "Site"
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Globals
    , route = [ "site" ]
    , architecture = Globals.architecture |> toArchitecture_Globals |> Default
    }


buttonPage : PageSummary
buttonPage =
    { page = Button
    , title = "Button"
    , description = "A button indicates a possible user action"
    , category = Elements
    , route = [ "button" ]
    , architecture = Elements.architecture Button |> toArchitecture_Elements |> Default
    }


containerPage : PageSummary
containerPage =
    { page = Container
    , title = "Container"
    , description = "A container limits content to a maximum width"
    , category = Elements
    , route = [ "container" ]
    , architecture = Elements.architecture Container |> toArchitecture_Elements |> Default
    }


dividerPage : PageSummary
dividerPage =
    { page = Divider
    , title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Elements
    , route = [ "divider" ]
    , architecture = Elements.architecture Divider |> toArchitecture_Elements |> Default
    }


headerPage : PageSummary
headerPage =
    { page = Header
    , title = "Header"
    , description = "A header provides a short summary of content"
    , category = Elements
    , route = [ "header" ]
    , architecture = Elements.architecture Header |> toArchitecture_Elements |> Default
    }


iconPage : PageSummary
iconPage =
    { page = Icon
    , title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Elements
    , route = [ "icon" ]
    , architecture = Elements.architecture Icon |> toArchitecture_Elements |> Default
    }


imagePage : PageSummary
imagePage =
    { page = Image
    , title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Elements
    , route = [ "image" ]
    , architecture = Elements.architecture Image |> toArchitecture_Elements |> Default
    }


inputPage : PageSummary
inputPage =
    { page = Input
    , title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Elements
    , route = [ "input" ]
    , architecture = Elements.architecture Input |> toArchitecture_Elements |> Default
    }


labelPage : PageSummary
labelPage =
    { page = Label
    , title = "Label"
    , description = "A label displays content classification"
    , category = Elements
    , route = [ "label" ]
    , architecture = Elements.architecture Label |> toArchitecture_Elements |> Default
    }


loaderPage : PageSummary
loaderPage =
    { page = Loader
    , title = "Loader"
    , description = "A loader alerts a user to wait for an activity to complete"
    , category = Elements
    , route = [ "loader" ]
    , architecture = Elements.architecture Loader |> toArchitecture_Elements |> Default
    }


placeholderPage : PageSummary
placeholderPage =
    { page = Placeholder
    , title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Elements
    , route = [ "placeholder" ]
    , architecture = Elements.architecture Placeholder |> toArchitecture_Elements |> Default
    }


railPage : PageSummary
railPage =
    { page = Rail
    , title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Elements
    , route = [ "rail" ]
    , architecture = Elements.architecture Rail |> toArchitecture_Elements |> Default
    }


segmentPage : PageSummary
segmentPage =
    { page = Segment
    , title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Elements
    , route = [ "segment" ]
    , architecture = Elements.architecture Segment |> toArchitecture_Elements |> Default
    }


stepPage : PageSummary
stepPage =
    { page = Step
    , title = "Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "step" ]
    , architecture = Elements.architecture Step |> toArchitecture_Elements |> Default
    }


circleStepPage : PageSummary
circleStepPage =
    { page = CircleStep
    , title = "Circle Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "circle-step" ]
    , architecture = Elements.architecture CircleStep |> toArchitecture_Elements |> Default
    }


textPage : PageSummary
textPage =
    { page = Text
    , title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Elements
    , route = [ "text" ]
    , architecture = Elements.architecture Text |> toArchitecture_Elements |> Default
    }


breadcrumbPage : PageSummary
breadcrumbPage =
    { page = Breadcrumb
    , title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Collections
    , route = [ "breadcrumb" ]
    , architecture = Collections.architecture Breadcrumb |> toArchitecture_Collections |> Default
    }


formPage : PageSummary
formPage =
    { page = Form
    , title = "Form"
    , description = "A form displays a set of related user input fields in a structured way"
    , category = Collections
    , route = [ "form" ]
    , architecture = Collections.architecture Form |> toArchitecture_Collections |> Default
    }


gridPage : PageSummary
gridPage =
    { page = Grid
    , title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Collections
    , route = [ "grid" ]
    , architecture = Collections.architecture Grid |> toArchitecture_Collections |> Default
    }


menuPage : PageSummary
menuPage =
    { page = Menu
    , title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Collections
    , route = [ "menu" ]
    , architecture = Collections.architecture Menu |> toArchitecture_Collections |> Default
    }


messagePage : PageSummary
messagePage =
    { page = Message
    , title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Collections
    , route = [ "message" ]
    , architecture = Collections.architecture Message |> toArchitecture_Collections |> Default
    }


tablePage : PageSummary
tablePage =
    { page = Table
    , title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = Collections
    , route = [ "table" ]
    , architecture = Collections.architecture Table |> toArchitecture_Collections |> Default
    }


cardPage : PageSummary
cardPage =
    { page = Card
    , title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = Views
    , route = [ "card" ]
    , architecture = Views.architecture Card |> toArchitecture_Views |> Default
    }


itemPage : PageSummary
itemPage =
    { page = Item
    , title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = Views
    , route = [ "item" ]
    , architecture = Views.architecture Item |> toArchitecture_Views |> Default
    }


accordionPage : PageSummary
accordionPage =
    { page = Accordion
    , title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Modules
    , route = [ "accordion" ]
    , architecture = Modules.architecture Accordion |> toArchitecture_Modules |> Default
    }


checkboxPage : PageSummary
checkboxPage =
    { page = Checkbox
    , title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Modules
    , route = [ "checkbox" ]
    , architecture = Modules.architecture Checkbox |> toArchitecture_Modules |> Default
    }


dimmerPage : PageSummary
dimmerPage =
    { page = Dimmer
    , title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Modules
    , route = [ "dimmer" ]
    , architecture = Modules.architecture Dimmer |> toArchitecture_Modules |> Default
    }


modalPage : PageSummary
modalPage =
    { page = Modal
    , title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Modules
    , route = [ "modal" ]
    , architecture = Modules.architecture Modal |> toArchitecture_Modules |> Default
    }


progressPage : PageSummary
progressPage =
    { page = Progress
    , title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Modules
    , route = [ "progress" ]
    , architecture = Modules.architecture Progress |> toArchitecture_Modules |> Default
    }


tabPage : PageSummary
tabPage =
    { page = Tab
    , title = "Tab"
    , description = "A tab is a hidden section of content activated by a menu"
    , category = Modules
    , route = [ "tab" ]
    , architecture = Modules.architecture Tab |> toArchitecture_Modules |> Default
    }


sortableTablePage : PageSummary
sortableTablePage =
    { page = SortableTable
    , title = "SortableTable"
    , description = "Sortable table"
    , category = Defiant
    , route = [ "sortable-table" ]
    , architecture = Defiant.architecture SortableTable |> toArchitecture_Defiant |> Default
    }


holyGrailPage : PageSummary
holyGrailPage =
    { page = HolyGrail
    , title = "HolyGrail"
    , description = "Holy grail layout."
    , category = Defiant
    , route = [ "holy-grail" ]
    , architecture = Defiant.architecture HolyGrail |> toArchitecture_Defiant |> Default
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
