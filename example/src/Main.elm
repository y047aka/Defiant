module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav exposing (Key)
import Data.PageSummary as PageSummary exposing (PageSummary)
import Data.Theme exposing (Theme(..))
import Html.Styled
import Layouts.Default
import Pages.DataDisplay.Card as Card
import Pages.DataDisplay.Item as Item
import Pages.DataDisplay.SortableData as SortableData
import Pages.DataDisplay.Table as Table
import Pages.Element.Button as Button
import Pages.Element.Dimmer as Dimmer
import Pages.Element.Divider as Divider
import Pages.Element.Header as Header
import Pages.Element.Icon as Icon
import Pages.Element.Image as Image
import Pages.Element.Label as Label
import Pages.Element.Loader as Loader
import Pages.Element.Message as Message
import Pages.Element.Placeholder as Placeholder
import Pages.Element.Segment as Segment
import Pages.Element.Text as Text
import Pages.Form.Checkbox as Checkbox
import Pages.Form.Form as Form
import Pages.Form.Input as Input
import Pages.Global.Site as Site
import Pages.Layout.Container as Container
import Pages.Layout.Grid as Grid
import Pages.Layout.HolyGrail as HolyGrail
import Pages.Layout.Modal as Modal
import Pages.Layout.Rail as Rail
import Pages.Navigation.Accordion as Accordion
import Pages.Navigation.Breadcrumb as Breadcrumb
import Pages.Navigation.Menu as Menu
import Pages.Navigation.Progress as Progress
import Pages.Navigation.Step as Step
import Pages.Navigation.Tab as Tab
import Pages.Top as Top
import Shared
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, s)


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



-- INIT


type alias Model =
    { url : Url
    , key : Key
    , subModel : SubModel
    , shared : Shared.Model
    }


type SubModel
    = None
    | TopModel
      -- Globals
    | SiteModel Site.Model
      -- Layouts
    | ContainerModel Container.Model
    | GridModel Grid.Model
    | HolyGrailModel HolyGrail.Model
    | ModalModel Modal.Model
    | RailModel Rail.Model
      -- Elements
    | ButtonModel Button.Model
    | DimmerModel Dimmer.Model
    | DividerModel Divider.Model
    | HeaderModel Header.Model
    | IconModel Icon.Model
    | ImageModel Image.Model
    | LabelModel Label.Model
    | LoaderModel Loader.Model
    | MessageModel Message.Model
    | PlaceholderModel Placeholder.Model
    | SegmentModel Segment.Model
    | TextModel Text.Model
      -- Navigations
    | AccordionModel Accordion.Model
    | BreadcrumbModel Breadcrumb.Model
    | MenuModel Menu.Model
    | ProgressModel Progress.Model
    | StepModel Step.Model
    | TabModel Tab.Model
      -- Forms
    | CheckboxModel Checkbox.Model
    | FormModel Form.Model
    | InputModel Input.Model
      -- Data Display
    | CardModel Card.Model
    | ItemModel Item.Model
    | SortableDataModel SortableData.Model
    | TableModel Table.Model


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    { url = url
    , key = key
    , subModel = TopModel
    , shared = Shared.init
    }
        |> routing url



-- ROUTER


parser : Parser (PageSummary -> a) a
parser =
    let
        pageParser route =
            case route of
                [] ->
                    Url.Parser.top

                [ category, page ] ->
                    s category </> s page

                _ ->
                    Url.Parser.top
    in
    Url.Parser.oneOf <|
        List.map (\page -> Url.Parser.map page (pageParser page.route)) (topPage :: PageSummary.all)


