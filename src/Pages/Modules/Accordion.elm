module Pages.Modules.Accordion exposing (Model, Msg, page)

import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, option, p, select, text)
import Html.Styled.Attributes exposing (id, selected, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Accordion as Accordion exposing (ToggleMethod(..), accordionUnstyled, accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl)
import UI.Segment exposing (segment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init shared
        , update = update
        , view =
            \model ->
                { title = "Accordion"
                , body = view model
                }
        }



-- INIT


type alias Model =
    { shared : Shared.Model
    , toggleMethod : ToggleMethod
    }


init : Shared.Model -> Model
init shared =
    { shared = shared
    , toggleMethod = SummaryDetails
    }



-- UPDATE


type Msg
    = ChangeToggleMethod ToggleMethod


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeToggleMethod method ->
            { model | toggleMethod = method }



-- VIEW


view : Model -> List (Html Msg)
view { shared, toggleMethod } =
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
    [ configAndPreview { title = "Accordion" }
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
        [ { label = "Toggle Method"
          , description =
                case toggleMethod of
                    SummaryDetails ->
                        "A standard accordion with summary/details tag"

                    TargetUrl ->
                        "A standard accordion with target URL"

                    Checkbox ->
                        "A standard accordion with checkbox"

                    Radio ->
                        "A standard accordion with radio button"
          , content =
                select [ onInput (Accordion.toggleMethodFromString >> Maybe.withDefault toggleMethod >> ChangeToggleMethod) ] <|
                    List.map (\method -> option [ value (Accordion.toggleMethodToString method), selected (toggleMethod == method) ] [ text (Accordion.toggleMethodToString method) ])
                        [ SummaryDetails, TargetUrl, Checkbox, Radio ]
          }
        ]
    , configAndPreview
        { title = "Inverted" }
        [ segment { theme = Dark }
            []
            [ accordionUnstyled { toggleMethod = SummaryDetails } [] items ]
        ]
        []
    ]
