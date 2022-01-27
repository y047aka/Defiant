module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Navigation as Nav exposing (Key)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Data.Category as Category exposing (Category(..))
import Html.Styled as Html exposing (Html, a, div, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (for, href, id, type_)
import Html.Styled.Events exposing (onClick)
import Page.Collections.Breadcrumb as Breadcrumb
import Page.Collections.Form as Form
import Page.Collections.Grid as Grid
import Page.Collections.Menu as Menu
import Page.Collections.Message as Message
import Page.Collections.Table as Table
import Page.Defiant.HolyGrail as HolyGrail
import Page.Defiant.SortableTable as SortableTable
import Page.Elements.Button as Button
import Page.Elements.CircleStep as CircleStep
import Page.Elements.Container as Container
import Page.Elements.Divider as Divider
import Page.Elements.Header as Header
import Page.Elements.Icon as Icon
import Page.Elements.Image as Image
import Page.Elements.Input as Input
import Page.Elements.Label as Label
import Page.Elements.Loader as Loader
import Page.Elements.Placeholder as Placeholder
import Page.Elements.Rail as Rail
import Page.Elements.Segment as Segment
import Page.Elements.Step as Step
import Page.Elements.Text as Text
import Page.Globals.Site as Site
import Page.Modules.Accordion as Accordion
import Page.Modules.Checkbox as Checkbox
import Page.Modules.Dimmer as Dimmer
import Page.Modules.Modal as Modal
import Page.Modules.Progress as Progress
import Page.Modules.Tab as Tab
import Page.Views.Card as Card
import Page.Views.Item as Item
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
    { subModel : SubModel
    , architecture : Architecture
    }


type SubModel
    = NoneModel Shared
      -- Globals
    | SiteModel Site.Model
      -- Elements
    | ButtonModel Button.Model
    | ContainerModel Container.Model
    | DividerModel Divider.Model
    | HeaderModel Header.Model
    | IconModel Icon.Model
    | ImageModel Image.Model
    | InputModel Input.Model
    | LabelModel Label.Model
    | LoaderModel Loader.Model
    | PlaceholderModel Placeholder.Model
    | RailModel Rail.Model
    | SegmentModel Segment.Model
    | StepModel Step.Model
    | CircleStepModel CircleStep.Model
    | TextModel Text.Model
      -- Collections
    | BreadcrumbModel Breadcrumb.Model
    | FormModel Form.Model
    | GridModel Grid.Model
    | MenuModel Menu.Model
    | MessageModel Message.Model
    | TableModel Table.Model
      -- Views
    | CardModel Card.Model
    | ItemModel Item.Model
      -- Modules
    | AccordionModel Accordion.Model
    | CheckboxModel Checkbox.Model
    | DimmerModel Dimmer.Model
    | ModalModel Modal.Model
    | ProgressModel Progress.Model
    | TabModel Tab.Model
      -- Defiant
    | SortableTableModel SortableTable.Model
    | HolyGrailModel HolyGrail.Model


type Architecture
    = Default
        { init : Model -> ( Model, Cmd Msg )
        , update : Msg -> Model -> ( Model, Cmd Msg )
        , view : Model -> List (Html Msg)
        }


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    { architecture =
        Default
            { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
            , update = \msg model -> update msg model
            , view = \_ -> []
            }
    , subModel = NoneModel (Shared.init key notFoundPage.pageSummary)
    }
        |> routing url



-- ROUTER


parser : Parser ({ pageSummary : PageSummary, architecture : Architecture } -> a) a
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
        List.map (\page -> Parser.map page (pageParser page.pageSummary.route)) allPages


routing : Url -> Model -> ( Model, Cmd Msg )
routing url prevModel =
    let
        shared =
            getShared prevModel
    in
    Parser.parse parser url
        |> Maybe.withDefault notFoundPage
        |> (\{ pageSummary, architecture } ->
                let
                    model =
                        { prevModel
                            | architecture = architecture
                            , subModel =
                                prevModel.subModel
                                    |> setShared (setPageSummary pageSummary shared)
                        }
                in
                (\(Default architecture_) -> architecture_.init model) architecture
           )



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
    | ToggleDarkMode
      -- Globals
    | SiteMsg Site.Msg
      -- Elements
    | ButtonMsg Button.Msg
    | ContainerMsg Container.Msg
    | DividerMsg Divider.Msg
    | HeaderMsg Header.Msg
    | IconMsg Icon.Msg
    | ImageMsg Image.Msg
    | InputMsg Input.Msg
    | LabelMsg Label.Msg
    | LoaderMsg Loader.Msg
    | PlaceholderMsg Placeholder.Msg
    | RailMsg Rail.Msg
    | SegmentMsg Segment.Msg
    | StepMsg Step.Msg
    | CircleStepMsg CircleStep.Msg
    | TextMsg Text.Msg
      -- Collections
    | BreadcrumbMsg Breadcrumb.Msg
    | FormMsg Form.Msg
    | GridMsg Grid.Msg
    | MenuMsg Menu.Msg
    | MessageMsg Message.Msg
    | TableMsg Table.Msg
      -- Views
    | CardMsg Card.Msg
    | ItemMsg Item.Msg
      -- Modules
    | AccordionMsg Accordion.Msg
    | CheckboxMsg Checkbox.Msg
    | DimmerMsg Dimmer.Msg
    | ModalMsg Modal.Msg
    | ProgressMsg Progress.Msg
    | TabMsg Tab.Msg
      -- Defiant
    | SortableTableMsg SortableTable.Msg
    | HolyGrailMsg HolyGrail.Msg


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
            (\(Default architecture_) -> architecture_.update msg model) model.architecture


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

        -- Globals
        SiteModel { shared } ->
            shared

        -- Elements
        ButtonModel { shared } ->
            shared

        ContainerModel { shared } ->
            shared

        DividerModel { shared } ->
            shared

        HeaderModel { shared } ->
            shared

        IconModel { shared } ->
            shared

        ImageModel { shared } ->
            shared

        InputModel { shared } ->
            shared

        LabelModel { shared } ->
            shared

        LoaderModel { shared } ->
            shared

        PlaceholderModel { shared } ->
            shared

        RailModel { shared } ->
            shared

        SegmentModel { shared } ->
            shared

        StepModel { shared } ->
            shared

        CircleStepModel { shared } ->
            shared

        TextModel { shared } ->
            shared

        -- Collections
        BreadcrumbModel { shared } ->
            shared

        FormModel { shared } ->
            shared

        GridModel { shared } ->
            shared

        MenuModel { shared } ->
            shared

        MessageModel { shared } ->
            shared

        TableModel { shared } ->
            shared

        -- Views
        CardModel { shared } ->
            shared

        ItemModel { shared } ->
            shared

        -- Modules
        AccordionModel { shared } ->
            shared

        CheckboxModel { shared } ->
            shared

        DimmerModel { shared } ->
            shared

        ModalModel { shared } ->
            shared

        ProgressModel { shared } ->
            shared

        TabModel { shared } ->
            shared

        -- Defiant
        SortableTableModel { shared } ->
            shared

        HolyGrailModel { shared } ->
            shared


setShared : Shared -> SubModel -> SubModel
setShared shared subModel =
    case subModel of
        NoneModel _ ->
            NoneModel shared

        -- Globals
        SiteModel model ->
            SiteModel { model | shared = shared }

        -- Elements
        ButtonModel model ->
            ButtonModel { model | shared = shared }

        ContainerModel model ->
            ContainerModel { model | shared = shared }

        DividerModel model ->
            DividerModel { model | shared = shared }

        HeaderModel model ->
            HeaderModel { model | shared = shared }

        IconModel model ->
            IconModel { model | shared = shared }

        ImageModel model ->
            ImageModel { model | shared = shared }

        InputModel model ->
            InputModel { model | shared = shared }

        LabelModel model ->
            LabelModel { model | shared = shared }

        LoaderModel model ->
            LoaderModel { model | shared = shared }

        PlaceholderModel model ->
            PlaceholderModel { model | shared = shared }

        RailModel model ->
            RailModel { model | shared = shared }

        SegmentModel model ->
            SegmentModel { model | shared = shared }

        StepModel model ->
            StepModel { model | shared = shared }

        CircleStepModel model ->
            CircleStepModel { model | shared = shared }

        TextModel model ->
            TextModel { model | shared = shared }

        -- Collections
        BreadcrumbModel model ->
            BreadcrumbModel { model | shared = shared }

        FormModel model ->
            FormModel { model | shared = shared }

        GridModel model ->
            GridModel { model | shared = shared }

        MenuModel model ->
            MenuModel { model | shared = shared }

        MessageModel model ->
            MessageModel { model | shared = shared }

        TableModel model ->
            TableModel { model | shared = shared }

        -- Views
        CardModel model ->
            CardModel { model | shared = shared }

        ItemModel model ->
            ItemModel { model | shared = shared }

        -- Modules
        AccordionModel model ->
            AccordionModel { model | shared = shared }

        CheckboxModel model ->
            CheckboxModel { model | shared = shared }

        DimmerModel model ->
            DimmerModel { model | shared = shared }

        ModalModel model ->
            ModalModel { model | shared = shared }

        ProgressModel model ->
            ProgressModel { model | shared = shared }

        TabModel model ->
            TabModel { model | shared = shared }

        -- Defiant
        SortableTableModel model ->
            SortableTableModel { model | shared = shared }

        HolyGrailModel model ->
            HolyGrailModel { model | shared = shared }



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
            (\(Default architecture_) -> architecture_.view model) model.architecture
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
                        (\{ pageSummary } ->
                            if pageSummary.category == category then
                                Just (item pageSummary)

                            else
                                Nothing
                        )
                        allPages
                    )
                ]
        )
        [ Globals, Elements, Collections, Views, Modules, Defiant ]


