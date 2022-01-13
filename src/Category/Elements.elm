module Category.Elements exposing
    ( Model, init, Msg, update
    , examplesForButton, examplesForContainer, examplesForDivider, examplesForHeader, examplesForIcon, examplesForImage, examplesForInput, examplesForLabel, examplesForLoader, examplesForPlaceholder, examplesForRail, examplesForSegment, examplesForStep, examplesForCircleStep, examplesForText
    )

{-|

@docs Model, init, Msg, update
@docs examplesForButton, examplesForContainer, examplesForDivider, examplesForHeader, examplesForIcon, examplesForImage, examplesForInput, examplesForLabel, examplesForLoader, examplesForPlaceholder, examplesForRail, examplesForSegment, examplesForStep, examplesForCircleStep, examplesForText

-}

import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html, a, h2, input, p, strong, text)
import Html.Styled.Attributes exposing (css, href, placeholder, src, type_)
import Html.Styled.Events exposing (onClick)
import UI.Button exposing (..)
import UI.CircleStep as CircleStep
import UI.Container exposing (container, textContainer)
import UI.Dimmer exposing (dimmer)
import UI.Divider exposing (divider)
import UI.Example exposing (..)
import UI.Grid as Grid exposing (fiveColumnsGrid)
import UI.Header as Header exposing (..)
import UI.Icon exposing (icon)
import UI.Image exposing (smallImage)
import UI.Input as Input
import UI.Label as Label exposing (..)
import UI.Loader exposing (loader, textLoader)
import UI.Placeholder as Placeholder exposing (line)
import UI.Rail exposing (leftRail, rightRail)
import UI.Segment exposing (..)
import UI.Step exposing (activeStep, completedStep, disabledStep, step, steps)
import UI.Table exposing (..)
import UI.Text exposing (..)


type alias Model =
    { darkMode : Bool
    , count : Int
    }


init : Bool -> ( Model, Cmd Msg )
init darkMode =
    ( { darkMode = darkMode
      , count = 0
      }
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )


