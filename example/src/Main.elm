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
import Pages.Layout.Stack as Stack
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
    , page : PageModel
    , shared : Shared.Model
    }


type PageModel
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
    | StackModel Stack.Model
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
    , page = TopModel
    , shared = Shared.init
    }
        |> routing url



-- ROUTER


routing : Url -> Model -> ( Model, Cmd Msg )
routing url model =
    Url.Parser.parse (parser model) url
        |> Maybe.withDefault ( { model | page = None }, Cmd.none )


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
        [ fromPageSummary topPage |> Url.Parser.map ( { model | page = TopModel }, Cmd.none )

        -- Globals
        , fromPageSummary sitePage |> Url.Parser.map ( { model | page = SiteModel Site.init }, Cmd.none )

        -- Layouts
        , fromPageSummary containerPage |> Url.Parser.map ( { model | page = ContainerModel Container.init }, Cmd.none )
        , fromPageSummary gridPage |> Url.Parser.map ( { model | page = GridModel Grid.init }, Cmd.none )
        , fromPageSummary holyGrailPage |> Url.Parser.map ( { model | page = HolyGrailModel HolyGrail.init }, Cmd.none )
        , fromPageSummary modalPage |> Url.Parser.map ( { model | page = ModalModel Modal.init }, Cmd.none )
        , fromPageSummary railPage |> Url.Parser.map ( { model | page = RailModel Rail.init }, Cmd.none )
        , fromPageSummary stackPage |> Url.Parser.map ( { model | page = StackModel Stack.init }, Cmd.none )

        -- Elements
        , fromPageSummary buttonPage |> Url.Parser.map ( { model | page = ButtonModel Button.init }, Cmd.none )
        , fromPageSummary dimmerPage |> Url.Parser.map ( { model | page = DimmerModel Dimmer.init }, Cmd.none )
        , fromPageSummary dividerPage |> Url.Parser.map ( { model | page = DividerModel Divider.init }, Cmd.none )
        , fromPageSummary headerPage |> Url.Parser.map ( { model | page = HeaderModel Header.init }, Cmd.none )
        , fromPageSummary iconPage |> Url.Parser.map ( { model | page = IconModel Icon.init }, Cmd.none )
        , fromPageSummary imagePage |> Url.Parser.map ( { model | page = ImageModel Image.init }, Cmd.none )
        , fromPageSummary labelPage |> Url.Parser.map ( { model | page = LabelModel Label.init }, Cmd.none )
        , fromPageSummary loaderPage |> Url.Parser.map ( { model | page = LoaderModel Loader.init }, Cmd.none )
        , fromPageSummary messagePage |> Url.Parser.map ( { model | page = MessageModel Message.init }, Cmd.none )
        , fromPageSummary placeholderPage |> Url.Parser.map ( { model | page = PlaceholderModel Placeholder.init }, Cmd.none )
        , fromPageSummary segmentPage |> Url.Parser.map ( { model | page = SegmentModel Segment.init }, Cmd.none )
        , fromPageSummary textPage |> Url.Parser.map ( { model | page = TextModel Text.init }, Cmd.none )

        -- Navigations
        , fromPageSummary accordionPage |> Url.Parser.map ( { model | page = AccordionModel Accordion.init }, Cmd.none )
        , fromPageSummary breadcrumbPage |> Url.Parser.map ( { model | page = BreadcrumbModel Breadcrumb.init }, Cmd.none )
        , fromPageSummary menuPage |> Url.Parser.map ( { model | page = MenuModel Menu.init }, Cmd.none )
        , fromPageSummary progressPage |> Url.Parser.map (Progress.init |> updateWith ProgressModel ProgressMsg model)
        , fromPageSummary stepPage |> Url.Parser.map ( { model | page = StepModel Step.init }, Cmd.none )
        , fromPageSummary tabPage |> Url.Parser.map ( { model | page = TabModel Tab.init }, Cmd.none )

        -- Forms
        , fromPageSummary checkboxPage |> Url.Parser.map ( { model | page = CheckboxModel Checkbox.init }, Cmd.none )
        , fromPageSummary formPage |> Url.Parser.map ( { model | page = FormModel Form.init }, Cmd.none )
        , fromPageSummary inputPage |> Url.Parser.map ( { model | page = InputModel Input.init }, Cmd.none )

        -- Data Display
        , fromPageSummary cardPage |> Url.Parser.map ( { model | page = CardModel Card.init }, Cmd.none )
        , fromPageSummary itemPage |> Url.Parser.map ( { model | page = ItemModel Item.init }, Cmd.none )
        , fromPageSummary sortableDataPage |> Url.Parser.map ( { model | page = SortableDataModel SortableData.init }, Cmd.none )
        , fromPageSummary tablePage |> Url.Parser.map ( { model | page = TableModel Table.init }, Cmd.none )
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
    | StackMsg Stack.Msg
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
            case ( model.page, pageMsg ) of
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

                ( ModalModel pageModel, ModalMsg pageMsg_ ) ->
                    ( { model | page = ModalModel (Modal.update pageMsg_ pageModel) }, Cmd.none )

                ( RailModel _, _ ) ->
                    ( model, Cmd.none )

                ( StackModel pageModel, StackMsg pageMsg_ ) ->
                    ( { model | page = StackModel (Stack.update pageMsg_ pageModel) }, Cmd.none )

                ( ButtonModel pageModel, ButtonMsg pageMsg_ ) ->
                    ( { model | page = ButtonModel (Button.update pageMsg_ pageModel) }, Cmd.none )

                ( DimmerModel pageModel, DimmerMsg pageMsg_ ) ->
                    ( { model | page = DimmerModel (Dimmer.update pageMsg_ pageModel) }, Cmd.none )

                ( DividerModel pageModel, DividerMsg pageMsg_ ) ->
                    ( { model | page = DividerModel (Divider.update pageMsg_ pageModel) }, Cmd.none )

                ( HeaderModel pageModel, HeaderMsg pageMsg_ ) ->
                    ( { model | page = HeaderModel (Header.update pageMsg_ pageModel) }, Cmd.none )

                ( IconModel pageModel, IconMsg pageMsg_ ) ->
                    ( { model | page = IconModel (Icon.update pageMsg_ pageModel) }, Cmd.none )

                ( ImageModel pageModel, ImageMsg pageMsg_ ) ->
                    ( { model | page = ImageModel (Image.update pageMsg_ pageModel) }, Cmd.none )

                ( LabelModel pageModel, LabelMsg pageMsg_ ) ->
                    ( { model | page = LabelModel (Label.update pageMsg_ pageModel) }, Cmd.none )

                ( LoaderModel pageModel, LoaderMsg pageMsg_ ) ->
                    ( { model | page = LoaderModel (Loader.update pageMsg_ pageModel) }, Cmd.none )

                ( MessageModel pageModel, MessageMsg pageMsg_ ) ->
                    ( { model | page = MessageModel (Message.update pageMsg_ pageModel) }, Cmd.none )

                ( PlaceholderModel pageModel, PlaceholderMsg pageMsg_ ) ->
                    ( { model | page = PlaceholderModel (Placeholder.update pageMsg_ pageModel) }, Cmd.none )

                ( SegmentModel pageModel, SegmentMsg pageMsg_ ) ->
                    ( { model | page = SegmentModel (Segment.update pageMsg_ pageModel) }, Cmd.none )

                ( TextModel pageModel, TextMsg pageMsg_ ) ->
                    ( { model | page = TextModel (Text.update pageMsg_ pageModel) }, Cmd.none )

                ( AccordionModel pageModel, AccordionMsg pageMsg_ ) ->
                    ( { model | page = AccordionModel (Accordion.update pageMsg_ pageModel) }, Cmd.none )

                ( BreadcrumbModel pageModel, BreadcrumbMsg pageMsg_ ) ->
                    ( { model | page = BreadcrumbModel (Breadcrumb.update pageMsg_ pageModel) }, Cmd.none )

                ( MenuModel pageModel, MenuMsg pageMsg_ ) ->
                    ( { model | page = MenuModel (Menu.update pageMsg_ pageModel) }, Cmd.none )

                ( ProgressModel pageModel, ProgressMsg pageMsg_ ) ->
                    Progress.update pageMsg_ pageModel
                        |> updateWith ProgressModel ProgressMsg model

                ( StepModel pageModel, StepMsg pageMsg_ ) ->
                    ( { model | page = StepModel (Step.update pageMsg_ pageModel) }, Cmd.none )

                ( TabModel pageModel, TabMsg pageMsg_ ) ->
                    ( { model | page = TabModel (Tab.update pageMsg_ pageModel) }, Cmd.none )

                ( CheckboxModel pageModel, CheckboxMsg pageMsg_ ) ->
                    ( { model | page = CheckboxModel (Checkbox.update pageMsg_ pageModel) }, Cmd.none )

                ( FormModel pageModel, FormMsg pageMsg_ ) ->
                    ( { model | page = FormModel (Form.update pageMsg_ pageModel) }, Cmd.none )

                ( InputModel pageModel, InputMsg pageMsg_ ) ->
                    ( { model | page = InputModel (Input.update pageMsg_ pageModel) }, Cmd.none )

                ( CardModel pageModel, CardMsg pageMsg_ ) ->
                    ( { model | page = CardModel (Card.update pageMsg_ pageModel) }, Cmd.none )

                ( ItemModel pageModel, ItemMsg pageMsg_ ) ->
                    ( { model | page = ItemModel (Item.update pageMsg_ pageModel) }, Cmd.none )

                ( SortableDataModel pageModel, SortableDataMsg pageMsg_ ) ->
                    ( { model | page = SortableDataModel (SortableData.update pageMsg_ pageModel) }, Cmd.none )

                ( TableModel pageModel, TableMsg pageMsg_ ) ->
                    ( { model | page = TableModel (Table.update pageMsg_ pageModel) }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


updateWith : (pageModel -> PageModel) -> (pageMsg_ -> PageMsg) -> Model -> ( pageModel, Cmd pageMsg_ ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( pageModel, pageCmd ) =
    ( { model | page = toModel pageModel }
    , Cmd.map (toMsg >> Page) pageCmd
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
            case model.page of
                None ->
                    []

                TopModel ->
                    Top.view model.shared

                SiteModel pageModel ->
                    Site.view model.shared
                        |> List.map (Html.Styled.map (SiteMsg >> Page))

                ContainerModel pageModel ->
                    Container.view model.shared
                        |> List.map (Html.Styled.map (ContainerMsg >> Page))

                GridModel pageModel ->
                    Grid.view model.shared
                        |> List.map (Html.Styled.map (GridMsg >> Page))

                HolyGrailModel pageModel ->
                    HolyGrail.view model.shared
                        |> List.map (Html.Styled.map (HolyGrailMsg >> Page))

                ModalModel pageModel ->
                    Modal.view model.shared pageModel
                        |> List.map (Html.Styled.map (ModalMsg >> Page))

                RailModel pageModel ->
                    Rail.view model.shared
                        |> List.map (Html.Styled.map (RailMsg >> Page))

                StackModel pageModel ->
                    Stack.view model.shared pageModel
                        |> List.map (Html.Styled.map (StackMsg >> Page))

                ButtonModel pageModel ->
                    Button.view model.shared pageModel
                        |> List.map (Html.Styled.map (ButtonMsg >> Page))

                DimmerModel pageModel ->
                    Dimmer.view model.shared pageModel
                        |> List.map (Html.Styled.map (DimmerMsg >> Page))

                DividerModel pageModel ->
                    Divider.view model.shared
                        |> List.map (Html.Styled.map (DividerMsg >> Page))

                HeaderModel pageModel ->
                    Header.view model.shared pageModel
                        |> List.map (Html.Styled.map (HeaderMsg >> Page))

                IconModel pageModel ->
                    Icon.view model.shared
                        |> List.map (Html.Styled.map (IconMsg >> Page))

                ImageModel pageModel ->
                    Image.view model.shared
                        |> List.map (Html.Styled.map (ImageMsg >> Page))

                LabelModel pageModel ->
                    Label.view model.shared pageModel
                        |> List.map (Html.Styled.map (LabelMsg >> Page))

                LoaderModel pageModel ->
                    Loader.view model.shared
                        |> List.map (Html.Styled.map (LoaderMsg >> Page))

                MessageModel pageModel ->
                    Message.view model.shared
                        |> List.map (Html.Styled.map (MessageMsg >> Page))

                PlaceholderModel pageModel ->
                    Placeholder.view model.shared
                        |> List.map (Html.Styled.map (PlaceholderMsg >> Page))

                SegmentModel pageModel ->
                    Segment.view model.shared pageModel
                        |> List.map (Html.Styled.map (SegmentMsg >> Page))

                TextModel pageModel ->
                    Text.view model.shared pageModel
                        |> List.map (Html.Styled.map (TextMsg >> Page))

                AccordionModel pageModel ->
                    Accordion.view model.shared pageModel
                        |> List.map (Html.Styled.map (AccordionMsg >> Page))

                BreadcrumbModel pageModel ->
                    Breadcrumb.view model.shared pageModel
                        |> List.map (Html.Styled.map (BreadcrumbMsg >> Page))

                MenuModel pageModel ->
                    Menu.view model.shared
                        |> List.map (Html.Styled.map (MenuMsg >> Page))

                ProgressModel pageModel ->
                    Progress.view model.shared pageModel
                        |> List.map (Html.Styled.map (ProgressMsg >> Page))

                StepModel pageModel ->
                    Step.view model.shared pageModel
                        |> List.map (Html.Styled.map (StepMsg >> Page))

                TabModel pageModel ->
                    Tab.view model.shared
                        |> List.map (Html.Styled.map (TabMsg >> Page))

                CheckboxModel pageModel ->
                    Checkbox.view model.shared pageModel
                        |> List.map (Html.Styled.map (CheckboxMsg >> Page))

                FormModel pageModel ->
                    Form.view model.shared pageModel
                        |> List.map (Html.Styled.map (FormMsg >> Page))

                InputModel pageModel ->
                    Input.view model.shared
                        |> List.map (Html.Styled.map (InputMsg >> Page))

                CardModel pageModel ->
                    Card.view model.shared pageModel
                        |> List.map (Html.Styled.map (CardMsg >> Page))

                ItemModel pageModel ->
                    Item.view model.shared pageModel
                        |> List.map (Html.Styled.map (ItemMsg >> Page))

                SortableDataModel pageModel ->
                    SortableData.view model.shared pageModel
                        |> List.map (Html.Styled.map (SortableDataMsg >> Page))

                TableModel pageModel ->
                    Table.view model.shared pageModel
                        |> List.map (Html.Styled.map (TableMsg >> Page))
        }