notFoundPage : { pageSummary : PageSummary, architecture : Architecture }
notFoundPage =
    { pageSummary =
        { title = "Not Found"
        , description = ""
        , category = None
        , route = [ "404" ]
        }
    , architecture =
        Default
            { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
            , update = \msg model -> update msg model
            , view = \_ -> []
            }
    }


topPage : { pageSummary : PageSummary, architecture : Architecture }
topPage =
    { pageSummary =
        { title = "Top"
        , description = ""
        , category = None
        , route = []
        }
    , architecture =
        Default
            { init = \model -> ( { model | subModel = NoneModel (getShared model) }, Cmd.none )
            , update = \msg model -> update msg model
            , view = \model -> tableOfContents { inverted = getShared model |> .darkMode }
            }
    }


sitePage : PageSummary
sitePage =
    { title = "Site"
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Globals
    , route = [ "site" ]
    }


buttonPage : PageSummary
buttonPage =
    { title = "Button"
    , description = "A button indicates a possible user action"
    , category = Elements
    , route = [ "button" ]
    }


containerPage : PageSummary
containerPage =
    { title = "Container"
    , description = "A container limits content to a maximum width"
    , category = Elements
    , route = [ "container" ]
    }


dividerPage : PageSummary
dividerPage =
    { title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Elements
    , route = [ "divider" ]
    }


