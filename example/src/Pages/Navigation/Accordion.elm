module Pages.Navigation.Accordion exposing (Model, Msg, init, update, view)

import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, p, text)
import Playground exposing (playground)
import Shared
import UI.Accordion as Accordion exposing (ToggleMethod(..), accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl)



-- INIT


type alias Model =
    { toggleMethod : ToggleMethod
    , inverted : Bool
    }


init : Model
init =
    { toggleMethod = SummaryDetails
    , inverted = False
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
view shared { toggleMethod, inverted } =
    let
        theme =
            if inverted then
                Dark

            else
                shared.theme

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
    [ playground
        { title = "Accordion"
        , theme = shared.theme
        , inverted = inverted
        , preview =
            [ case toggleMethod of
                SummaryDetails ->
                    accordion_SummaryDetails { theme = theme } [] items

                TargetUrl ->
                    accordion_TargetUrl { theme = theme } [] items

                Checkbox ->
                    accordion_Checkbox { theme = theme } [] items

                Radio ->
                    accordion_Radio { theme = theme } [] items
            ]
        , configSections =
            [ { label = ""
              , configs =
                    [ Playground.bool
                        { id = "inverted"
                        , label = "Inverted"
                        , bool = inverted
                        , onClick = (\c -> { c | inverted = not c.inverted }) |> UpdateConfig
                        , note = ""
                        }
                    ]
              }
            , { label = "Toggle Method"
              , configs =
                    [ Playground.select
                        { label = ""
                        , value = toggleMethod
                        , options = [ SummaryDetails, TargetUrl, Checkbox, Radio ]
                        , fromString = Accordion.toggleMethodFromString
                        , toString = Accordion.toggleMethodToString
                        , onChange = (\method m -> { m | toggleMethod = method }) >> UpdateConfig
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
            ]
        }
    ]