examplesForButton : Model -> List (Html Msg)
examplesForButton { count } =
    [ example
        { title = "Button"
        , description = "A standard button"
        }
        [ button [] [ text "Follow" ] ]
    , example
        { title = ""
        , description = ""
        }
        [ button [] [ text "Button" ]
        , button [] [ text "Focusable" ]
        ]
    , example
        { title = "Emphasis"
        , description = "A button can be formatted to show different levels of emphasis"
        }
        [ primaryButton [] [ text "Save" ]
        , button [] [ text "Discard" ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ secondaryButton [] [ text "Okay" ]
        , button [] [ text "Cancel" ]
        ]
    , example
        { title = "Labeled"
        , description = "A button can appear alongside a label"
        }
        [ labeledButton []
            [ button [] [ icon [] "fas fa-heart", text "Like" ]
            , basicLabel [] [ text "2048" ]
            ]
        , labeledButton []
            [ button [ onClick Decrement ] [ text "-" ]
            , basicLabel [] [ text (String.fromInt count) ]
            , button [ onClick Increment ] [ text "+" ]
            ]
        ]
    , example
        { title = "Icon"
        , description = "A button can have only an icon"
        }
        [ button [] [ icon [] "fas fa-cloud" ] ]
    , example
        { title = "Basic"
        , description = "A basic button is less pronounced"
        }
        [ basicButton [] [ icon [] "fas fa-user", text "Add Friend" ] ]
    , example
        { title = "Colored"
        , description = "A button can have different colors"
        }
        [ primaryButton [] [ text "Primary" ]
        , secondaryButton [] [ text "Secondary" ]
        , redButton [] [ text "Red" ]
        , orangeButton [] [ text "Orange" ]
        , yellowButton [] [ text "Yellow" ]
        , oliveButton [] [ text "Olive" ]
        , greenButton [] [ text "Green" ]
        , tealButton [] [ text "Teal" ]
        , blueButton [] [ text "Blue" ]
        , violetButton [] [ text "Violet" ]
        , purpleButton [] [ text "Purple" ]
        , pinkButton [] [ text "Pink" ]
        , brownButton [] [ text "Brown" ]
        , greyButton [] [ text "Grey" ]
        , blackButton [] [ text "Black" ]
        ]
    ]


examplesForContainer : List (Html msg)
examplesForContainer =
    let
        content =
            p []
                [ text "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa "
                , strong [] [ text "strong" ]
                , text ". Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede "
                , a [ href "#" ] [ text "link" ]
                , text " mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi."
                ]
    in
    [ example
        { title = "Container"
        , description = "A standard container"
        }
        [ container [] [ content ] ]
    , example
        { title = "Text Container"
        , description = "A container can reduce its maximum width to more naturally accomodate a single column of text"
        }
        [ textContainer []
            [ h2 [] [ text "Header" ]
            , content
            , content
            ]
        ]
    ]


examplesForDivider : List (Html msg)
examplesForDivider =
    [ example
        { title = "Divider"
        , description = "A standard divider"
        }
        [ wireframeShortParagraph
        , divider [] []
        , wireframeShortParagraph
        ]
    ]


examplesForHeader : { inverted : Bool } -> List (Html msg)
examplesForHeader options =
    [ example
        { title = "Content Headers"
        , description = "Headers may be oriented to give the importance of a section in the context of the content that surrounds it"
        }
        [ massiveHeader options [] [ text "Massive Header" ]
        , wireframeShortParagraph
        , hugeHeader options [] [ text "Huge Header" ]
        , wireframeShortParagraph
        , bigHeader options [] [ text "Big Header" ]
        , wireframeShortParagraph
        , largeHeader options [] [ text "Large Header" ]
        , wireframeShortParagraph
        , mediumHeader options [] [ text "Medium Header" ]
        , wireframeShortParagraph
        , smallHeader options [] [ text "Small Header" ]
        , wireframeShortParagraph
        , tinyHeader options [] [ text "Tiny Header" ]
        , wireframeShortParagraph
        , miniHeader options [] [ text "Mini Header" ]
        , wireframeShortParagraph
        ]
    , example
        { title = "Icon Headers"
        , description = "A header can be formatted to emphasize an icon"
        }
        [ iconHeader options
            []
            [ icon [] "fas fa-cogs"
            , iconHeaderContent []
                [ text "Account Settings"
                , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
                ]
            ]
        ]
    , example
        { title = "Subheader"
        , description = "Headers may contain subheaders"
        }
        [ Header.header options
            []
            [ text "Account Settings"
            , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
            , wireframeShortParagraph
            ]
        ]
    ]


examplesForIcon : List (Html msg)
examplesForIcon =
    let
        column : List (Attribute msg) -> List (Html msg) -> Html msg
        column attributes =
            Grid.column <|
                css
                    [ -- #example .icon.example .grid > .column
                      opacity (num 0.8)
                    , textAlign center
                    , color transparent
                    , property "-moz-align-items" "center"
                    , property "-ms-align-items" "center"
                    , property "align-items" "center"

                    -- #example .icon.example .grid .column
                    , color (hex "#333333")
                    ]
                    :: attributes

        icon_ =
            icon
                [ css
                    [ -- #example .icon.example .column .icon
                      opacity (num 1)
                    , height (em 1)
                    , color (hex "#333333")
                    , display block
                    , margin3 (em 0) auto (em 0.25)
                    , fontSize (em 2)
                    ]
                ]
    in
    [ example
        { title = "Accessibility"
        , description = "Icons can represent accessibility standards"
        }
        [ fiveColumnsGrid []
            [ -- row 1
              column [] [ icon_ "fab fa-accessible-icon", text "accessible icon" ]
            , column [] [ icon_ "fas fa-american-sign-language-interpreting", text "american sign language interpreting" ]
            , column [] [ icon_ "fas fa-assistive-listening-systems", text "assistive listening systems" ]
            , column [] [ icon_ "fas fa-audio-description", text "audio description" ]
            , column [] [ icon_ "fas fa-blind", text "blind" ]

            -- row 2
            , column [] [ icon_ "fas fa-braille", text "braille" ]
            , column [] [ icon_ "fas fa-closed-captioning", text "closed captioning" ]
            , column [] [ icon_ "far fa-closed-captioning", text "closed captioning" ]
            , column [] [ icon_ "fas fa-deaf", text "deaf" ]
            , column [] [ icon_ "fas fa-low-vision", text "low vision" ]

            -- row 3
            , column [] [ icon_ "fas fa-phone-volume", text "phone volume" ]
            , column [] [ icon_ "fas fa-question-circle", text "question circle" ]
            , column [] [ icon_ "far fa-question-circle", text "question circle" ]
            , column [] [ icon_ "fas fa-sign-language", text "sign language" ]
            , column [] [ icon_ "fas fa-tty", text "tty" ]

            -- row 4
            , column [] [ icon_ "fas fa-universal-access", text "universal access" ]
            , column [] [ icon_ "fas fa-wheelchair", text "wheelchair" ]
            ]
        ]
    ]


examplesForImage : List (Html msg)
examplesForImage =
    [ example
        { title = "Image"
        , description = "An image"
        }
        [ smallImage [ src "./static/images/wireframe/image.png" ] [] ]
    ]


examplesForInput : List (Html msg)
examplesForInput =
    [ example
        { title = "Input"
        , description = "A standard input"
        }
        [ Input.input []
            [ input [ type_ "text", placeholder "Search..." ] [] ]
        ]
    , example
        { title = "Labeled"
        , description = "An input can be formatted with a label"
        }
        [ Input.input []
            [ Input.label [] [ text "http://" ]
            , input [ type_ "text", placeholder "mysite.com" ] []
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Input.input []
            [ input [ type_ "text", placeholder "Enter weight.." ] []
            , Input.label [] [ text "kg" ]
            ]
        ]
    ]


examplesForLabel : List (Html msg)
examplesForLabel =
    [ example
        { title = "Label"
        , description = "A label"
        }
        [ Label.label [] [ icon [] "fas fa-envelope", text "23" ] ]
    , example
        { title = "Icon"
        , description = "A label can include an icon"
        }
        [ Label.label [] [ icon [] "fas fa-envelope", text "Mail" ]
        , Label.label [] [ icon [] "fas fa-check", text "Test Passed" ]
        , Label.label [] [ icon [] "fas fa-dog", text "Dog" ]
        , Label.label [] [ icon [] "fas fa-cat", text "Cat" ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Label.label [] [ text "Mail", icon [] "fas fa-envelope" ]
        , Label.label [] [ text "Test Passed", icon [] "fas fa-check" ]
        , Label.label [] [ text "Dog", icon [] "fas fa-dog" ]
        , Label.label [] [ text "Cat", icon [] "fas fa-cat" ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ Label.label [] [ icon [] "fas fa-envelope" ]
        , Label.label [] [ icon [] "fas fa-dog" ]
        , Label.label [] [ icon [] "fas fa-cat" ]
        ]
    , example
        { title = "Basic"
        , description = "A label can reduce its complexity"
        }
        [ basicLabel [] [ text "Basic" ] ]
    , example
        { title = "Colored"
        , description = "A label can have different colors"
        }
        [ primaryLabel [] [ text "Primary" ]
        , secondaryLabel [] [ text "Secondary" ]
        , redLabel [] [ text "Red" ]
        , orangeLabel [] [ text "Orange" ]
        , yellowLabel [] [ text "Yellow" ]
        , oliveLabel [] [ text "Olive" ]
        , greenLabel [] [ text "Green" ]
        , tealLabel [] [ text "Teal" ]
        , blueLabel [] [ text "Blue" ]
        , violetLabel [] [ text "Violet" ]
        , purpleLabel [] [ text "Purple" ]
        , pinkLabel [] [ text "Pink" ]
        , brownLabel [] [ text "Brown" ]
        , greyLabel [] [ text "Grey" ]
        , blackLabel [] [ text "Black" ]
        ]
    ]


examplesForLoader : { inverted : Bool } -> List (Html msg)
examplesForLoader { inverted } =
    [ example
        { title = "Loader"
        , description = "A loader"
        }
        [ segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = False }
                []
                [ loader { inverted = False } [] [] ]
            ]
        ]
    , example
        { title = "Text Loader"
        , description = "A loader can contain text"
        }
        [ segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = False }
                []
                [ textLoader { inverted = False } [] [ text "Loading" ] ]
            ]
        , segment { inverted = inverted }
            []
            [ wireframeShortParagraph
            , dimmer { isActive = True, inverted = True }
                []
                [ textLoader { inverted = True } [] [ text "Loading" ] ]
            ]
        ]
    ]