headerPage : PageSummary
headerPage =
    { title = "Header"
    , description = "A header provides a short summary of content"
    , category = Elements
    , route = [ "header" ]
    }


iconPage : PageSummary
iconPage =
    { title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Elements
    , route = [ "icon" ]
    }


imagePage : PageSummary
imagePage =
    { title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Elements
    , route = [ "image" ]
    }


inputPage : PageSummary
inputPage =
    { title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Elements
    , route = [ "input" ]
    }


labelPage : PageSummary
labelPage =
    { title = "Label"
    , description = "A label displays content classification"
    , category = Elements
    , route = [ "label" ]
    }


loaderPage : PageSummary
loaderPage =
    { title = "Loader"
    , description = "A loader alerts a user to wait for an activity to complete"
    , category = Elements
    , route = [ "loader" ]
    }


placeholderPage : PageSummary
placeholderPage =
    { title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Elements
    , route = [ "placeholder" ]
    }


railPage : PageSummary
railPage =
    { title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Elements
    , route = [ "rail" ]
    }


segmentPage : PageSummary
segmentPage =
    { title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Elements
    , route = [ "segment" ]
    }


stepPage : PageSummary
stepPage =
    { title = "Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "step" ]
    }


circleStepPage : PageSummary
circleStepPage =
    { title = "Circle Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "circle-step" ]
    }


