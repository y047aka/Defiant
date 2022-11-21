module Pages.Navigation.Breadcrumb exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html)
import Layouts.Default exposing (layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Types exposing (Size(..), sizeFromString, sizeToString)
import UI.Breadcrumb exposing (Divider(..), bigBreadCrumb, dividerFromString, dividerToString, hugeBreadCrumb, largeBreadCrumb, massiveBreadCrumb, mediumBreadCrumb, miniBreadCrumb, smallBreadCrumb, tinyBreadCrumb)
import View.Playground exposing (playground)


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
                    |> layout shared route
        }



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
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    let
        options =
            { divider = model.divider, theme = theme }
    in
    [ let
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
        , toMsg = UpdateConfig
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
            [ { label = "Content"
              , configs =
                    [ { label = "Divider"
                      , config =
                            Config.select
                                { value = model.divider
                                , options = [ Slash, RightChevron ]
                                , fromString = dividerFromString
                                , toString = dividerToString
                                , setter = \divider m -> { m | divider = divider }
                                }
                      , note = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
                      }
                    ]
              }
            , { label = "Variations"
              , configs =
                    [ { label = "Size"
                      , config =
                            Config.select
                                { value = model.size
                                , options = [ Mini, Tiny, Small, Medium, Large, Big, Huge, Massive ]
                                , fromString = sizeFromString
                                , toString = sizeToString
                                , setter = \size m -> { m | size = size }
                                }
                      , note = "A breadcrumb can vary in size"
                      }
                    ]
              }
            ]
        }
    ]
