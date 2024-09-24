module Route.SnackBar exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Control
import Effect exposing (Effect)
import FatalError
import Html.Styled as Html exposing (Html, text)
import PagesMsg
import Playground exposing (Node(..), playground)
import RouteBuilder
import Shared
import UI.Icon as Icon
import UI.SnackBar as SnackBar exposing (Variant(..))
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
    SnackBar.Props


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect Msg )
init app shared =
    ( { active = True
      , position = { vertical = "topCenter" }
      , duration = 300
      , variant = SnackBar.Information
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = UpdateSnackBarProps (SnackBar.Props -> SnackBar.Props)


update :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect Msg )
update app shared msg model =
    case msg of
        UpdateSnackBarProps updater ->
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
            [ snackBarPlayground False model ]
    }


snackBarPlayground : Bool -> SnackBar.Props -> Html Msg
snackBarPlayground isDarkMode props =
    playground
        { isDarkMode = isDarkMode
        , toMsg = UpdateSnackBarProps
        , preview =
            SnackBar.frame props
                [ SnackBar.icon [ Icon.information [] ]
                , SnackBar.text [ text "「今日のランチは道玄坂で」の記事に新しいコメントが3件あります。" ]
                , SnackBar.textButton { setIsShow = True, variant = SnackBar.Information, icon = text "" } [ text "取り消し" ]
                ]
        , controlSections =
            [ { heading = "Props"
              , controls =
                    [ Field "variant"
                        (Control.select
                            { value = variantToString props.variant
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
