module Category.Modules exposing
    ( Model, init, Msg, update
    , examplesForAccordion, examplesForCheckbox, examplesForDimmer, examplesForModal, examplesForProgress, examplesForTab
    )

{-|

@docs Model, init, Msg, update
@docs examplesForAccordion, examplesForCheckbox, examplesForDimmer, examplesForModal, examplesForProgress, examplesForTab

-}

import Html.Styled as Html exposing (Html, a, div, p, text)
import Html.Styled.Attributes as Attributes exposing (for, href, id, src, type_)
import Html.Styled.Events exposing (onClick)
import Random
import UI.Accordion exposing (accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl)
import UI.Button exposing (..)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.Dimmer as Dimmer exposing (dimmer, pageDimmer)
import UI.Example exposing (..)
import UI.Header as Header exposing (..)
import UI.Icon exposing (icon)
import UI.Image exposing (smallImage)
import UI.Label exposing (..)
import UI.Modal as Modal exposing (..)
import UI.Progress as Progress
import UI.Segment exposing (..)
import UI.Tab exposing (State(..), tab)


type alias Model =
    { darkMode : Bool
    , toggledItems : List String
    , progress : Float
    }


init : Bool -> ( Model, Cmd Msg )
init darkMode =
    ( { darkMode = darkMode
      , toggledItems = []
      , progress = 0
      }
    , Random.generate NewProgress (Random.int 10 50)
    )


type Msg
    = Toggle String
    | ProgressPlus
    | ProgressMinus
    | NewProgress Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle newItem ->
            ( { model
                | toggledItems =
                    if List.member newItem model.toggledItems then
                        List.filter ((/=) newItem) model.toggledItems

                    else
                        newItem :: model.toggledItems
              }
            , Cmd.none
            )

        ProgressPlus ->
            ( model, Random.generate NewProgress (Random.int 10 15) )

        ProgressMinus ->
            ( model, Random.generate NewProgress (Random.int -15 -10) )

        NewProgress int ->
            let
                calculated =
                    model.progress + toFloat int

                newProgress =
                    if calculated > 100 then
                        100

                    else if calculated < 0 then
                        0

                    else
                        calculated
            in
            ( { model | progress = newProgress }, Cmd.none )


examplesForAccordion : { inverted : Bool } -> List (Html msg)
examplesForAccordion options =
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
                        , title = [ text title ]
                        , content = List.map (\c -> p [] [ text c ]) contents
                        }
                    )
    in
    [ example
        { title = "Accordion"
        , description = "A standard accordion"
        }
        [ accordion_SummaryDetails options [] items ]
    , example
        { title = "Accordion - checkbox"
        , description = "A standard accordion with checkbox"
        }
        [ accordion_Checkbox options [] items ]
    , example
        { title = "Accordion - radio button"
        , description = "A standard accordion with radio button"
        }
        [ accordion_Radio options [] items ]
    , example
        { title = "Accordion - target URL"
        , description = "A standard accordion with target URL"
        }
        [ accordion_TargetUrl options [] items ]
    , example
        { title = "Inverted"
        , description = "An accordion can be formatted to appear on dark backgrounds"
        }
        [ segment { inverted = True }
            []
            [ accordion_SummaryDetails { inverted = True } [] items ]
        ]
    ]


examplesForCheckbox : List (Html msg)
examplesForCheckbox =
    [ example
        { title = "Checkbox"
        , description = "A checkbox allows a user to select a value from a small set of options, often binary"
        }
        [ checkbox []
            [ Checkbox.input [ id "checkbox_example", type_ "checkbox" ] []
            , Checkbox.label [ for "checkbox_example" ] [ text "Make my profile visible" ]
            ]
        ]
    ]


