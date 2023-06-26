module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav exposing (Key)
import Data.PageSummary as PageSummary exposing (..)
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


routing : Url -> Model -> ( Model, Cmd Msg )
routing url model =
    Url.Parser.parse (parser model) url
        |> Maybe.withDefault ( { model | subModel = None }, Cmd.none )


parser : Model -> Parser (( Model, Cmd Msg ) -> a) a
parser model =
    let
        fromPageSummary { route } =
            case route of
                [] ->
                    Url.Parser.top

                [ category, page ] ->
                    s category </> s page

                _ ->
                    Url.Parser.top
    in
    Url.Parser.oneOf
        [ fromPageSummary topPage |> Url.Parser.map ( { model | subModel = TopModel }, Cmd.none )

        -- Globals
        , fromPageSummary sitePage |> Url.Parser.map ( { model | subModel = SiteModel Site.init }, Cmd.none )

        -- Layouts
        , fromPageSummary containerPage |> Url.Parser.map ( { model | subModel = ContainerModel Container.init }, Cmd.none )
        , fromPageSummary gridPage |> Url.Parser.map ( { model | subModel = GridModel Grid.init }, Cmd.none )
        , fromPageSummary holyGrailPage |> Url.Parser.map ( { model | subModel = HolyGrailModel HolyGrail.init }, Cmd.none )
        , fromPageSummary modalPage |> Url.Parser.map ( { model | subModel = ModalModel Modal.init }, Cmd.none )
        , fromPageSummary railPage |> Url.Parser.map ( { model | subModel = RailModel Rail.init }, Cmd.none )

        -- Elements
        , fromPageSummary buttonPage |> Url.Parser.map ( { model | subModel = ButtonModel Button.init }, Cmd.none )
        , fromPageSummary dimmerPage |> Url.Parser.map ( { model | subModel = DimmerModel Dimmer.init }, Cmd.none )
        , fromPageSummary dividerPage |> Url.Parser.map ( { model | subModel = DividerModel Divider.init }, Cmd.none )
        , fromPageSummary headerPage |> Url.Parser.map ( { model | subModel = HeaderModel Header.init }, Cmd.none )
        , fromPageSummary iconPage |> Url.Parser.map ( { model | subModel = IconModel Icon.init }, Cmd.none )
        , fromPageSummary imagePage |> Url.Parser.map ( { model | subModel = ImageModel Image.init }, Cmd.none )
        , fromPageSummary labelPage |> Url.Parser.map ( { model | subModel = LabelModel Label.init }, Cmd.none )
        , fromPageSummary loaderPage |> Url.Parser.map ( { model | subModel = LoaderModel Loader.init }, Cmd.none )
        , fromPageSummary messagePage |> Url.Parser.map ( { model | subModel = MessageModel Message.init }, Cmd.none )
        , fromPageSummary placeholderPage |> Url.Parser.map ( { model | subModel = PlaceholderModel Placeholder.init }, Cmd.none )
        , fromPageSummary segmentPage |> Url.Parser.map ( { model | subModel = SegmentModel Segment.init }, Cmd.none )
        , fromPageSummary textPage |> Url.Parser.map ( { model | subModel = TextModel Text.init }, Cmd.none )

        -- Navigations
        , fromPageSummary accordionPage |> Url.Parser.map ( { model | subModel = AccordionModel Accordion.init }, Cmd.none )
        , fromPageSummary breadcrumbPage |> Url.Parser.map ( { model | subModel = BreadcrumbModel Breadcrumb.init }, Cmd.none )
        , fromPageSummary menuPage |> Url.Parser.map ( { model | subModel = MenuModel Menu.init }, Cmd.none )
        , fromPageSummary progressPage |> Url.Parser.map (Progress.init |> updateWith ProgressModel (ProgressMsg >> Page) model)
        , fromPageSummary stepPage |> Url.Parser.map ( { model | subModel = StepModel Step.init }, Cmd.none )
        , fromPageSummary tabPage |> Url.Parser.map ( { model | subModel = TabModel Tab.init }, Cmd.none )

        -- Forms
        , fromPageSummary checkboxPage |> Url.Parser.map ( { model | subModel = CheckboxModel Checkbox.init }, Cmd.none )
        , fromPageSummary formPage |> Url.Parser.map ( { model | subModel = FormModel Form.init }, Cmd.none )
        , fromPageSummary inputPage |> Url.Parser.map ( { model | subModel = InputModel Input.init }, Cmd.none )

        -- Data Display
        , fromPageSummary cardPage |> Url.Parser.map ( { model | subModel = CardModel Card.init }, Cmd.none )
        , fromPageSummary itemPage |> Url.Parser.map ( { model | subModel = ItemModel Item.init }, Cmd.none )
        , fromPageSummary sortableDataPage |> Url.Parser.map ( { model | subModel = SortableDataModel SortableData.init }, Cmd.none )
        , fromPageSummary tablePage |> Url.Parser.map ( { model | subModel = TableModel Table.init }, Cmd.none )
        ]


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
    | Page PageMsg
    | Shared Shared.Msg


type PageMsg
    = SiteMsg Site.Msg
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
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External url ->
                    ( model, Nav.load url )

        UrlChanged url ->
            { model | url = url }
                |> routing url

        Shared sharedMsg ->
            ( { model | shared = Shared.update sharedMsg model.shared }, Cmd.none )

        Page pageMsg ->
            case ( model.subModel, pageMsg ) of
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
                        |> updateWith ProgressModel (ProgressMsg >> Page) model

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