examplesForPlaceholder : List (Html msg)
examplesForPlaceholder =
    [ example
        { title = "Lines"
        , description = "A placeholder can contain have lines of text"
        }
        [ Placeholder.placeholder []
            [ line [] []
            , line [] []
            , line [] []
            , line [] []
            , line [] []
            ]
        ]
    ]


examplesForRail : { inverted : Bool } -> List (Html msg)
examplesForRail options =
    [ example
        { title = "Rail"
        , description = "A rail can be presented on the left or right side of a container"
        }
        [ segment options
            [ css [ width (pct 45), left (pct 27.5) ] ]
            [ leftRail []
                [ segment options [] [ text "Left Rail Content" ] ]
            , rightRail []
                [ segment options [] [ text "Right Rail Content" ] ]
            , wireframeParagraph
            , wireframeParagraph
            ]
        ]
    ]


examplesForSegment : { inverted : Bool } -> List (Html msg)
examplesForSegment options =
    [ example
        { title = "Segment"
        , description = "A segment of content"
        }
        [ segment options [] [ wireframeShortParagraph ] ]
    , example
        { title = "Vertical Segment"
        , description = "A vertical segment formats content to be aligned as part of a vertical group"
        }
        [ verticalSegment options [] [ wireframeShortParagraph ]
        , verticalSegment options [] [ wireframeShortParagraph ]
        , verticalSegment options [] [ wireframeShortParagraph ]
        ]
    , example
        { title = "Disabled"
        , description = "A segment may show its content is disabled"
        }
        [ disabledSegment options [] [ wireframeShortParagraph ] ]
    , example
        { title = "Inverted"
        , description = "A segment can have its colors inverted for contrast"
        }
        [ invertedSegment []
            [ p [] [ text "I'm here to tell you something, and you will probably read me first." ] ]
        ]
    , example
        { title = "Padded"
        , description = "A segment can increase its padding"
        }
        [ paddedSegment options [] [ wireframeShortParagraph ] ]
    , example
        { title = ""
        , description = ""
        }
        [ veryPaddedSegment options [] [ wireframeShortParagraph ] ]
    , example
        { title = "Basic"
        , description = "A basic segment has no special formatting"
        }
        [ basicSegment options
            []
            [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
        ]
    ]


examplesForStep : List (Html msg)
examplesForStep =
    [ example
        { title = "Step"
        , description = "A single step"
        }
        [ steps []
            [ step []
                { icon = ""
                , title = ""
                , description = "Shipping"
                }
            ]
        ]
    , example
        { title = "Steps"
        , description = "A set of steps"
        }
        [ steps []
            [ step []
                { icon = "fas fa-truck"
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            , activeStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            , disabledStep []
                { icon = "fas fa-info"
                , title = "Confirm Order"
                , description = ""
                }
            ]
        ]
    , example
        { title = "Description"
        , description = "A step can contain a description"
        }
        [ steps []
            [ step []
                { icon = ""
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            ]
        ]
    , example
        { title = "Icon"
        , description = "A step can contain an icon"
        }
        [ steps []
            [ step []
                { icon = "fas fa-truck"
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            ]
        ]
    , example
        { title = "Active"
        , description = "A step can be highlighted as active"
        }
        [ steps []
            [ activeStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            ]
        ]
    , example
        { title = "Completed"
        , description = "A step can show that a user has completed it"
        }
        [ steps []
            [ completedStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            ]
        ]
    , example
        { title = "Disabled"
        , description = "A step can show that it cannot be selected"
        }
        [ steps []
            [ disabledStep []
                { icon = ""
                , title = ""
                , description = "Billing"
                }
            ]
        ]
    ]


examplesForCircleStep : List (Html msg)
examplesForCircleStep =
    [ example
        { title = "Step"
        , description = "A single step"
        }
        [ CircleStep.steps []
            [ CircleStep.step []
                { icon = ""
                , title = ""
                , description = "Shipping"
                }
            ]
        ]
    , example
        { title = "Steps"
        , description = "A set of steps"
        }
        [ CircleStep.steps []
            [ CircleStep.completedStep []
                { icon = "fas fa-truck"
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            , CircleStep.activeStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            , CircleStep.disabledStep []
                { icon = "fas fa-info"
                , title = "Confirm Order"
                , description = ""
                }
            ]
        ]
    , example
        { title = "Description"
        , description = "A step can contain a description"
        }
        [ CircleStep.steps []
            [ CircleStep.step []
                { icon = ""
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            ]
        ]
    , example
        { title = "Icon"
        , description = "A step can contain an icon"
        }
        [ CircleStep.steps []
            [ CircleStep.step []
                { icon = "fas fa-truck"
                , title = "Shipping"
                , description = "Choose your shipping options"
                }
            ]
        ]
    , example
        { title = "Active"
        , description = "A step can be highlighted as active"
        }
        [ CircleStep.steps []
            [ CircleStep.activeStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            ]
        ]
    , example
        { title = "Completed"
        , description = "A step can show that a user has completed it"
        }
        [ CircleStep.steps []
            [ CircleStep.completedStep []
                { icon = "fas fa-credit-card"
                , title = "Billing"
                , description = "Enter billing information"
                }
            ]
        ]
    , example
        { title = "Disabled"
        , description = "A step can show that it cannot be selected"
        }
        [ CircleStep.steps []
            [ CircleStep.disabledStep []
                { icon = ""
                , title = ""
                , description = "Billing"
                }
            ]
        ]
    ]


examplesForText : { inverted : Bool } -> List (Html msg)
examplesForText options =
    [ example
        { title = "Text"
        , description = "A text is always used inline and uses one color from the FUI color palette"
        }
        [ segment options
            []
            [ text "This is "
            , redText options "red"
            , text " inline text and this is "
            , blueText options "blue"
            , text " inline text and this is "
            , purpleText options "purple"
            , text " inline text"
            ]
        , segment options
            []
            [ text "This is "
            , infoText "info"
            , text " inline text and this is "
            , successText "success"
            , text " inline text and this is "
            , warningText "warning"
            , text " inline text and this is "
            , errorText "error"
            , text " inline text"
            ]
        ]
    , example
        { title = "Size"
        , description = "Text can vary in the same sizes as icons"
        }
        [ segment options
            []
            [ p [] [ text "Starting with ", miniText "mini", text " text" ]
            , p [] [ text "which turns into ", tinyText "tiny", text " text" ]
            , p [] [ text "changing to ", smallText "small", text " text until it is" ]
            , p [] [ text "the default ", mediumText "medium", text " text" ]
            , p [] [ text "and could be ", largeText "large", text " text" ]
            , p [] [ text "to turn into ", bigText "big", text " text" ]
            , p [] [ text "then growing to ", hugeText "huge", text " text" ]
            , p [] [ text "to finally become ", massiveText "massive", text " text" ]
            ]
        ]
    ]