examplesForDimmer : { a | toggledItems : List String, darkMode : Bool } -> List (Html Msg)
examplesForDimmer { toggledItems, darkMode } =
    let
        options =
            { inverted = darkMode }
    in
    [ example
        { title = "Dimmer"
        , description = "A simple dimmer displays no content"
        }
        [ segment options
            []
            [ Header.header options [] [ text "Overlayable Section" ]
            , div [] <|
                List.repeat 1 (smallImage [ src "./static/images/wireframe/image.png" ] [])
            , wireframeMediaParagraph
            , dimmer { isActive = List.member "dimmer" toggledItems, inverted = False } [ onClick (Toggle "dimmer") ] []
            ]
        , button [ onClick (Toggle "dimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
    , example
        { title = "Content Dimmer"
        , description = "A dimmer can display content"
        }
        [ segment options
            []
            [ Header.header options [] [ text "Overlayable Section" ]
            , div [] <|
                List.repeat 1 (smallImage [ src "./static/images/wireframe/image.png" ] [])
            , wireframeMediaParagraph
            , dimmer { isActive = List.member "contentDimmer" toggledItems, inverted = False }
                [ onClick (Toggle "contentDimmer") ]
                [ Dimmer.content []
                    [ iconHeader { inverted = True }
                        []
                        [ icon [] "fas fa-heart", text "Dimmed Message!" ]
                    ]
                ]
            ]
        , button [ onClick (Toggle "contentDimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
    , example
        { title = "Page Dimmer"
        , description = "A dimmer can be formatted to be fixed to the page"
        }
        [ button [ onClick (Toggle "pageDimmer") ] [ icon [] "fas fa-plus", text "Show" ]
        , pageDimmer (List.member "pageDimmer" toggledItems)
            [ onClick (Toggle "pageDimmer") ]
            [ iconHeader { inverted = True }
                []
                [ icon [] "fas fa-envelope"
                , text "Dimmer Message"
                , subHeader { inverted = True }
                    []
                    [ text "Dimmer sub-header" ]
                ]
            ]
        ]
    , example
        { title = "Inverted Dimmer"
        , description = "A dimmer can be formatted to have its colors inverted"
        }
        [ segment options
            []
            [ wireframeShortParagraph
            , wireframeShortParagraph
            , dimmer { isActive = List.member "invertedDimmer" toggledItems, inverted = True }
                [ onClick (Toggle "invertedDimmer") ]
                []
            ]
        , button [ onClick (Toggle "invertedDimmer") ] [ icon [] "fas fa-plus", text "Toggle" ]
        ]
    ]


examplesForModal : { a | toggledItems : List String, darkMode : Bool } -> List (Html Msg)
examplesForModal { toggledItems, darkMode } =
    let
        options =
            { inverted = darkMode }
    in
    [ example
        { title = "Modal"
        , description = "A standard modal"
        }
        [ button [ onClick (Toggle "modal") ] [ icon [] "fas fa-plus", text "Show" ]
        , pageDimmer (List.member "modal" toggledItems)
            [ onClick (Toggle "modal") ]
            [ modal options
                []
                { header = [ text "Select a Photo" ]
                , content =
                    [ Modal.description []
                        [ p []
                            [ text "We've found the following "
                            , a [ href "https://www.gravatar.com", Attributes.target "_blank" ] [ text "gravatar" ]
                            , text " image associated with your e-mail address."
                            ]
                        , p [] [ text "Is it okay to use this photo?" ]
                        ]
                    ]
                , actions =
                    [ blackButton [] [ text "Nope" ]
                    , greenButton [] [ text "Yep, that's me" ]
                    ]
                }
            ]
        ]
    , example
        { title = "Basic"
        , description = "A modal can reduce its complexity"
        }
        [ button [ onClick (Toggle "basicModal") ] [ icon [] "fas fa-plus", text "Show" ]
        , pageDimmer (List.member "basicModal" toggledItems)
            [ onClick (Toggle "basicModal") ]
            [ basicModal []
                { header = [ text "Archive Old Messages" ]
                , content =
                    [ Modal.description []
                        [ p [] [ text "Your inbox is getting full, would you like us to enable automatic archiving of old messages?" ] ]
                    ]
                , actions =
                    [ redButton [] [ text "No" ]
                    , greenButton [] [ text "Yes" ]
                    ]
                }
                []
            ]
        ]
    ]


examplesForProgress : Model -> List (Html Msg)
examplesForProgress model =
    let
        controller =
            labeledButton []
                [ button [ onClick ProgressMinus ] [ text "-" ]
                , basicLabel [] [ text (String.fromFloat model.progress ++ "%") ]
                , button [ onClick ProgressPlus ] [ text "+" ]
                ]
    in
    [ example
        { title = "Standard"
        , description = "A standard progress bar"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Uploading Files"
            , indicating = False
            , disabled = False
            , state = Progress.Default
            }
        , controller
        ]
    , example
        { title = "Indicating"
        , description = "An indicating progress bar visually indicates the current level of progress of a task"
        }
        [ Progress.progress
            { value = model.progress
            , progress = ""
            , label =
                if model.progress == 100 then
                    "Project Funded!"

                else
                    String.fromFloat model.progress ++ "% Funded"
            , indicating = True
            , disabled = False
            , state = Progress.Active
            }
        , controller
        ]
    , example
        { title = "Bar"
        , description = "A progress element can contain a bar visually indicating progress"
        }
        [ Progress.progress
            { value = model.progress
            , progress = ""
            , label = ""
            , indicating = False
            , disabled = False
            , state = Progress.Default
            }
        ]
    , example
        { title = "Progress"
        , description = "A progress bar can contain a text value indicating current progress"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = ""
            , indicating = False
            , disabled = False
            , state = Progress.Default
            }
        ]
    , example
        { title = "Label"
        , description = "A progress element can contain a label"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Uploading Files"
            , indicating = False
            , disabled = False
            , state = Progress.Default
            }
        ]
    , example
        { title = "Active"
        , description = "A progress bar can show activity"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Uploading Files"
            , indicating = False
            , disabled = False
            , state = Progress.Active
            }
        ]
    , example
        { title = "Success"
        , description = "A progress bar can show a success state"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Everything worked, your file is all ready."
            , indicating = False
            , disabled = False
            , state = Progress.Success
            }
        ]
    , example
        { title = "Warning"
        , description = "A progress bar can show a warning state"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "Your file didn't meet the minimum resolution requirements."
            , indicating = False
            , disabled = False
            , state = Progress.Warning
            }
        ]
    , example
        { title = "Error"
        , description = "A progress bar can show an error state"
        }
        [ Progress.progress
            { value = model.progress
            , progress = String.fromFloat model.progress ++ "%"
            , label = "There was an error."
            , indicating = False
            , disabled = False
            , state = Progress.Error
            }
        ]
    , example
        { title = "Disabled"
        , description = "A progress bar can be disabled"
        }
        [ Progress.progress
            { value = model.progress
            , progress = ""
            , label = ""
            , indicating = False
            , disabled = True
            , state = Progress.Default
            }
        ]
    ]


examplesForTab : List (Html msg)
examplesForTab =
    [ example
        { title = "Tab"
        , description = "A basic tab"
        }
        [ tab { state = Inactive }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    , example
        { title = "Active"
        , description = "A tab can be activated, and visible on the page"
        }
        [ tab { state = Active }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    , example
        { title = "Loading"
        , description = "A tab can display a loading indicator"
        }
        [ tab { state = Loading }
            []
            [ wireframeParagraph
            , wireframeParagraph
            ]
        ]
    ]
