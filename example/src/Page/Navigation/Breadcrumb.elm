module Page.Navigation.Breadcrumb exposing (Model, Msg, init, update, view)

import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Control
import Shared
import Types exposing (Size(..), sizeFromString, sizeToString)
import UI.Breadcrumb exposing (Divider(..), bigBreadCrumb, dividerFromString, dividerToString, hugeBreadCrumb, largeBreadCrumb, massiveBreadCrumb, mediumBreadCrumb, miniBreadCrumb, smallBreadCrumb, tinyBreadCrumb)
import UI.Header as Header



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
    let
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
    [ Header.header { theme = theme } [] [ text "Breadcrumb" ]
    , playground
        { theme = theme
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
                    [ Control.field "Inverted"
                        (Control.bool
                            { id = "inverted"
                            , value = model.inverted
                            , onClick = (\ps -> { ps | inverted = not ps.inverted }) |> UpdateConfig
                            }
                        )
                    ]
              }
            , { label = "Content"
              , configs =
                    [ Control.field "Divider"
                        (Control.select
                            { value = dividerToString model.divider
                            , options = List.map dividerToString [ Slash, RightChevron ]
                            , onChange =
                                (\divider ps ->
                                    dividerFromString divider
                                        |> Maybe.map (\d -> { ps | divider = d })
                                        |> Maybe.withDefault ps
                                )
                                    >> UpdateConfig
                            }
                        )
                    , Control.comment "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
                    ]
              }
            , { label = "Variations"
              , configs =
                    [ Control.field "Size"
                        (Control.select
                            { value = sizeToString model.size
                            , options = List.map sizeToString [ Mini, Tiny, Small, Medium, Large, Big, Huge, Massive ]
                            , onChange =
                                (\size ps ->
                                    sizeFromString size
                                        |> Maybe.map (\s -> { ps | size = s })
                                        |> Maybe.withDefault ps
                                )
                                    >> UpdateConfig
                            }
                        )
                    , Control.comment "A breadcrumb can vary in size"
                    ]
              }
            ]
        }
    ]
