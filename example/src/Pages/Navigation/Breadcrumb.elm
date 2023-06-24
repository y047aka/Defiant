module Pages.Navigation.Breadcrumb exposing (Model, Msg, page)

import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled exposing (Html)
import Layouts exposing (Layout)
import Page exposing (Page)
import Playground exposing (playground)
import Route exposing (Route)
import Shared
import Types exposing (Size(..), sizeFromString, sizeToString)
import UI.Breadcrumb exposing (Divider(..), bigBreadCrumb, dividerFromString, dividerToString, hugeBreadCrumb, largeBreadCrumb, massiveBreadCrumb, mediumBreadCrumb, miniBreadCrumb, smallBreadCrumb, tinyBreadCrumb)


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
            \model ->
                { title = "Breadcrumb"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    { divider : Divider
    , inverted : Bool
    , size : Size
    }


init : Model
init =
    { divider = Slash
    , inverted = False
    , size = Medium
    }



-- UPDATE


type Msg
    = UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    [ let
        options =
            { divider = model.divider, theme = theme }

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
      playground
        { title = "Breadcrumb"
        , theme = theme
        , inverted = model.inverted
        , preview =
            [ breadcrumb_ options
                [ { label = "Home", url = "/" }
                , { label = "Store", url = "/" }
                , { label = "T-Shirt", url = "" }
                ]
            ]
        , configSections =
            [ { label = ""
              , configs =
                    [ Playground.bool
                        { id = "inverted"
                        , label = "Inverted"
                        , bool = model.inverted
                        , onClick = (\c -> { c | inverted = not c.inverted }) |> UpdateConfig
                        , note = ""
                        }
                    ]
              }
            , { label = "Content"
              , configs =
                    [ Playground.select
                        { label = "Divider"
                        , value = model.divider
                        , options = [ Slash, RightChevron ]
                        , fromString = dividerFromString
                        , toString = dividerToString
                        , onChange = (\divider c -> { c | divider = divider }) >> UpdateConfig
                        , note = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
                        }
                    ]
              }
            , { label = "Variations"
              , configs =
                    [ Playground.select
                        { label = "Size"
                        , value = model.size
                        , options = [ Mini, Tiny, Small, Medium, Large, Big, Huge, Massive ]
                        , fromString = sizeFromString
                        , toString = sizeToString
                        , onChange = (\size c -> { c | size = size }) >> UpdateConfig
                        , note = "A breadcrumb can vary in size"
                        }
                    ]
              }
            ]
        }
    ]
