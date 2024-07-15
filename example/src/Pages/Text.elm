module Pages.Text exposing (Model, Msg, page)

import Control
import Effect exposing (Effect)
import Headless.Text exposing (TextAs(..), TextProps, defaultTextProps, text)
import Html.Styled as Html exposing (Html)
import Page exposing (Page)
import Playground exposing (Node(..), playground)
import Route exposing (Route)
import Shared
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- INIT


type alias Model =
    TextProps


init : () -> ( Model, Effect Msg )
init () =
    ( defaultTextProps
    , Effect.none
    )



-- UPDATE


type Msg
    = UpdateTextProps (TextProps -> TextProps)


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        UpdateTextProps updater ->
            ( updater model
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Pages.Text"
    , body =
        List.map Html.toUnstyled <|
            [ textPlayground False model ]
    }


textPlayground : Bool -> TextProps -> Html Msg
textPlayground isDarkMode state =
    playground
        { isDarkMode = isDarkMode
        , toMsg = UpdateTextProps
        , preview = text state "Hello, World!"
        , controlSections =
            [ { heading = "Typography"
              , controls =
                    [ Field "textAs"
                        (Control.select
                            { value = textAsToString state.textAs
                            , options = List.map textAsToString [ Span, Div, Label, P ]
                            , onChange =
                                \textAs state_ ->
                                    textAsFromString textAs
                                        |> Maybe.map (\textAs_ -> { state_ | textAs = textAs_ })
                                        |> Maybe.withDefault state_
                            }
                        )
                    ]
              }
            ]
        }


textAsToString : TextAs -> String
textAsToString textAs =
    case textAs of
        Span ->
            "span"

        Div ->
            "div"

        Label ->
            "label"

        P ->
            "p"


textAsFromString : String -> Maybe TextAs
textAsFromString string =
    case string of
        "span" ->
            Just Span

        "div" ->
            Just Div

        "label" ->
            Just Label

        "p" ->
            Just P

        _ ->
            Nothing
