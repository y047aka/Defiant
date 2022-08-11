module Pages.Collections.Breadcrumb exposing (Model, Msg, page)

import Data exposing (Size(..), sizeFromString, sizeToString)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, option, select, text)
import Html.Styled.Attributes exposing (selected, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Breadcrumb exposing (bigBreadCrumb, breadcrumb, hugeBreadCrumb, largeBreadCrumb, massiveBreadCrumb, mediumBreadCrumb, miniBreadCrumb, smallBreadCrumb, tinyBreadCrumb)
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
    { divider : Divider
    , size : Size
    }


init : Model
init =
    { divider = Slash
    , size = Medium
    }



-- UPDATE


type Msg
    = ChangeDivider Divider
    | ChangeSize Size


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeDivider divider ->
            { model | divider = divider }

        ChangeSize size ->
            { model | size = size }



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
    , let
        breadcrumb_ =
            case model.size of
                Mini ->
                    miniBreadCrumb

                Tiny ->
                    tinyBreadCrumb

                Small ->
                    smallBreadCrumb

                Medium ->
                    mediumBreadCrumb

                Large ->
                    largeBreadCrumb

                Big ->
                    bigBreadCrumb

                Huge ->
                    hugeBreadCrumb

                Massive ->
                    massiveBreadCrumb
      in
      configAndPreview { title = "Size" }
        (breadcrumb_ { divider = text "/", theme = System }
            [ { label = "Home", url = "/" }
            , { label = "Registration", url = "/" }
            , { label = "Personal Information", url = "" }
            ]
        )
        [ { label = "Size"
          , description = "A breadcrumb can vary in size"
          , content =
                select [ onInput (sizeFromString >> Maybe.withDefault model.size >> ChangeSize) ] <|
                    List.map (\size -> option [ value (sizeToString size), selected (model.size == size) ] [ text (sizeToString size) ])
                        [ Mini, Tiny, Small, Medium, Large, Big, Huge, Massive ]
          }
        ]
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