textPage : PageSummary
textPage =
    { title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Elements
    , route = [ "text" ]
    }


breadcrumbPage : PageSummary
breadcrumbPage =
    { title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Collections
    , route = [ "breadcrumb" ]
    }


formPage : PageSummary
formPage =
    { title = "Form"
    , description = "A form displays a set of related user input fields in a structured way"
    , category = Collections
    , route = [ "form" ]
    }


gridPage : PageSummary
gridPage =
    { title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Collections
    , route = [ "grid" ]
    }


menuPage : PageSummary
menuPage =
    { title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Collections
    , route = [ "menu" ]
    }


messagePage : PageSummary
messagePage =
    { title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Collections
    , route = [ "message" ]
    }


tablePage : PageSummary
tablePage =
    { title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = Collections
    , route = [ "table" ]
    }


cardPage : PageSummary
cardPage =
    { title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = Views
    , route = [ "card" ]
    }


itemPage : PageSummary
itemPage =
    { title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = Views
    , route = [ "item" ]
    }


accordionPage : PageSummary
accordionPage =
    { title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Modules
    , route = [ "accordion" ]
    }


checkboxPage : PageSummary
checkboxPage =
    { title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Modules
    , route = [ "checkbox" ]
    }


dimmerPage : PageSummary
dimmerPage =
    { title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Modules
    , route = [ "dimmer" ]
    }


modalPage : PageSummary
modalPage =
    { title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Modules
    , route = [ "modal" ]
    }


progressPage : PageSummary
progressPage =
    { title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Modules
    , route = [ "progress" ]
    }


tabPage : PageSummary
tabPage =
    { title = "Tab"
    , description = "A tab is a hidden section of content activated by a menu"
    , category = Modules
    , route = [ "tab" ]
    }


sortableTablePage : PageSummary
sortableTablePage =
    { title = "SortableTable"
    , description = "Sortable table"
    , category = Defiant
    , route = [ "sortable-table" ]
    }


holyGrailPage : PageSummary
holyGrailPage =
    { title = "HolyGrail"
    , description = "Holy grail layout."
    , category = Defiant
    , route = [ "holy-grail" ]
    }


allPages : List { pageSummary : PageSummary, architecture : Architecture }
allPages =
    [ notFoundPage
    , topPage

    -- Globals
    , { pageSummary = sitePage, architecture = siteArchitecture }

    -- Elements
    , { pageSummary = buttonPage, architecture = buttonArchitecture }
    , { pageSummary = containerPage, architecture = containerArchitecture }
    , { pageSummary = dividerPage, architecture = dividerArchitecture }
    , { pageSummary = headerPage, architecture = headerArchitecture }
    , { pageSummary = iconPage, architecture = iconArchitecture }
    , { pageSummary = imagePage, architecture = imageArchitecture }
    , { pageSummary = inputPage, architecture = inputArchitecture }
    , { pageSummary = labelPage, architecture = labelArchitecture }
    , { pageSummary = loaderPage, architecture = loaderArchitecture }
    , { pageSummary = placeholderPage, architecture = placeholderArchitecture }
    , { pageSummary = railPage, architecture = railArchitecture }
    , { pageSummary = segmentPage, architecture = segmentArchitecture }
    , { pageSummary = stepPage, architecture = stepArchitecture }
    , { pageSummary = circleStepPage, architecture = circleStepArchitecture }
    , { pageSummary = textPage, architecture = textArchitecture }

    -- Collections
    , { pageSummary = breadcrumbPage, architecture = breadcrumbArchitecture }
    , { pageSummary = formPage, architecture = formArchitecture }
    , { pageSummary = gridPage, architecture = gridArchitecture }
    , { pageSummary = menuPage, architecture = menuArchitecture }
    , { pageSummary = messagePage, architecture = messageArchitecture }
    , { pageSummary = tablePage, architecture = tableArchitecture }

    -- Views
    , { pageSummary = cardPage, architecture = cardArchitecture }
    , { pageSummary = itemPage, architecture = itemArchitecture }

    -- Modules
    , { pageSummary = accordionPage, architecture = accordionArchitecture }
    , { pageSummary = checkboxPage, architecture = checkboxArchitecture }
    , { pageSummary = dimmerPage, architecture = dimmerArchitecture }
    , { pageSummary = modalPage, architecture = modalArchitecture }
    , { pageSummary = progressPage, architecture = progressArchitecture }
    , { pageSummary = tabPage, architecture = tabArchitecture }

    -- Defiant
    , { pageSummary = sortableTablePage, architecture = sortableTableArchitecture }
    , { pageSummary = holyGrailPage, architecture = holyGrailArchitecture }
    ]


