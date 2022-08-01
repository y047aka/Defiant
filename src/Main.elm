module Main exposing (main)

import Browser
import Browser.Navigation as Nav exposing (Key)
import Css.FontAwesome exposing (fontAwesome)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Data.Theme as Theme exposing (Theme(..))
import Effect
import Gen.Model
import Gen.Pages as Pages
import Gen.Route as Route
import Html.Styled exposing (Html, option, select, text)
import Html.Styled.Attributes exposing (checked, for, id, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Request
import Shared
import UI.Breadcrumb exposing (BreadcrumbItem, breadcrumb)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Container exposing (container)
import UI.Segment exposing (basicSegment)
import Url exposing (Url)
import View exposing (View)


main : Program Shared.Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }



-- INIT


type alias Model =
    { url : Url
    , key : Key
    , shared : Shared.Model
    , page : Pages.Model
    }


init : Shared.Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( shared, sharedCmd ) =
            Shared.init (Request.create () url key) flags

        ( page, effect ) =
            Pages.init (Route.fromUrl url) shared url key
    in
    ( Model url key shared page
    , Cmd.batch
        [ Cmd.map Shared sharedCmd
        , Effect.toCmd ( Shared, Page ) effect
        ]
    )



-- UPDATE


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | Shared Shared.Msg
    | Page Pages.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink (Browser.Internal url) ->
            case url.fragment of
                Just id ->
                    ( model, Nav.load ("#" ++ id) )

                Nothing ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

        ClickedLink (Browser.External url) ->
            ( model
            , Nav.load url
            )

        ChangedUrl url ->
            if url.path /= model.url.path then
                let
                    ( page, effect ) =
                        Pages.init (Route.fromUrl url) model.shared url model.key
                in
                ( { model | url = url, page = page }
                , Effect.toCmd ( Shared, Page ) effect
                )

            else
                ( { model | url = url }, Cmd.none )

        Shared sharedMsg ->
            let
                ( shared, sharedCmd ) =
                    Shared.update (Request.create () model.url model.key) sharedMsg model.shared

                ( page, effect ) =
                    Pages.init (Route.fromUrl model.url) shared model.url model.key
            in
            if page == Gen.Model.Redirecting_ then
                ( { model | shared = shared, page = page }
                , Cmd.batch
                    [ Cmd.map Shared sharedCmd
                    , Effect.toCmd ( Shared, Page ) effect
                    ]
                )

            else
                ( { model | shared = shared }
                , Cmd.map Shared sharedCmd
                )

        Page pageMsg ->
            let
                ( page, effect ) =
                    Pages.update pageMsg model.page model.shared model.url model.key
            in
            ( { model | page = page }
            , Effect.toCmd ( Shared, Page ) effect
            )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    Pages.view model.page model.shared model.url model.key
        |> View.map Page
        |> (\view_ ->
                { title =
                    case model.url.path of
                        "/" ->
                            "Defiant"

                        _ ->
                            view_.title ++ " | Defiant"
                , body = layout model view_
                }
           )
        |> View.toBrowserDocument


layout : Model -> View Msg -> List (Html Msg)
layout { url, shared } { title, body } =
    [ global (normalize ++ additionalReset ++ globalCustomize ++ fontAwesome)
    , basicSegment { inverted = False }
        []
        [ container []
            [ breadcrumb { divider = text "/", inverted = shared.darkMode }
                (breadcrumbItems { title = title, url = url })
            ]
        ]
    , basicSegment { inverted = False }
        []
        [ container []
            [ checkbox []
                [ Checkbox.input
                    [ id "darkmode"
                    , type_ "checkbox"
                    , checked shared.darkMode
                    , onClick (Shared Shared.ToggleDarkMode)
                    ]
                    []
                , Checkbox.label [ for "darkmode" ] [ text "Dark mode" ]
                ]
            , text "Theme "
            , select [ onInput (Theme.fromString >> Maybe.withDefault shared.theme >> (\theme -> Shared (Shared.ChangeTheme theme))) ] <|
                List.map (\theme -> option [ value (Theme.toString theme), selected (shared.theme == theme) ] [ text (Theme.toString theme) ])
                    [ System, Light, Dark ]
            ]
        ]
    , basicSegment { inverted = False }
        []
        [ container [] body ]
    ]


breadcrumbItems : { title : String, url : Url } -> List BreadcrumbItem
breadcrumbItems { title, url } =
    case url.path of
        "/" ->
            [ { label = "Top", url = "/" } ]

        _ ->
            [ { label = "Top", url = "/" }
            , { label = title, url = Url.toString url }
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Pages.subscriptions model.page model.shared model.url model.key |> Sub.map Page
        , Shared.subscriptions (Request.create () model.url model.key) model.shared |> Sub.map Shared
        ]
