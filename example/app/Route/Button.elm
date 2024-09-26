module Route.Button exposing (Model, Msg, RouteParams, route, Data, ActionData)

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
import Route exposing (Route(..))
import RouteBuilder
import Shared
import UI.Button as Button exposing (IconPosition(..), Layout(..), Size(..), Variant(..))
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
    Button.Props Msg


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect Msg )
init app shared =
    ( { layout = Intrinsic
      , size = Large
      , variant = Contained
      , icon = Nothing
      , iconPosition = Start
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = UpdateProps (Button.Props Msg -> Button.Props Msg)


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
    { title = "Button"
    , body =
        List.map (Html.map PagesMsg.fromMsg)
            [ buttonPlayground False model ]
    }


buttonPlayground : Bool -> Button.Props Msg -> Html Msg
buttonPlayground isDarkMode props =
    playground
        { isDarkMode = isDarkMode
        , toMsg = UpdateProps
        , preview = Button.button props [ text "Button" ]
        , controlSections =
            [ { heading = "Props"
              , controls =
                    [ Field "size"
                        (Control.select
                            { value = sizeToString props.size
                            , options = List.map sizeToString [ Large, Medium, Small ]
                            , onChange =
                                \string props_ ->
                                    sizeFromString string
                                        |> Maybe.map (\size_ -> { props_ | size = size_ })
                                        |> Maybe.withDefault props_
                            }
                        )
                    , Field "variant"
                        (Control.select
                            { value = variantToString props.variant
                            , options = List.map variantToString [ Contained, Outlined, Lighted, Neutral, Danger ]
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


sizeToString : Size -> String
sizeToString size =
    case size of
        Large ->
            "Large"

        Medium ->
            "Medium"

        Small ->
            "Small"


sizeFromString : String -> Maybe Size
sizeFromString str =
    case str of
        "Large" ->
            Just Large

        "Medium" ->
            Just Medium

        "Small" ->
            Just Small

        _ ->
            Nothing


variantToString : Variant -> String
variantToString variant =
    case variant of
        Contained ->
            "Contained"

        Outlined ->
            "Outlined"

        Lighted ->
            "Lighted"

        Neutral ->
            "Neutral"

        Danger ->
            "Danger"


variantFromString : String -> Maybe Variant
variantFromString str =
    case str of
        "Contained" ->
            Just Contained

        "Outlined" ->
            Just Outlined

        "Lighted" ->
            Just Lighted

        "Neutral" ->
            Just Neutral

        "Danger" ->
            Just Danger

        _ ->
            Nothing