siteArchitecture : Architecture
siteArchitecture =
    let
        architecture =
            Site.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith SiteModel SiteMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( SiteModel subModel, SiteMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith SiteModel SiteMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                SiteModel model ->
                    architecture.view model
                        |> List.map (Html.map SiteMsg)

                _ ->
                    []
    }
        |> Default


buttonArchitecture : Architecture
buttonArchitecture =
    let
        architecture =
            Button.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith ButtonModel ButtonMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( ButtonModel subModel, ButtonMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith ButtonModel ButtonMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                ButtonModel model ->
                    architecture.view model
                        |> List.map (Html.map ButtonMsg)

                _ ->
                    []
    }
        |> Default


containerArchitecture : Architecture
containerArchitecture =
    let
        architecture =
            Container.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith ContainerModel ContainerMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( ContainerModel subModel, ContainerMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith ContainerModel ContainerMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                ContainerModel model ->
                    architecture.view model
                        |> List.map (Html.map ContainerMsg)

                _ ->
                    []
    }
        |> Default


dividerArchitecture : Architecture
dividerArchitecture =
    let
        architecture =
            Divider.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith DividerModel DividerMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( DividerModel subModel, DividerMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith DividerModel DividerMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                DividerModel model ->
                    architecture.view model
                        |> List.map (Html.map DividerMsg)

                _ ->
                    []
    }
        |> Default


headerArchitecture : Architecture
headerArchitecture =
    let
        architecture =
            Header.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith HeaderModel HeaderMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( HeaderModel subModel, HeaderMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith HeaderModel HeaderMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                HeaderModel model ->
                    architecture.view model
                        |> List.map (Html.map HeaderMsg)

                _ ->
                    []
    }
        |> Default


iconArchitecture : Architecture
iconArchitecture =
    let
        architecture =
            Icon.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith IconModel IconMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( IconModel subModel, IconMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith IconModel IconMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                IconModel model ->
                    architecture.view model
                        |> List.map (Html.map IconMsg)

                _ ->
                    []
    }
        |> Default


imageArchitecture : Architecture
imageArchitecture =
    let
        architecture =
            Image.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith ImageModel ImageMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( ImageModel subModel, ImageMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith ImageModel ImageMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                ImageModel model ->
                    architecture.view model
                        |> List.map (Html.map ImageMsg)

                _ ->
                    []
    }
        |> Default


inputArchitecture : Architecture
inputArchitecture =
    let
        architecture =
            Input.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith InputModel InputMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( InputModel subModel, InputMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith InputModel InputMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                InputModel model ->
                    architecture.view model
                        |> List.map (Html.map InputMsg)

                _ ->
                    []
    }
        |> Default


labelArchitecture : Architecture
labelArchitecture =
    let
        architecture =
            Label.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith LabelModel LabelMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( LabelModel subModel, LabelMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith LabelModel LabelMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                LabelModel model ->
                    architecture.view model
                        |> List.map (Html.map LabelMsg)

                _ ->
                    []
    }
        |> Default


loaderArchitecture : Architecture
loaderArchitecture =
    let
        architecture =
            Loader.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith LoaderModel LoaderMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( LoaderModel subModel, LoaderMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith LoaderModel LoaderMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                LoaderModel model ->
                    architecture.view model
                        |> List.map (Html.map LoaderMsg)

                _ ->
                    []
    }
        |> Default


