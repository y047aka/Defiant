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
import Data.Category as Category exposing (Category(..))
import Data.Page exposing (Page(..))
import Html.Styled as Html exposing (Html, a, div, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (for, href, id, type_)
import Html.Styled.Events exposing (onClick)
import Shared exposing (PageSummary, Shared, setDarkMode, setPageSummary)
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
    { architecture : Architecture
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
    { architecture =
        Default
            { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
            , update = \msg model -> update msg model
            , view = \_ -> []
            }
    , subModel = NoneModel (Shared.init key (Tuple.first notFoundPage))
    }
        |> routing url



-- ROUTER


parser : Parser (( PageSummary, Architecture ) -> a) a
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
        List.map (\page -> Parser.map page (pageParser (Tuple.first page).route)) allPages


routing : Url -> Model -> ( Model, Cmd Msg )
routing url prevModel =
    let
        shared =
            getShared prevModel
    in
    Parser.parse parser url
        |> Maybe.withDefault notFoundPage
        |> (\( pageSummary, architecture ) ->
                let
                    model =
                        { prevModel
                            | architecture = architecture
                            , subModel =
                                prevModel.subModel
                                    |> setShared (setPageSummary pageSummary shared)
                        }
                in
                getInit architecture model
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
            ( { model
                | subModel =
                    model.subModel
                        |> setShared (setDarkMode (not shared.darkMode) shared)
              }
            , Cmd.none
            )

        _ ->
            getUpdate model.architecture msg model


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
    let
        { title, route } =
            getShared model |> .pageSummary
    in
    { title =
        case route of
            [] ->
                "Defiant"

            _ ->
                title ++ " | Defiant"
    , body =
        layout model <|
            getView model.architecture model
    }


layout : Model -> List (Html Msg) -> List (Html Msg)
layout model contents =
    let
        { pageSummary, darkMode } =
            getShared model
    in
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
                [ Header.header options [] [ text (Category.toString category) ]
                , cards []
                    (List.filterMap
                        (\( ps, _ ) ->
                            if ps.category == category then
                                Just (item ps)

                            else
                                Nothing
                        )
                        allPages
                    )
                ]
        )
        [ Globals, Elements, Collections, Views, Modules, Defiant ]


type Architecture
    = Default
        { init : Model -> ( Model, Cmd Msg )
        , update : Msg -> Model -> ( Model, Cmd Msg )
        , view : Model -> List (Html Msg)
        }


toArchitecture_Globals : Globals.Architecture -> Architecture
toArchitecture_Globals architecture =
    { init =
        \model ->
            let
                shared =
                    getShared model
            in
            case shared.pageSummary.category of
                Globals ->
                    architecture.init shared
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
        |> Default


toArchitecture_Elements : Elements.Architecture -> Architecture
toArchitecture_Elements architecture =
    { init =
        \model ->
            let
                shared =
                    getShared model
            in
            case shared.pageSummary.category of
                Elements ->
                    architecture.init shared
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
        |> Default


toArchitecture_Collections : Collections.Architecture -> Architecture
toArchitecture_Collections architecture =
    { init =
        \model ->
            let
                shared =
                    getShared model
            in
            case shared.pageSummary.category of
                Collections ->
                    architecture.init shared
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
        |> Default


toArchitecture_Views : Views.Architecture -> Architecture
toArchitecture_Views architecture =
    { init =
        \model ->
            let
                shared =
                    getShared model
            in
            case shared.pageSummary.category of
                Views ->
                    architecture.init shared
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
        |> Default


toArchitecture_Modules : Modules.Architecture -> Architecture
toArchitecture_Modules architecture =
    { init =
        \model ->
            let
                shared =
                    getShared model
            in
            case shared.pageSummary.category of
                Modules ->
                    architecture.init shared
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
        |> Default


toArchitecture_Defiant : Defiant.Architecture -> Architecture
toArchitecture_Defiant architecture =
    { init =
        \model ->
            let
                shared =
                    getShared model
            in
            case shared.pageSummary.category of
                Defiant ->
                    architecture.init shared
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
        |> Default


getInit : Architecture -> (Model -> ( Model, Cmd Msg ))
getInit (Default architecture) =
    architecture.init


getUpdate : Architecture -> (Msg -> Model -> ( Model, Cmd Msg ))
getUpdate (Default architecture) =
    architecture.update


getView : Architecture -> (Model -> List (Html Msg))
getView (Default architecture) =
    architecture.view


notFoundPage : ( PageSummary, Architecture )
notFoundPage =
    ( { page = NotFound
      , title = "Not Found"
      , description = ""
      , category = None
      , route = [ "404" ]
      }
    , Default
        { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
        , update = \msg model -> update msg model
        , view = \_ -> []
        }
    )


topPage : ( PageSummary, Architecture )
topPage =
    ( { page = Top
      , title = "Top"
      , description = ""
      , category = None
      , route = []
      }
    , Default
        { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
        , update = \msg model -> update msg model
        , view = \model -> tableOfContents { inverted = getShared model |> .darkMode }
        }
    )


sitePage : ( PageSummary, Architecture )
sitePage =
    ( { page = Site
      , title = "Site"
      , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
      , category = Globals
      , route = [ "site" ]
      }
    , Globals.architecture |> toArchitecture_Globals
    )


buttonPage : ( PageSummary, Architecture )
buttonPage =
    ( { page = Button
      , title = "Button"
      , description = "A button indicates a possible user action"
      , category = Elements
      , route = [ "button" ]
      }
    , Elements.architecture Button |> toArchitecture_Elements
    )


containerPage : ( PageSummary, Architecture )
containerPage =
    ( { page = Container
      , title = "Container"
      , description = "A container limits content to a maximum width"
      , category = Elements
      , route = [ "container" ]
      }
    , Elements.architecture Container |> toArchitecture_Elements
    )


dividerPage : ( PageSummary, Architecture )
dividerPage =
    ( { page = Divider
      , title = "Divider"
      , description = "A divider visually segments content into groups"
      , category = Elements
      , route = [ "divider" ]
      }
    , Elements.architecture Divider |> toArchitecture_Elements
    )


headerPage : ( PageSummary, Architecture )
headerPage =
    ( { page = Header
      , title = "Header"
      , description = "A header provides a short summary of content"
      , category = Elements
      , route = [ "header" ]
      }
    , Elements.architecture Header |> toArchitecture_Elements
    )


iconPage : ( PageSummary, Architecture )
iconPage =
    ( { page = Icon
      , title = "Icon"
      , description = "An icon is a glyph used to represent something else"
      , category = Elements
      , route = [ "icon" ]
      }
    , Elements.architecture Icon |> toArchitecture_Elements
    )


imagePage : ( PageSummary, Architecture )
imagePage =
    ( { page = Image
      , title = "Image"
      , description = "An image is a graphic representation of something"
      , category = Elements
      , route = [ "image" ]
      }
    , Elements.architecture Image |> toArchitecture_Elements
    )


inputPage : ( PageSummary, Architecture )
inputPage =
    ( { page = Input
      , title = "Input"
      , description = "An input is a field used to elicit a response from a user"
      , category = Elements
      , route = [ "input" ]
      }
    , Elements.architecture Input |> toArchitecture_Elements
    )


labelPage : ( PageSummary, Architecture )
labelPage =
    ( { page = Label
      , title = "Label"
      , description = "A label displays content classification"
      , category = Elements
      , route = [ "label" ]
      }
    , Elements.architecture Label |> toArchitecture_Elements
    )


loaderPage : ( PageSummary, Architecture )
loaderPage =
    ( { page = Loader
      , title = "Loader"
      , description = "A loader alerts a user to wait for an activity to complete"
      , category = Elements
      , route = [ "loader" ]
      }
    , Elements.architecture Loader |> toArchitecture_Elements
    )


placeholderPage : ( PageSummary, Architecture )
placeholderPage =
    ( { page = Placeholder
      , title = "Placeholder"
      , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
      , category = Elements
      , route = [ "placeholder" ]
      }
    , Elements.architecture Placeholder |> toArchitecture_Elements
    )


railPage : ( PageSummary, Architecture )
railPage =
    ( { page = Rail
      , title = "Rail"
      , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
      , category = Elements
      , route = [ "rail" ]
      }
    , Elements.architecture Rail |> toArchitecture_Elements
    )


segmentPage : ( PageSummary, Architecture )
segmentPage =
    ( { page = Segment
      , title = "Segment"
      , description = "A segment is used to create a grouping of related content"
      , category = Elements
      , route = [ "segment" ]
      }
    , Elements.architecture Segment |> toArchitecture_Elements
    )


stepPage : ( PageSummary, Architecture )
stepPage =
    ( { page = Step
      , title = "Step"
      , description = "A step shows the completion status of an activity in a series of activities"
      , category = Elements
      , route = [ "step" ]
      }
    , Elements.architecture Step |> toArchitecture_Elements
    )


circleStepPage : ( PageSummary, Architecture )
circleStepPage =
    ( { page = CircleStep
      , title = "Circle Step"
      , description = "A step shows the completion status of an activity in a series of activities"
      , category = Elements
      , route = [ "circle-step" ]
      }
    , Elements.architecture CircleStep |> toArchitecture_Elements
    )


textPage : ( PageSummary, Architecture )
textPage =
    ( { page = Text
      , title = "Text"
      , description = "A text is used to style some inline text with a simple color"
      , category = Elements
      , route = [ "text" ]
      }
    , Elements.architecture Text |> toArchitecture_Elements
    )


breadcrumbPage : ( PageSummary, Architecture )
breadcrumbPage =
    ( { page = Breadcrumb
      , title = "Breadcrumb"
      , description = "A breadcrumb is used to show hierarchy between content"
      , category = Collections
      , route = [ "breadcrumb" ]
      }
    , Collections.architecture Breadcrumb |> toArchitecture_Collections
    )


formPage : ( PageSummary, Architecture )
formPage =
    ( { page = Form
      , title = "Form"
      , description = "A form displays a set of related user input fields in a structured way"
      , category = Collections
      , route = [ "form" ]
      }
    , Collections.architecture Form |> toArchitecture_Collections
    )


gridPage : ( PageSummary, Architecture )
gridPage =
    ( { page = Grid
      , title = "Grid"
      , description = "A grid is used to harmonize negative space in a layout"
      , category = Collections
      , route = [ "grid" ]
      }
    , Collections.architecture Grid |> toArchitecture_Collections
    )


menuPage : ( PageSummary, Architecture )
menuPage =
    ( { page = Menu
      , title = "Menu"
      , description = "A menu displays grouped navigation actions"
      , category = Collections
      , route = [ "menu" ]
      }
    , Collections.architecture Menu |> toArchitecture_Collections
    )


messagePage : ( PageSummary, Architecture )
messagePage =
    ( { page = Message
      , title = "Message"
      , description = "A message displays information that explains nearby content"
      , category = Collections
      , route = [ "message" ]
      }
    , Collections.architecture Message |> toArchitecture_Collections
    )


tablePage : ( PageSummary, Architecture )
tablePage =
    ( { page = Table
      , title = "Table"
      , description = "A table displays a collections of data grouped into rows"
      , category = Collections
      , route = [ "table" ]
      }
    , Collections.architecture Table |> toArchitecture_Collections
    )


cardPage : ( PageSummary, Architecture )
cardPage =
    ( { page = Card
      , title = "Card"
      , description = "A card displays site content in a manner similar to a playing card"
      , category = Views
      , route = [ "card" ]
      }
    , Views.architecture Card |> toArchitecture_Views
    )


itemPage : ( PageSummary, Architecture )
itemPage =
    ( { page = Item
      , title = "Item"
      , description = "An item view presents large collections of site content for display"
      , category = Views
      , route = [ "item" ]
      }
    , Views.architecture Item |> toArchitecture_Views
    )


accordionPage : ( PageSummary, Architecture )
accordionPage =
    ( { page = Accordion
      , title = "Accordion"
      , description = "An accordion allows users to toggle the display of sections of content"
      , category = Modules
      , route = [ "accordion" ]
      }
    , Modules.architecture Accordion |> toArchitecture_Modules
    )


checkboxPage : ( PageSummary, Architecture )
checkboxPage =
    ( { page = Checkbox
      , title = "Checkbox"
      , description = "A checkbox allows a user to select a value from a small set of options, often binary"
      , category = Modules
      , route = [ "checkbox" ]
      }
    , Modules.architecture Checkbox |> toArchitecture_Modules
    )


dimmerPage : ( PageSummary, Architecture )
dimmerPage =
    ( { page = Dimmer
      , title = "Dimmer"
      , description = "A dimmer hides distractions to focus attention on particular content"
      , category = Modules
      , route = [ "dimmer" ]
      }
    , Modules.architecture Dimmer |> toArchitecture_Modules
    )


modalPage : ( PageSummary, Architecture )
modalPage =
    ( { page = Modal
      , title = "Modal"
      , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
      , category = Modules
      , route = [ "modal" ]
      }
    , Modules.architecture Modal |> toArchitecture_Modules
    )


progressPage : ( PageSummary, Architecture )
progressPage =
    ( { page = Progress
      , title = "Progress"
      , description = "A progress bar shows the progression of a task"
      , category = Modules
      , route = [ "progress" ]
      }
    , Modules.architecture Progress |> toArchitecture_Modules
    )


tabPage : ( PageSummary, Architecture )
tabPage =
    ( { page = Tab
      , title = "Tab"
      , description = "A tab is a hidden section of content activated by a menu"
      , category = Modules
      , route = [ "tab" ]
      }
    , Modules.architecture Tab |> toArchitecture_Modules
    )


sortableTablePage : ( PageSummary, Architecture )
sortableTablePage =
    ( { page = SortableTable
      , title = "SortableTable"
      , description = "Sortable table"
      , category = Defiant
      , route = [ "sortable-table" ]
      }
    , Defiant.architecture SortableTable |> toArchitecture_Defiant
    )


holyGrailPage : ( PageSummary, Architecture )
holyGrailPage =
    ( { page = HolyGrail
      , title = "HolyGrail"
      , description = "Holy grail layout."
      , category = Defiant
      , route = [ "holy-grail" ]
      }
    , Defiant.architecture HolyGrail |> toArchitecture_Defiant
    )


allPages : List ( PageSummary, Architecture )
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
