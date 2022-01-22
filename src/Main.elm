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
    { subModel : SubModel
    , architecture : Architecture
    }


type SubModel
    = NoneModel Shared
    | GlobalsModel Globals.Model
    | ElementsModel Elements.Model
    | CollectionsModel Collections.Model
    | ViewsModel Views.Model
    | ModulesModel Modules.Model
    | DefiantModel Defiant.Model


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
        { page = NotFound
        , title = "Not Found"
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
        { page = Top
        , title = "Top"
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
    { page = Site
    , title = "Site"
    , description = "A site is a set of global constraints that define the basic parameters of all UI elements"
    , category = Globals
    , route = [ "site" ]
    }


buttonPage : PageSummary
buttonPage =
    { page = Button
    , title = "Button"
    , description = "A button indicates a possible user action"
    , category = Elements
    , route = [ "button" ]
    }


containerPage : PageSummary
containerPage =
    { page = Container
    , title = "Container"
    , description = "A container limits content to a maximum width"
    , category = Elements
    , route = [ "container" ]
    }


dividerPage : PageSummary
dividerPage =
    { page = Divider
    , title = "Divider"
    , description = "A divider visually segments content into groups"
    , category = Elements
    , route = [ "divider" ]
    }


headerPage : PageSummary
headerPage =
    { page = Header
    , title = "Header"
    , description = "A header provides a short summary of content"
    , category = Elements
    , route = [ "header" ]
    }


iconPage : PageSummary
iconPage =
    { page = Icon
    , title = "Icon"
    , description = "An icon is a glyph used to represent something else"
    , category = Elements
    , route = [ "icon" ]
    }


imagePage : PageSummary
imagePage =
    { page = Image
    , title = "Image"
    , description = "An image is a graphic representation of something"
    , category = Elements
    , route = [ "image" ]
    }


inputPage : PageSummary
inputPage =
    { page = Input
    , title = "Input"
    , description = "An input is a field used to elicit a response from a user"
    , category = Elements
    , route = [ "input" ]
    }


labelPage : PageSummary
labelPage =
    { page = Label
    , title = "Label"
    , description = "A label displays content classification"
    , category = Elements
    , route = [ "label" ]
    }


loaderPage : PageSummary
loaderPage =
    { page = Loader
    , title = "Loader"
    , description = "A loader alerts a user to wait for an activity to complete"
    , category = Elements
    , route = [ "loader" ]
    }


placeholderPage : PageSummary
placeholderPage =
    { page = Placeholder
    , title = "Placeholder"
    , description = "A placeholder is used to reserve splace for content that soon will appear in a layout"
    , category = Elements
    , route = [ "placeholder" ]
    }


railPage : PageSummary
railPage =
    { page = Rail
    , title = "Rail"
    , description = "A rail is used to show accompanying content outside the boundaries of the main view of a site"
    , category = Elements
    , route = [ "rail" ]
    }


segmentPage : PageSummary
segmentPage =
    { page = Segment
    , title = "Segment"
    , description = "A segment is used to create a grouping of related content"
    , category = Elements
    , route = [ "segment" ]
    }


stepPage : PageSummary
stepPage =
    { page = Step
    , title = "Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "step" ]
    }


circleStepPage : PageSummary
circleStepPage =
    { page = CircleStep
    , title = "Circle Step"
    , description = "A step shows the completion status of an activity in a series of activities"
    , category = Elements
    , route = [ "circle-step" ]
    }


textPage : PageSummary
textPage =
    { page = Text
    , title = "Text"
    , description = "A text is used to style some inline text with a simple color"
    , category = Elements
    , route = [ "text" ]
    }


breadcrumbPage : PageSummary
breadcrumbPage =
    { page = Breadcrumb
    , title = "Breadcrumb"
    , description = "A breadcrumb is used to show hierarchy between content"
    , category = Collections
    , route = [ "breadcrumb" ]
    }


formPage : PageSummary
formPage =
    { page = Form
    , title = "Form"
    , description = "A form displays a set of related user input fields in a structured way"
    , category = Collections
    , route = [ "form" ]
    }


gridPage : PageSummary
gridPage =
    { page = Grid
    , title = "Grid"
    , description = "A grid is used to harmonize negative space in a layout"
    , category = Collections
    , route = [ "grid" ]
    }


menuPage : PageSummary
menuPage =
    { page = Menu
    , title = "Menu"
    , description = "A menu displays grouped navigation actions"
    , category = Collections
    , route = [ "menu" ]
    }


messagePage : PageSummary
messagePage =
    { page = Message
    , title = "Message"
    , description = "A message displays information that explains nearby content"
    , category = Collections
    , route = [ "message" ]
    }


tablePage : PageSummary
tablePage =
    { page = Table
    , title = "Table"
    , description = "A table displays a collections of data grouped into rows"
    , category = Collections
    , route = [ "table" ]
    }


cardPage : PageSummary
cardPage =
    { page = Card
    , title = "Card"
    , description = "A card displays site content in a manner similar to a playing card"
    , category = Views
    , route = [ "card" ]
    }


itemPage : PageSummary
itemPage =
    { page = Item
    , title = "Item"
    , description = "An item view presents large collections of site content for display"
    , category = Views
    , route = [ "item" ]
    }


accordionPage : PageSummary
accordionPage =
    { page = Accordion
    , title = "Accordion"
    , description = "An accordion allows users to toggle the display of sections of content"
    , category = Modules
    , route = [ "accordion" ]
    }


checkboxPage : PageSummary
checkboxPage =
    { page = Checkbox
    , title = "Checkbox"
    , description = "A checkbox allows a user to select a value from a small set of options, often binary"
    , category = Modules
    , route = [ "checkbox" ]
    }


dimmerPage : PageSummary
dimmerPage =
    { page = Dimmer
    , title = "Dimmer"
    , description = "A dimmer hides distractions to focus attention on particular content"
    , category = Modules
    , route = [ "dimmer" ]
    }


modalPage : PageSummary
modalPage =
    { page = Modal
    , title = "Modal"
    , description = "A modal displays content that temporarily blocks interactions with the main view of a site"
    , category = Modules
    , route = [ "modal" ]
    }


progressPage : PageSummary
progressPage =
    { page = Progress
    , title = "Progress"
    , description = "A progress bar shows the progression of a task"
    , category = Modules
    , route = [ "progress" ]
    }


tabPage : PageSummary
tabPage =
    { page = Tab
    , title = "Tab"
    , description = "A tab is a hidden section of content activated by a menu"
    , category = Modules
    , route = [ "tab" ]
    }


sortableTablePage : PageSummary
sortableTablePage =
    { page = SortableTable
    , title = "SortableTable"
    , description = "Sortable table"
    , category = Defiant
    , route = [ "sortable-table" ]
    }


holyGrailPage : PageSummary
holyGrailPage =
    { page = HolyGrail
    , title = "HolyGrail"
    , description = "Holy grail layout."
    , category = Defiant
    , route = [ "holy-grail" ]
    }


allPages : List { pageSummary : PageSummary, architecture : Architecture }
allPages =
    [ notFoundPage
    , topPage

    -- Globals
    , { pageSummary = sitePage
      , architecture = Globals.architecture |> toArchitecture_Globals
      }

    -- Elements
    , { pageSummary = buttonPage
      , architecture = Button |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = containerPage
      , architecture = Container |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = dividerPage
      , architecture = Divider |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = headerPage
      , architecture = Header |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = iconPage
      , architecture = Icon |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = imagePage
      , architecture = Image |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = inputPage
      , architecture = Input |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = labelPage
      , architecture = Label |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = loaderPage
      , architecture = Loader |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = placeholderPage
      , architecture = Placeholder |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = railPage
      , architecture = Rail |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = segmentPage
      , architecture = Segment |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = stepPage
      , architecture = Step |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = circleStepPage
      , architecture = CircleStep |> Elements.architecture |> toArchitecture_Elements
      }
    , { pageSummary = textPage
      , architecture = Text |> Elements.architecture |> toArchitecture_Elements
      }

    -- Collections
    , { pageSummary = breadcrumbPage
      , architecture = Breadcrumb |> Collections.architecture |> toArchitecture_Collections
      }
    , { pageSummary = formPage
      , architecture = Form |> Collections.architecture |> toArchitecture_Collections
      }
    , { pageSummary = gridPage
      , architecture = Grid |> Collections.architecture |> toArchitecture_Collections
      }
    , { pageSummary = menuPage
      , architecture = Menu |> Collections.architecture |> toArchitecture_Collections
      }
    , { pageSummary = messagePage
      , architecture = Message |> Collections.architecture |> toArchitecture_Collections
      }
    , { pageSummary = tablePage
      , architecture = Table |> Collections.architecture |> toArchitecture_Collections
      }

    -- Views
    , { pageSummary = cardPage
      , architecture = Card |> Views.architecture |> toArchitecture_Views
      }
    , { pageSummary = itemPage
      , architecture = Item |> Views.architecture |> toArchitecture_Views
      }

    -- Modules
    , { pageSummary = accordionPage
      , architecture = Accordion |> Modules.architecture |> toArchitecture_Modules
      }
    , { pageSummary = checkboxPage
      , architecture = Checkbox |> Modules.architecture |> toArchitecture_Modules
      }
    , { pageSummary = dimmerPage
      , architecture = Dimmer |> Modules.architecture |> toArchitecture_Modules
      }
    , { pageSummary = modalPage
      , architecture = Modal |> Modules.architecture |> toArchitecture_Modules
      }
    , { pageSummary = progressPage
      , architecture = Progress |> Modules.architecture |> toArchitecture_Modules
      }
    , { pageSummary = tabPage
      , architecture = Tab |> Modules.architecture |> toArchitecture_Modules
      }

    -- Defiant
    , { pageSummary = sortableTablePage
      , architecture = SortableTable |> Defiant.architecture |> toArchitecture_Defiant
      }
    , { pageSummary = holyGrailPage
      , architecture = HolyGrail |> Defiant.architecture |> toArchitecture_Defiant
      }
    ]


toArchitecture_Globals : Globals.Architecture -> Architecture
toArchitecture_Globals architecture =
    { init =
        \model ->
            architecture.init (getShared model)
                |> updateWith GlobalsModel GlobalsMsg model
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
            architecture.init (getShared model)
                |> updateWith ElementsModel ElementsMsg model
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
            architecture.init (getShared model)
                |> updateWith CollectionsModel CollectionsMsg model
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
            architecture.init (getShared model)
                |> updateWith ViewsModel ViewsMsg model
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
            architecture.init (getShared model)
                |> updateWith ModulesModel ModulesMsg model
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
            architecture.init (getShared model)
                |> updateWith DefiantModel DefiantMsg model
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
