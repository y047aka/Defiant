module Pages.Modules.Accordion exposing (page)

import Html.Styled as Html exposing (Html, p, text)
import Html.Styled.Attributes exposing (id)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Accordion exposing (ToggleMethod(..), accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl, headless)
import UI.Example exposing (example)
import UI.Segment exposing (segment)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Accordion"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
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
    [ example
        { title = "Accordion"
        , description = "A standard accordion"
        }
        [ accordion_SummaryDetails { inverted = shared.darkMode } [] items ]
    , example
        { title = "Accordion - checkbox"
        , description = "A standard accordion with checkbox"
        }
        [ accordion_Checkbox { inverted = shared.darkMode } [] items ]
    , example
        { title = "Accordion - radio button"
        , description = "A standard accordion with radio button"
        }
        [ accordion_Radio { inverted = shared.darkMode } [] items ]
    , example
        { title = "Accordion - target URL"
        , description = "A standard accordion with target URL"
        }
        [ accordion_TargetUrl { inverted = shared.darkMode } [] items ]
    , example
        { title = "Inverted"
        , description = "An accordion can be formatted to appear on dark backgrounds"
        }
        [ segment { inverted = True }
            []
            [ headless { toggleMethod = SummaryDetails } [] items ]
        ]
    ]