placeholderArchitecture : Architecture
placeholderArchitecture =
    let
        architecture =
            Placeholder.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith PlaceholderModel PlaceholderMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( PlaceholderModel subModel, PlaceholderMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith PlaceholderModel PlaceholderMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                PlaceholderModel model ->
                    architecture.view model
                        |> List.map (Html.map PlaceholderMsg)

                _ ->
                    []
    }
        |> Default


railArchitecture : Architecture
railArchitecture =
    let
        architecture =
            Rail.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith RailModel RailMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( RailModel subModel, RailMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith RailModel RailMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                RailModel model ->
                    architecture.view model
                        |> List.map (Html.map RailMsg)

                _ ->
                    []
    }
        |> Default


segmentArchitecture : Architecture
segmentArchitecture =
    let
        architecture =
            Segment.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith SegmentModel SegmentMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( SegmentModel subModel, SegmentMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith SegmentModel SegmentMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                SegmentModel model ->
                    architecture.view model
                        |> List.map (Html.map SegmentMsg)

                _ ->
                    []
    }
        |> Default


stepArchitecture : Architecture
stepArchitecture =
    let
        architecture =
            Step.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith StepModel StepMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( StepModel subModel, StepMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith StepModel StepMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                StepModel model ->
                    architecture.view model
                        |> List.map (Html.map StepMsg)

                _ ->
                    []
    }
        |> Default


circleStepArchitecture : Architecture
circleStepArchitecture =
    let
        architecture =
            CircleStep.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith CircleStepModel CircleStepMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( CircleStepModel subModel, CircleStepMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith CircleStepModel CircleStepMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                CircleStepModel model ->
                    architecture.view model
                        |> List.map (Html.map CircleStepMsg)

                _ ->
                    []
    }
        |> Default


textArchitecture : Architecture
textArchitecture =
    let
        architecture =
            Text.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith TextModel TextMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( TextModel subModel, TextMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith TextModel TextMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                TextModel model ->
                    architecture.view model
                        |> List.map (Html.map TextMsg)

                _ ->
                    []
    }
        |> Default


breadcrumbArchitecture : Architecture
breadcrumbArchitecture =
    let
        architecture =
            Breadcrumb.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith BreadcrumbModel BreadcrumbMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( BreadcrumbModel subModel, BreadcrumbMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith BreadcrumbModel BreadcrumbMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                BreadcrumbModel model ->
                    architecture.view model
                        |> List.map (Html.map BreadcrumbMsg)

                _ ->
                    []
    }
        |> Default


formArchitecture : Architecture
formArchitecture =
    let
        architecture =
            Form.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith FormModel FormMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( FormModel subModel, FormMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith FormModel FormMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                FormModel model ->
                    architecture.view model
                        |> List.map (Html.map FormMsg)

                _ ->
                    []
    }
        |> Default


gridArchitecture : Architecture
gridArchitecture =
    let
        architecture =
            Grid.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith GridModel GridMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( GridModel subModel, GridMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith GridModel GridMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                GridModel model ->
                    architecture.view model
                        |> List.map (Html.map GridMsg)

                _ ->
                    []
    }
        |> Default


menuArchitecture : Architecture
menuArchitecture =
    let
        architecture =
            Menu.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith MenuModel MenuMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( MenuModel subModel, MenuMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith MenuModel MenuMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                MenuModel model ->
                    architecture.view model
                        |> List.map (Html.map MenuMsg)

                _ ->
                    []
    }
        |> Default


messageArchitecture : Architecture
messageArchitecture =
    let
        architecture =
            Message.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith MessageModel MessageMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( MessageModel subModel, MessageMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith MessageModel MessageMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                MessageModel model ->
                    architecture.view model
                        |> List.map (Html.map MessageMsg)

                _ ->
                    []
    }
        |> Default


