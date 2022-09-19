module Pages.Navigation.Accordion exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Effect exposing (Effect)
import Html.Styled as Html exposing (Html, p, text)
import Html.Styled.Attributes exposing (id)
import Page
import Request exposing (Request)
import Shared
import UI.Accordion as Accordion exposing (ToggleMethod(..), accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.advanced
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Accordion"
                , body = view shared model
                }
        , subscriptions = \_ -> Sub.none
        }



-- INIT


type alias Model =
    { toggleMethod : ToggleMethod
    , inverted : Bool
    }


init : ( Model, Effect Msg )
init =
    ( { toggleMethod = SummaryDetails
      , inverted = False
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        UpdateConfig configMsg ->
            let
                newModel =
                    Config.update configMsg model

                effect =
                    case ( newModel.inverted == model.inverted, newModel.inverted ) of
                        ( True, _ ) ->
                            Effect.none

                        ( False, True ) ->
                            Effect.fromShared (Shared.ChangeTheme Dark)

                        ( False, False ) ->
                            Effect.fromShared (Shared.ChangeTheme Light)
            in
            ( newModel, effect )



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view shared { toggleMethod } =
    let
        items =
            [ { id = "what_is_a_dog"
              , title = "What is a dog?"
              , contents = [ "A dog is a type of domesticated animal. Known for its loyalty and faithfulness, it can be found as a welcome guest in many households across the world." ]
              }
            , { id = "what_kinds_of_dogs_are_there"
              , title = "What kinds of dogs are there?"
              , contents = [ "There are many breeds of dogs. Each breed varies in size and temperament. Owners often select a breed of dog that they find to be compatible with their own lifestyle and desires from a companion." ]
              }
            , { id = "how_do_you_acquire_a_dog"
              , title = "How do you acquire a dog?"
              , contents =
                    [ "Three common ways for a prospective owner to acquire a dog is from pet shops, private owners, or shelters."
                    , "A pet shop may be the most convenient way to buy a dog. Buying a dog from a private owner allows you to assess the pedigree and upbringing of your dog before choosing to take it home. Lastly, finding your dog from a shelter, helps give a good home to a dog who may not find one so readily."
                    ]
              }
            ]
                |> List.map
                    (\{ id, title, contents } ->
                        { id = id
                        , title = text title
                        , content = List.map (\c -> p [] [ text c ]) contents
                        }
                    )
    in
    [ configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Accordion"
        , preview =
            [ case toggleMethod of
                SummaryDetails ->
                    accordion_SummaryDetails { theme = shared.theme } [] items

                TargetUrl ->
                    accordion_TargetUrl { theme = shared.theme } [] items

                Checkbox ->
                    accordion_Checkbox { theme = shared.theme } [] items

                Radio ->
                    accordion_Radio { theme = shared.theme } [] items
            ]
        , configSections =
            [ { label = "Toggle Method"
              , configs =
                    [ { label = ""
                      , config =
                            Config.select
                                { value = toggleMethod
                                , options = [ SummaryDetails, TargetUrl, Checkbox, Radio ]
                                , fromString = Accordion.toggleMethodFromString
                                , toString = Accordion.toggleMethodToString
                                , setter = \method m -> { m | toggleMethod = method }
                                }
                      , note =
                            case toggleMethod of
                                SummaryDetails ->
                                    "A standard accordion with summary/details tag"

                                TargetUrl ->
                                    "A standard accordion with target URL"

                                Checkbox ->
                                    "A standard accordion with checkbox"

                                Radio ->
                                    "A standard accordion with radio button"
                      }
                    ]
              }
            , { label = "Variations"
              , configs =
                    [ { label = ""
                      , config =
                            Config.bool
                                { id = "inverted"
                                , label = "Inverted"
                                , bool = shared.theme == Dark
                                , setter = \m -> { m | inverted = not m.inverted }
                                }
                      , note = "An accordion can be formatted to appear on dark backgrounds"
                      }
                    ]
              }
            ]
        }
    ]