updateWith : (subModel -> SubModel) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( { model | subModel = toModel subModel }
    , Cmd.map toMsg subCmd
    )



-- VIEW


view : Model -> Document Msg
view model =
    let
        fromPageSummary route =
            case route of
                [] ->
                    Url.Parser.top

                [ category, page ] ->
                    s category </> s page

                _ ->
                    Url.Parser.top

        parser_ =
            Url.Parser.oneOf <|
                List.map (\page -> Url.Parser.map page (fromPageSummary page.route)) (topPage :: PageSummary.all)
    in
    Layouts.Default.view model Shared <|
        { title =
            Url.Parser.parse parser_ model.url
                |> Maybe.map .title
                |> Maybe.withDefault "Not Found"
        , body =
            case model.subModel of
                None ->
                    []

                TopModel ->
                    Top.view model.shared

                SiteModel subModel ->
                    Site.view model.shared
                        |> List.map (Html.Styled.map (SiteMsg >> Page))

                ContainerModel subModel ->
                    Container.view model.shared
                        |> List.map (Html.Styled.map (ContainerMsg >> Page))

                GridModel subModel ->
                    Grid.view model.shared
                        |> List.map (Html.Styled.map (GridMsg >> Page))

                HolyGrailModel subModel ->
                    HolyGrail.view model.shared
                        |> List.map (Html.Styled.map (HolyGrailMsg >> Page))

                ModalModel subModel ->
                    Modal.view model.shared subModel
                        |> List.map (Html.Styled.map (ModalMsg >> Page))

                RailModel subModel ->
                    Rail.view model.shared
                        |> List.map (Html.Styled.map (RailMsg >> Page))

                ButtonModel subModel ->
                    Button.view model.shared subModel
                        |> List.map (Html.Styled.map (ButtonMsg >> Page))

                DimmerModel subModel ->
                    Dimmer.view model.shared subModel
                        |> List.map (Html.Styled.map (DimmerMsg >> Page))

                DividerModel subModel ->
                    Divider.view model.shared
                        |> List.map (Html.Styled.map (DividerMsg >> Page))

                HeaderModel subModel ->
                    Header.view model.shared subModel
                        |> List.map (Html.Styled.map (HeaderMsg >> Page))

                IconModel subModel ->
                    Icon.view model.shared
                        |> List.map (Html.Styled.map (IconMsg >> Page))

                ImageModel subModel ->
                    Image.view model.shared
                        |> List.map (Html.Styled.map (ImageMsg >> Page))

                LabelModel subModel ->
                    Label.view model.shared subModel
                        |> List.map (Html.Styled.map (LabelMsg >> Page))

                LoaderModel subModel ->
                    Loader.view model.shared
                        |> List.map (Html.Styled.map (LoaderMsg >> Page))

                MessageModel subModel ->
                    Message.view model.shared
                        |> List.map (Html.Styled.map (MessageMsg >> Page))

                PlaceholderModel subModel ->
                    Placeholder.view model.shared
                        |> List.map (Html.Styled.map (PlaceholderMsg >> Page))

                SegmentModel subModel ->
                    Segment.view model.shared subModel
                        |> List.map (Html.Styled.map (SegmentMsg >> Page))

                TextModel subModel ->
                    Text.view model.shared subModel
                        |> List.map (Html.Styled.map (TextMsg >> Page))

                AccordionModel subModel ->
                    Accordion.view model.shared subModel
                        |> List.map (Html.Styled.map (AccordionMsg >> Page))

                BreadcrumbModel subModel ->
                    Breadcrumb.view model.shared subModel
                        |> List.map (Html.Styled.map (BreadcrumbMsg >> Page))

                MenuModel subModel ->
                    Menu.view model.shared
                        |> List.map (Html.Styled.map (MenuMsg >> Page))

                ProgressModel subModel ->
                    Progress.view model.shared subModel
                        |> List.map (Html.Styled.map (ProgressMsg >> Page))

                StepModel subModel ->
                    Step.view model.shared subModel
                        |> List.map (Html.Styled.map (StepMsg >> Page))

                TabModel subModel ->
                    Tab.view model.shared
                        |> List.map (Html.Styled.map (TabMsg >> Page))

                CheckboxModel subModel ->
                    Checkbox.view model.shared subModel
                        |> List.map (Html.Styled.map (CheckboxMsg >> Page))

                FormModel subModel ->
                    Form.view model.shared subModel
                        |> List.map (Html.Styled.map (FormMsg >> Page))

                InputModel subModel ->
                    Input.view model.shared
                        |> List.map (Html.Styled.map (InputMsg >> Page))

                CardModel subModel ->
                    Card.view model.shared subModel
                        |> List.map (Html.Styled.map (CardMsg >> Page))

                ItemModel subModel ->
                    Item.view model.shared subModel
                        |> List.map (Html.Styled.map (ItemMsg >> Page))

                SortableDataModel subModel ->
                    SortableData.view model.shared subModel
                        |> List.map (Html.Styled.map (SortableDataMsg >> Page))

                TableModel subModel ->
                    Table.view model.shared subModel
                        |> List.map (Html.Styled.map (TableMsg >> Page))
        }
