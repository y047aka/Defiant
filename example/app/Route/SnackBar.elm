module Route.SnackBar exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import ApiReference
import BackendTask
import Control
import Effect exposing (Effect)
import FatalError
import Html.Styled as Html exposing (Html, h2, text)
import PagesMsg
import Playground exposing (Node(..))
import RouteBuilder
import Shared
import UI.Icon as Icon
import UI.SnackBar as SnackBar exposing (Position(..), Variant(..))
import View


type alias RouteParams =
    {}


route : RouteBuilder.StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single
        { data = data, head = \_ -> [] }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = \_ _ _ _ -> Sub.none
            }



-- MODEL


type alias Model =
    { icon : String

    -- SnackBarProps
    , active : Bool
    , position : Position
    , duration : Int -- milliseconds to hide
    , variant : Variant
    }


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect Msg )
init app shared =
    ( { icon = "information"
      , active = True
      , position = TopCenter
      , duration = 300
      , variant = SnackBar.Information
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = UpdateProps (Model -> Model)


update :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect Msg )
update app shared msg model =
    case msg of
        UpdateProps updater ->
            ( updater model, Effect.none )



-- DATA


type alias Data =
    {}


type alias ActionData =
    BackendTask.BackendTask FatalError.FatalError (List RouteParams)


data : BackendTask.BackendTask FatalError.FatalError Data
data =
    BackendTask.succeed {}



-- VIEW


view :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View.View (PagesMsg.PagesMsg Msg)
view app shared model =
    { title = "SnackBar"
    , body =
        List.map (Html.map PagesMsg.fromMsg)
            [ playground False model
            , section "API Reference"
                [ apiReferenceTable ]
            ]
    }


playground : Bool -> Model -> Html Msg
playground isDarkMode model =
    Playground.playground
        { isDarkMode = isDarkMode
        , toMsg = UpdateProps
        , preview =
            SnackBar.frame
                { active = model.active
                , position = model.position
                , duration = model.duration
                , variant = model.variant
                }
                [ SnackBar.icon [ iconFromString model.icon ]
                , SnackBar.text [ text "「今日のランチは道玄坂で」の記事に新しいコメントが3件あります。" ]
                , SnackBar.textButton { setIsShow = True, variant = SnackBar.Information, icon = text "" } [ text "取り消し" ]
                ]
        , controlSections =
            [ { heading = ""
              , controls =
                    [ Field "icon"
                        (Control.select
                            { value = model.icon
                            , options = [ "information", "checkCircleFill" ]
                            , onChange =
                                \icon props_ -> { props_ | icon = icon }
                            }
                        )
                    ]
              }
            , { heading = "Props"
              , controls =
                    [ Field "active"
                        (Control.bool
                            { id = "active"
                            , value = model.active
                            , onChange = \_ ps -> { ps | active = not ps.active }
                            }
                        )
                    , Field "position"
                        (Control.select
                            { value = positionToString model.position
                            , options = List.map positionToString [ TopLeft, TopCenter, TopRight, BottomLeft, BottomCenter, BottomRight ]
                            , onChange =
                                \string ps ->
                                    positionFromString string
                                        |> Maybe.map (\position -> { ps | position = position })
                                        |> Maybe.withDefault ps
                            }
                        )
                    , Field "variant"
                        (Control.select
                            { value = variantToString model.variant
                            , options = List.map variantToString [ Information, Confirmation, Error ]
                            , onChange =
                                \string props_ ->
                                    variantFromString string
                                        |> Maybe.map (\variant_ -> { props_ | variant = variant_ })
                                        |> Maybe.withDefault props_
                            }
                        )
                    ]
              }
            ]
        }


apiReferenceTable : Html msg
apiReferenceTable =
    ApiReference.table
        [ { prop = "active", type_ = "Bool", variants = [], default = "False" }
        , { prop = "position"
          , type_ = "Position"
          , variants = List.map positionToString [ TopLeft, TopCenter, TopRight, BottomLeft, BottomCenter, BottomRight ]
          , default = "-"
          }
        , { prop = "duration", type_ = "Int", variants = [], default = "300" }
        , { prop = "variant"
          , type_ = "Variant"
          , variants = List.map variantToString [ Information, Confirmation, Error ]
          , default = "-"
          }
        ]


section : String -> List (Html msg) -> Html msg
section title children =
    Html.section []
        (h2 [] [ text title ] :: children)


iconFromString : String -> Html msg
iconFromString str =
    case str of
        "information" ->
            Icon.information []

        "checkCircleFill" ->
            Icon.checkCircleFill []

        _ ->
            text ""


positionToString : Position -> String
positionToString position =
    case position of
        TopLeft ->
            "TopLeft"

        TopCenter ->
            "TopCenter"

        TopRight ->
            "TopRight"

        BottomLeft ->
            "BottomLeft"

        BottomCenter ->
            "BottomCenter"

        BottomRight ->
            "BottomRight"


positionFromString : String -> Maybe Position
positionFromString str =
    case str of
        "TopLeft" ->
            Just TopLeft

        "TopCenter" ->
            Just TopCenter

        "TopRight" ->
            Just TopRight

        "BottomLeft" ->
            Just BottomLeft

        "BottomCenter" ->
            Just BottomCenter

        "BottomRight" ->
            Just BottomRight

        _ ->
            Nothing


variantToString : Variant -> String
variantToString variant =
    case variant of
        Information ->
            "Information"

        Confirmation ->
            "Confirmation"

        Error ->
            "Error"


variantFromString : String -> Maybe Variant
variantFromString str =
    case str of
        "Information" ->
            Just Information

        "Confirmation" ->
            Just Confirmation

        "Error" ->
            Just Error

        _ ->
            Nothing