routing : Url -> Model -> ( Model, Cmd Msg )
routing url model =
    Url.Parser.parse parser url
        |> Maybe.withDefault notFoundPage
        |> (\{ title } ->
                case title of
                    "Top" ->
                        ( { model | subModel = TopModel }, Cmd.none )

                    "Site" ->
                        ( { model | subModel = SiteModel Site.init }, Cmd.none )

                    "Container" ->
                        ( { model | subModel = ContainerModel Container.init }, Cmd.none )

                    "Grid" ->
                        ( { model | subModel = GridModel Grid.init }, Cmd.none )

                    "Holy Grail" ->
                        ( { model | subModel = HolyGrailModel HolyGrail.init }, Cmd.none )

                    "Modal" ->
                        ( { model | subModel = ModalModel Modal.init }, Cmd.none )

                    "Rail" ->
                        ( { model | subModel = RailModel Rail.init }, Cmd.none )

                    "Button" ->
                        ( { model | subModel = ButtonModel Button.init }, Cmd.none )

                    "Dimmer" ->
                        ( { model | subModel = DimmerModel Dimmer.init }, Cmd.none )

                    "Divider" ->
                        ( { model | subModel = DividerModel Divider.init }, Cmd.none )

                    "Header" ->
                        ( { model | subModel = HeaderModel Header.init }, Cmd.none )

                    "Icon" ->
                        ( { model | subModel = IconModel Icon.init }, Cmd.none )

                    "Image" ->
                        ( { model | subModel = ImageModel Image.init }, Cmd.none )

                    "Label" ->
                        ( { model | subModel = LabelModel Label.init }, Cmd.none )

                    "Loader" ->
                        ( { model | subModel = LoaderModel Loader.init }, Cmd.none )

                    "Message" ->
                        ( { model | subModel = MessageModel Message.init }, Cmd.none )

                    "Placeholder" ->
                        ( { model | subModel = PlaceholderModel Placeholder.init }, Cmd.none )

                    "Segment" ->
                        ( { model | subModel = SegmentModel Segment.init }, Cmd.none )

                    "Text" ->
                        ( { model | subModel = TextModel Text.init }, Cmd.none )

                    "Accordion" ->
                        ( { model | subModel = AccordionModel Accordion.init }, Cmd.none )

                    "Breadcrumb" ->
                        ( { model | subModel = BreadcrumbModel Breadcrumb.init }, Cmd.none )

                    "Menu" ->
                        ( { model | subModel = MenuModel Menu.init }, Cmd.none )

                    "Progress" ->
                        Progress.init
                            |> map ProgressModel ProgressMsg model

                    "Step" ->
                        ( { model | subModel = StepModel Step.init }, Cmd.none )

                    "Tab" ->
                        ( { model | subModel = TabModel Tab.init }, Cmd.none )

                    "Checkbox" ->
                        ( { model | subModel = CheckboxModel Checkbox.init }, Cmd.none )

                    "Form" ->
                        ( { model | subModel = FormModel Form.init }, Cmd.none )

                    "Input" ->
                        ( { model | subModel = InputModel Input.init }, Cmd.none )

                    "Card" ->
                        ( { model | subModel = CardModel Card.init }, Cmd.none )

                    "Item" ->
                        ( { model | subModel = ItemModel Item.init }, Cmd.none )

                    "Sortable Data" ->
                        ( { model | subModel = SortableDataModel SortableData.init }, Cmd.none )

                    "Table" ->
                        ( { model | subModel = TableModel Table.init }, Cmd.none )

                    _ ->
                        ( { model | subModel = None }, Cmd.none )
           )


notFoundPage : PageSummary
notFoundPage =
    { title = "Not Found"
    , description = ""
    , category = PageSummary.None
    , route = [ "404" ]
    }