tableArchitecture : Architecture
tableArchitecture =
    let
        architecture =
            Table.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith TableModel TableMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( TableModel subModel, TableMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith TableModel TableMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                TableModel model ->
                    architecture.view model
                        |> List.map (Html.map TableMsg)

                _ ->
                    []
    }
        |> Default


cardArchitecture : Architecture
cardArchitecture =
    let
        architecture =
            Card.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith CardModel CardMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( CardModel subModel, CardMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith CardModel CardMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                CardModel model ->
                    architecture.view model
                        |> List.map (Html.map CardMsg)

                _ ->
                    []
    }
        |> Default


itemArchitecture : Architecture
itemArchitecture =
    let
        architecture =
            Item.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith ItemModel ItemMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( ItemModel subModel, ItemMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith ItemModel ItemMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                ItemModel model ->
                    architecture.view model
                        |> List.map (Html.map ItemMsg)

                _ ->
                    []
    }
        |> Default


accordionArchitecture : Architecture
accordionArchitecture =
    let
        architecture =
            Accordion.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith AccordionModel AccordionMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( AccordionModel subModel, AccordionMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith AccordionModel AccordionMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                AccordionModel model ->
                    architecture.view model
                        |> List.map (Html.map AccordionMsg)

                _ ->
                    []
    }
        |> Default


checkboxArchitecture : Architecture
checkboxArchitecture =
    let
        architecture =
            Checkbox.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith CheckboxModel CheckboxMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( CheckboxModel subModel, CheckboxMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith CheckboxModel CheckboxMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                CheckboxModel model ->
                    architecture.view model
                        |> List.map (Html.map CheckboxMsg)

                _ ->
                    []
    }
        |> Default


dimmerArchitecture : Architecture
dimmerArchitecture =
    let
        architecture =
            Dimmer.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith DimmerModel DimmerMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( DimmerModel subModel, DimmerMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith DimmerModel DimmerMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                DimmerModel model ->
                    architecture.view model
                        |> List.map (Html.map DimmerMsg)

                _ ->
                    []
    }
        |> Default


modalArchitecture : Architecture
modalArchitecture =
    let
        architecture =
            Modal.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith ModalModel ModalMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( ModalModel subModel, ModalMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith ModalModel ModalMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                ModalModel model ->
                    architecture.view model
                        |> List.map (Html.map ModalMsg)

                _ ->
                    []
    }
        |> Default


progressArchitecture : Architecture
progressArchitecture =
    let
        architecture =
            Progress.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith ProgressModel ProgressMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( ProgressModel subModel, ProgressMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith ProgressModel ProgressMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                ProgressModel model ->
                    architecture.view model
                        |> List.map (Html.map ProgressMsg)

                _ ->
                    []
    }
        |> Default


tabArchitecture : Architecture
tabArchitecture =
    let
        architecture =
            Tab.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith TabModel TabMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( TabModel subModel, TabMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith TabModel TabMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                TabModel model ->
                    architecture.view model
                        |> List.map (Html.map TabMsg)

                _ ->
                    []
    }
        |> Default


sortableTableArchitecture : Architecture
sortableTableArchitecture =
    let
        architecture =
            SortableTable.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith SortableTableModel SortableTableMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( SortableTableModel subModel, SortableTableMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith SortableTableModel SortableTableMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                SortableTableModel model ->
                    architecture.view model
                        |> List.map (Html.map SortableTableMsg)

                _ ->
                    []
    }
        |> Default


holyGrailArchitecture : Architecture
holyGrailArchitecture =
    let
        architecture =
            HolyGrail.architecture
    in
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith HolyGrailModel HolyGrailMsg model
    , update =
        \msg model ->
            case ( model.subModel, msg ) of
                ( HolyGrailModel subModel, HolyGrailMsg subMsg ) ->
                    architecture.update subMsg subModel
                        |> updateWith HolyGrailModel HolyGrailMsg model

                _ ->
                    ( model, Cmd.none )
    , view =
        \{ subModel } ->
            case subModel of
                HolyGrailModel model ->
                    architecture.view model
                        |> List.map (Html.map HolyGrailMsg)

                _ ->
                    []
    }
        |> Default
