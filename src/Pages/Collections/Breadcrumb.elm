module Pages.Collections.Breadcrumb exposing (Model, Msg, page)

import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, option, select, text)
import Html.Styled.Attributes exposing (selected, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Breadcrumb exposing (breadcrumb)
import UI.Icon exposing (icon)
import UI.Segment exposing (segment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Breadcrumb"
                , body = view shared model
                }
        }



-- INIT


type alias Model =
    { divider : Divider }


init : Model
init =
    { divider = Slash }



-- UPDATE


type Msg
    = ChangeDivider Divider


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeDivider divider ->
            { model | divider = divider }



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    let
        options =
            { divider =
                case model.divider of
                    Slash ->
                        text "/"

                    RightChevron ->
                        icon [] "fas fa-angle-right"
            , theme = theme
            }
    in
    [ configAndPreview { title = "Breadcrumb" }
        (breadcrumb options
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        )
        [ { label = "Divider"
          , description = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
          , content =
                select [ onInput (dividerFromString >> Maybe.withDefault model.divider >> ChangeDivider) ] <|
                    List.map (\divider -> option [ value (dividerToString divider), selected (model.divider == divider) ] [ text (dividerToString divider) ])
                        [ Slash, RightChevron ]
          }
        ]
    , configAndPreview { title = "Active" }
        (breadcrumb { divider = text "/", theme = theme }
            [ { label = "Products", url = "/" }
            , { label = "Paper Towels", url = "" }
            ]
        )
        []
    , configAndPreview { title = "Inverted" }
        (segment { theme = Dark }
            []
            [ breadcrumb { divider = text "/", theme = Dark }
                [ { label = "Home", url = "/" }
                , { label = "Registration", url = "/" }
                , { label = "Personal Information", url = "" }
                ]
            ]
        )
        []
    ]



-- HELPER


type Divider
    = Slash
    | RightChevron


dividerFromString : String -> Maybe Divider
dividerFromString string =
    case string of
        "Slash" ->
            Just Slash

        "RightChevron" ->
            Just RightChevron

        _ ->
            Nothing


dividerToString : Divider -> String
dividerToString divider =
    case divider of
        Slash ->
            "Slash"

        RightChevron ->
            "RightChevron"
