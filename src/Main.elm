module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Navigation as Nav exposing (Key)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Data.Page exposing (Page(..))
import Data.PageSummary as PageSummary exposing (Category(..), PageSummary)
import Html.Styled as Html exposing (Html, a, div, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (for, href, id, type_)
import Html.Styled.Events exposing (onClick)
import Page
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


type Model
    = Page PageSummary Page.Model


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    let
        ( newModel, _ ) =
            Page.init () key
    in
    Page PageSummary.top newModel
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
        List.map (\summary -> Parser.map summary (pageParser summary.route)) PageSummary.all


routing : Url -> Model -> ( Model, Cmd Msg )
routing url (Page _ { key }) =
    let
        ( newModel, cmd ) =
            Page.init () key
    in
    Parser.parse parser url
        |> Maybe.withDefault PageSummary.notFound
        |> (\pageSummary -> ( Page pageSummary newModel, Cmd.map PageMsg cmd ))



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url
    | ToggleDarkMode
    | PageMsg Page.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Page pageSummary model) =
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Just id ->
                            ( Page pageSummary model, Nav.load ("#" ++ id) )

                        Nothing ->
                            ( Page pageSummary model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( Page pageSummary model, Nav.load href )

        UrlChanged url ->
            routing url (Page pageSummary model)

        ToggleDarkMode ->
            ( Page pageSummary { model | darkMode = not model.darkMode }, Cmd.none )

        PageMsg submsg ->
            Page.update submsg model
                |> (\( m, cmd ) -> ( Page pageSummary m, Cmd.map PageMsg cmd ))



-- VIEW


view : Model -> { title : String, body : List (Html Msg) }
view (Page pageSummary model) =
    { title =
        case pageSummary.page of
            Top ->
                "Defiant"

            _ ->
                pageSummary.title ++ " | Defiant"
    , body =
        layout (Page pageSummary model) <|
            List.map (Html.map PageMsg) <|
                case pageSummary.page of
                    NotFound ->
                        []

                    Top ->
                        tableOfContents { inverted = model.darkMode }

                    _ ->
                        pageSummary.view model
    }


layout : Model -> List (Html Msg) -> List (Html Msg)
layout (Page pageSummary { darkMode }) contents =
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
                [ Header.header options [] [ text (PageSummary.categoryToString category) ]
                , cards []
                    (List.filter (.category >> (==) category) PageSummary.all
                        |> List.map item
                    )
                ]
        )
        [ Globals, Elements, Collections, Views, Modules, Defiant ]
