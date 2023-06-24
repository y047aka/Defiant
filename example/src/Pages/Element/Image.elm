module Pages.Element.Image exposing (Model, Msg, page)

import Effect
import Html.Styled exposing (Html)
import Html.Styled.Attributes exposing (src)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import UI.Image exposing (smallImage)


layout : Model -> Layout msg
layout model =
    Layouts.Default {}


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Image"
                , body = view shared
                }
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ playground
        { title = "Image"
        , theme = theme
        , inverted = False
        , preview = [ smallImage [ src "/images/wireframe/image.png" ] [] ]
        , configSections = []
        }
    ]
