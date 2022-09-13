module Pages.Navigation.Breadcrumb exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Effect exposing (Effect)
import Html.Styled as Html exposing (Html)
import Page
import Request exposing (Request)
import Shared
import Types exposing (Size(..), sizeFromString, sizeToString)
import UI.Breadcrumb exposing (Divider(..), bigBreadCrumb, dividerFromString, dividerToString, hugeBreadCrumb, largeBreadCrumb, massiveBreadCrumb, mediumBreadCrumb, miniBreadCrumb, smallBreadCrumb, tinyBreadCrumb)
import UI.Checkbox as Checkbox
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.advanced
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Breadcrumb"
                , body = view shared model
                }
        , subscriptions = \_ -> Sub.none
        }



-- INIT


type alias Model =
    { divider : Divider
    , size : Size
    }


init : ( Model, Effect Msg )
init =
    ( { divider = Slash
      , size = Medium
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model Msg)
    | ChangeTheme Theme


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        UpdateConfig configMsg ->
            case configMsg of
                Config.Custom (ChangeTheme theme) ->
                    ( model, Effect.fromShared (Shared.ChangeTheme theme) )

                _ ->
                    ( Config.update configMsg model, Effect.none )

        ChangeTheme _ ->
            ( model, Effect.none )



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
      configAndPreview UpdateConfig { theme = theme } <|
        { title = "Breadcrumb"
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
                    [ { label = ""
                      , config =
                            Checkbox.toggleCheckbox
                                { id = "inverted"
                                , label = "Inverted"
                                , checked = theme == Dark
                                , disabled = False
                                , onClick =
                                    Config.Custom <|
                                        ChangeTheme <|
                                            case theme of
                                                System ->
                                                    Dark

                                                Light ->
                                                    Dark

                                                Dark ->
                                                    Light
                                }
                      , note = "A breadcrumb can be inverted"
                      }
                    , { label = "Size"
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