topPage : PageSummary
topPage =
    { title = "Top"
    , description = ""
    , category = PageSummary.None
    , route = []
    }



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
    | Shared Shared.Msg
      -- Globals
    | SiteMsg Site.Msg
      -- Layouts
    | ContainerMsg Container.Msg
    | GridMsg Grid.Msg
    | HolyGrailMsg HolyGrail.Msg
    | ModalMsg Modal.Msg
    | RailMsg Rail.Msg
      -- Elements
    | ButtonMsg Button.Msg
    | DimmerMsg Dimmer.Msg
    | DividerMsg Divider.Msg
    | HeaderMsg Header.Msg
    | IconMsg Icon.Msg
    | ImageMsg Image.Msg
    | LabelMsg Label.Msg
    | LoaderMsg Loader.Msg
    | MessageMsg Message.Msg
    | PlaceholderMsg Placeholder.Msg
    | SegmentMsg Segment.Msg
    | TextMsg Text.Msg
      -- Navigations
    | AccordionMsg Accordion.Msg
    | BreadcrumbMsg Breadcrumb.Msg
    | MenuMsg Menu.Msg
    | ProgressMsg Progress.Msg
    | StepMsg Step.Msg
    | TabMsg Tab.Msg
      -- Forms
    | CheckboxMsg Checkbox.Msg
    | FormMsg Form.Msg
    | InputMsg Input.Msg
      -- Data Display
    | CardMsg Card.Msg
    | ItemMsg Item.Msg
    | SortableDataMsg SortableData.Msg
    | TableMsg Table.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( model.subModel, msg ) of
        ( _, UrlRequested urlRequest ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External url ->
                    ( model, Nav.load url )

        ( _, UrlChanged url ) ->
            { model | url = url }
                |> routing url

        ( _, Shared sharedMsg ) ->
            ( { model | shared = Shared.update sharedMsg model.shared }, Cmd.none )

        ( None, _ ) ->
            ( model, Cmd.none )

        ( TopModel, _ ) ->
            ( model, Cmd.none )

        ( SiteModel _, _ ) ->
            ( model, Cmd.none )

        ( ContainerModel _, _ ) ->
            ( model, Cmd.none )

        ( GridModel _, _ ) ->
            ( model, Cmd.none )

        ( HolyGrailModel _, _ ) ->
            ( model, Cmd.none )

        ( ModalModel subModel, ModalMsg subMsg ) ->
            ( { model | subModel = ModalModel (Modal.update subMsg subModel) }, Cmd.none )

        ( RailModel _, _ ) ->
            ( model, Cmd.none )

        ( ButtonModel subModel, ButtonMsg subMsg ) ->
            ( { model | subModel = ButtonModel (Button.update subMsg subModel) }, Cmd.none )

        ( DimmerModel subModel, DimmerMsg subMsg ) ->
            ( { model | subModel = DimmerModel (Dimmer.update subMsg subModel) }, Cmd.none )

        ( DividerModel subModel, DividerMsg subMsg ) ->
            ( { model | subModel = DividerModel (Divider.update subMsg subModel) }, Cmd.none )

        ( HeaderModel subModel, HeaderMsg subMsg ) ->
            ( { model | subModel = HeaderModel (Header.update subMsg subModel) }, Cmd.none )

        ( IconModel subModel, IconMsg subMsg ) ->
            ( { model | subModel = IconModel (Icon.update subMsg subModel) }, Cmd.none )

        ( ImageModel subModel, ImageMsg subMsg ) ->
            ( { model | subModel = ImageModel (Image.update subMsg subModel) }, Cmd.none )

        ( LabelModel subModel, LabelMsg subMsg ) ->
            ( { model | subModel = LabelModel (Label.update subMsg subModel) }, Cmd.none )

        ( LoaderModel subModel, LoaderMsg subMsg ) ->
            ( { model | subModel = LoaderModel (Loader.update subMsg subModel) }, Cmd.none )

        ( MessageModel subModel, MessageMsg subMsg ) ->
            ( { model | subModel = MessageModel (Message.update subMsg subModel) }, Cmd.none )

        ( PlaceholderModel subModel, PlaceholderMsg subMsg ) ->
            ( { model | subModel = PlaceholderModel (Placeholder.update subMsg subModel) }, Cmd.none )

        ( SegmentModel subModel, SegmentMsg subMsg ) ->
            ( { model | subModel = SegmentModel (Segment.update subMsg subModel) }, Cmd.none )

        ( TextModel subModel, TextMsg subMsg ) ->
            ( { model | subModel = TextModel (Text.update subMsg subModel) }, Cmd.none )

        ( AccordionModel subModel, AccordionMsg subMsg ) ->
            ( { model | subModel = AccordionModel (Accordion.update subMsg subModel) }, Cmd.none )

        ( BreadcrumbModel subModel, BreadcrumbMsg subMsg ) ->
            ( { model | subModel = BreadcrumbModel (Breadcrumb.update subMsg subModel) }, Cmd.none )

        ( MenuModel subModel, MenuMsg subMsg ) ->
            ( { model | subModel = MenuModel (Menu.update subMsg subModel) }, Cmd.none )

        ( ProgressModel subModel, ProgressMsg subMsg ) ->
            Progress.update subMsg subModel
                |> map ProgressModel ProgressMsg model

        ( StepModel subModel, StepMsg subMsg ) ->
            ( { model | subModel = StepModel (Step.update subMsg subModel) }, Cmd.none )

        ( TabModel subModel, TabMsg subMsg ) ->
            ( { model | subModel = TabModel (Tab.update subMsg subModel) }, Cmd.none )

        ( CheckboxModel subModel, CheckboxMsg subMsg ) ->
            ( { model | subModel = CheckboxModel (Checkbox.update subMsg subModel) }, Cmd.none )

        ( FormModel subModel, FormMsg subMsg ) ->
            ( { model | subModel = FormModel (Form.update subMsg subModel) }, Cmd.none )

        ( InputModel subModel, InputMsg subMsg ) ->
            ( { model | subModel = InputModel (Input.update subMsg subModel) }, Cmd.none )

        ( CardModel subModel, CardMsg subMsg ) ->
            ( { model | subModel = CardModel (Card.update subMsg subModel) }, Cmd.none )

        ( ItemModel subModel, ItemMsg subMsg ) ->
            ( { model | subModel = ItemModel (Item.update subMsg subModel) }, Cmd.none )

        ( SortableDataModel subModel, SortableDataMsg subMsg ) ->
            ( { model | subModel = SortableDataModel (SortableData.update subMsg subModel) }, Cmd.none )

        ( TableModel subModel, TableMsg subMsg ) ->
            ( { model | subModel = TableModel (Table.update subMsg subModel) }, Cmd.none )

        _ ->
            ( model, Cmd.none )


map : (subModel -> SubModel) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
map toModel toMsg model ( subModel, subCmd ) =
    ( { model | subModel = toModel subModel }
    , Cmd.map toMsg subCmd
    )



-- VIEW


view : Model -> Document Msg
view model =
    Layouts.Default.view model Shared <|
        { title =
            Url.Parser.parse parser model.url
                |> Maybe.withDefault notFoundPage
                |> .title
        , body =
            case model.subModel of
                None ->
                    []

                TopModel ->
                    Top.view model.shared

                SiteModel subModel ->
                    Site.view model.shared
                        |> List.map (Html.Styled.map SiteMsg)

                ContainerModel subModel ->
                    Container.view model.shared
                        |> List.map (Html.Styled.map ContainerMsg)

                GridModel subModel ->
                    Grid.view model.shared
                        |> List.map (Html.Styled.map GridMsg)

                HolyGrailModel subModel ->
                    HolyGrail.view model.shared
                        |> List.map (Html.Styled.map HolyGrailMsg)

                ModalModel subModel ->
                    Modal.view model.shared subModel
                        |> List.map (Html.Styled.map ModalMsg)

                RailModel subModel ->
                    Rail.view model.shared
                        |> List.map (Html.Styled.map RailMsg)

                ButtonModel subModel ->
                    Button.view model.shared subModel
                        |> List.map (Html.Styled.map ButtonMsg)

                DimmerModel subModel ->
                    Dimmer.view model.shared subModel
                        |> List.map (Html.Styled.map DimmerMsg)

                DividerModel subModel ->
                    Divider.view model.shared
                        |> List.map (Html.Styled.map DividerMsg)

                HeaderModel subModel ->
                    Header.view model.shared subModel
                        |> List.map (Html.Styled.map HeaderMsg)

                IconModel subModel ->
                    Icon.view model.shared
                        |> List.map (Html.Styled.map IconMsg)

                ImageModel subModel ->
                    Image.view model.shared
                        |> List.map (Html.Styled.map ImageMsg)

                LabelModel subModel ->
                    Label.view model.shared subModel
                        |> List.map (Html.Styled.map LabelMsg)

                LoaderModel subModel ->
                    Loader.view model.shared
                        |> List.map (Html.Styled.map LoaderMsg)

                MessageModel subModel ->
                    Message.view model.shared
                        |> List.map (Html.Styled.map MessageMsg)

                PlaceholderModel subModel ->
                    Placeholder.view model.shared
                        |> List.map (Html.Styled.map PlaceholderMsg)

                SegmentModel subModel ->
                    Segment.view model.shared subModel
                        |> List.map (Html.Styled.map SegmentMsg)

                TextModel subModel ->
                    Text.view model.shared subModel
                        |> List.map (Html.Styled.map TextMsg)

                AccordionModel subModel ->
                    Accordion.view model.shared subModel
                        |> List.map (Html.Styled.map AccordionMsg)

                BreadcrumbModel subModel ->
                    Breadcrumb.view model.shared subModel
                        |> List.map (Html.Styled.map BreadcrumbMsg)

                MenuModel subModel ->
                    Menu.view model.shared
                        |> List.map (Html.Styled.map MenuMsg)

                ProgressModel subModel ->
                    Progress.view model.shared subModel
                        |> List.map (Html.Styled.map ProgressMsg)

                StepModel subModel ->
                    Step.view model.shared subModel
                        |> List.map (Html.Styled.map StepMsg)

                TabModel subModel ->
                    Tab.view model.shared
                        |> List.map (Html.Styled.map TabMsg)

                CheckboxModel subModel ->
                    Checkbox.view model.shared subModel
                        |> List.map (Html.Styled.map CheckboxMsg)

                FormModel subModel ->
                    Form.view model.shared subModel
                        |> List.map (Html.Styled.map FormMsg)

                InputModel subModel ->
                    Input.view model.shared
                        |> List.map (Html.Styled.map InputMsg)

                CardModel subModel ->
                    Card.view model.shared subModel
                        |> List.map (Html.Styled.map CardMsg)

                ItemModel subModel ->
                    Item.view model.shared subModel
                        |> List.map (Html.Styled.map ItemMsg)

                SortableDataModel subModel ->
                    SortableData.view model.shared subModel
                        |> List.map (Html.Styled.map SortableDataMsg)

                TableModel subModel ->
                    Table.view model.shared subModel
                        |> List.map (Html.Styled.map TableMsg)
        }
