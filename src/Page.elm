module Page exposing
    ( Model, init, Msg, update
    , examplesForSite
    , examplesForButton, examplesForContainer, examplesForDivider, examplesForHeader, examplesForIcon, examplesForImage, examplesForInput, examplesForLabel, examplesForLoader, examplesForPlaceholder, examplesForRail, examplesForSegment, examplesForStep, examplesForCircleStep, examplesForText
    , examplesForBreadcrumb, examplesForForm, examplesForGrid, examplesForMenu, examplesForMessage, examplesForTable
    , examplesForCard, examplesForItem
    , examplesForAccordion, examplesForCheckbox, examplesForDimmer, examplesForModal, examplesForProgress, examplesForTab
    , examplesForSortableTable, examplesForHolyGrail
    )

{-|

@docs Model, init, Msg, update
@docs examplesForSite
@docs examplesForButton, examplesForContainer, examplesForDivider, examplesForHeader, examplesForIcon, examplesForImage, examplesForInput, examplesForLabel, examplesForLoader, examplesForPlaceholder, examplesForRail, examplesForSegment, examplesForStep, examplesForCircleStep, examplesForText
@docs examplesForBreadcrumb, examplesForForm, examplesForGrid, examplesForMenu, examplesForMessage, examplesForTable
@docs examplesForCard, examplesForItem
@docs examplesForAccordion, examplesForCheckbox, examplesForDimmer, examplesForModal, examplesForProgress, examplesForTab
@docs examplesForSortableTable, examplesForHolyGrail

-}

import Browser.Navigation exposing (Key)
import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html, a, div, h1, h2, h3, h4, h5, input, p, span, strong, text)
import Html.Styled.Attributes as Attributes exposing (css, for, href, id, name, placeholder, rel, rows, src, tabindex, type_)
import Html.Styled.Events exposing (onClick, onInput)
import Random
import UI.Accordion exposing (accordion_Checkbox, accordion_Radio, accordion_SummaryDetails, accordion_TargetUrl)
import UI.Breadcrumb exposing (breadcrumb)
import UI.Button exposing (..)
import UI.Card as Card exposing (card, cards, extraContent)
import UI.Checkbox as Checkbox exposing (checkbox)
import UI.CircleStep as CircleStep
import UI.Container exposing (container, textContainer)
import UI.Dimmer as Dimmer exposing (dimmer, pageDimmer)
import UI.Divider exposing (divider)
import UI.Example exposing (..)
import UI.Form as Form exposing (State(..), checkboxLabel, field, fields, form, textarea, threeFields, twoFields)
import UI.Grid as Grid exposing (eightWideColumn, fiveColumnsGrid, fourWideColumn, grid, sixWideColumn, threeColumnsGrid, twoWideColumn)
import UI.Header as Header exposing (..)
import UI.HolyGrail exposing (holyGrail)
import UI.Icon exposing (icon)
import UI.Image exposing (image, smallImage, tinyImage)
import UI.Input as Input
import UI.Item as Item exposing (..)
import UI.Label as Label exposing (..)
import UI.Loader exposing (loader, textLoader)
import UI.Menu as Menu exposing (..)
import UI.Message exposing (message)
import UI.Modal as Modal exposing (..)
import UI.Placeholder as Placeholder exposing (line)
import UI.Progress as Progress
import UI.Rail exposing (leftRail, rightRail)
import UI.Segment exposing (..)
import UI.SortableTable as Table
import UI.Step exposing (activeStep, completedStep, disabledStep, step, steps)
import UI.Tab exposing (State(..), tab)
import UI.Table exposing (..)
import UI.Text exposing (..)


type alias Model =
    { key : Key
    , darkMode : Bool
    , count : Int
    , toggledItems : List String
    , progress : Float

    -- for SortableTable
    , people : List Person
    , tableState : Table.State
    , query : String
    }


init : () -> Key -> ( Model, Cmd Msg )
init _ key =
    ( { key = key
      , darkMode = False
      , count = 0
      , toggledItems = []
      , progress = 0

      -- for SortableTable
      , people = []
      , tableState = Table.initialSort "Year"
      , query = ""
      }
    , Random.generate NewProgress (Random.int 10 50)
    )


type Msg
    = Increment
    | Decrement
    | Toggle String
    | ProgressPlus
    | ProgressMinus
    | NewProgress Int
      -- for SortableTable
    | SetQuery String
    | SetTableState Table.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

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

        SetQuery newQuery ->
            ( { model | query = newQuery }, Cmd.none )

        SetTableState newState ->
            ( { model | tableState = newState }, Cmd.none )


examplesForSite : List (Html msg)
examplesForSite =
    [ example
        { title = "Headers"
        , description = "A site can define styles for headers"
        }
        [ h1 [] [ text "First Header" ]
        , h2 [] [ text "Second Header" ]
        , h3 [] [ text "Third Header" ]
        , h4 [] [ text "Fourth Header" ]
        , h5 [] [ text "Fifth Header" ]
        ]
    , example
        { title = "Page Font"
        , description = "A site can specify styles for page content."
        }
        [ p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
        , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
        , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
        ]
    , example
        { title = "Text Selection"
        , description = "A site can specify text selection styles."
        }
        [ p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ] ]
    , example
        { title = "Spacing"
        , description = "A site can define default spacing for headers and paragraphs"
        }
        [ p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
        , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
        , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
        ]
    ]


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


examplesForBreadcrumb : { inverted : Bool } -> List (Html msg)
examplesForBreadcrumb { inverted } =
    [ example
        { title = "Breadcrumb"
        , description = "A standard breadcrumb"
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ breadcrumb { divider = icon [] "fas fa-angle-right", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Store", url = "/" }
            , { label = "T-Shirt", url = "" }
            ]
        ]
    , example
        { title = "Divider"
        , description = "A breadcrumb can contain a divider to show the relationship between sections, this can be formatted as an icon or text."
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Home", url = "/" }
            , { label = "Registration", url = "/" }
            , { label = "Personal Information", url = "" }
            ]
        ]
    , example
        { title = "Active"
        , description = "A section can be active"
        }
        [ breadcrumb { divider = text "/", inverted = inverted }
            [ { label = "Products", url = "/" }
            , { label = "Paper Towels", url = "" }
            ]
        ]
    , example
        { title = "Inverted"
        , description = "A breadcrumb can be inverted"
        }
        [ segment { inverted = True }
            []
            [ breadcrumb { divider = text "/", inverted = True }
                [ { label = "Home", url = "/" }
                , { label = "Registration", url = "/" }
                , { label = "Personal Information", url = "" }
                ]
            ]
        ]
    ]


examplesForForm : List (Html msg)
examplesForForm =
    let
        fieldsWithState options =
            [ twoFields []
                [ field
                    { type_ = "text"
                    , label = "First Name"
                    , state = options.state
                    }
                    []
                    [ Form.input { state = options.state } [ type_ "text", placeholder "First Name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Last Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                ]
            , field
                { type_ = "checkbox"
                , label = ""
                , state = options.state
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id options.id, type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = options.state } [ for options.id ] [ text "I agree to the Terms and Conditions" ]
                    ]
                ]
            ]
    in
    [ example
        { title = "Form"
        , description = "A form"
        }
        [ form []
            [ field
                { type_ = "text"
                , label = "First Name"
                , state = Default
                }
                []
                [ Form.input { state = Default } [ type_ "text", name "first-name", placeholder "First Name" ] [] ]
            , field
                { type_ = "text"
                , label = "Last Name"
                , state = Default
                }
                []
                [ Form.input { state = Default } [ type_ "text", name "last-name", placeholder "Last Name" ] [] ]
            , field
                { type_ = "checkbox"
                , label = ""
                , state = Default
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id "checkbox_example_1", type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = Default } [ for "checkbox_example_1" ] [ text "I agree to the Terms and Conditions" ]
                    ]
                ]
            , button [ type_ "submit" ] [ text "Submit" ]
            ]
        ]
    , example
        { title = "Field"
        , description = "A field is a form element containing a label and an input"
        }
        [ form []
            [ field
                { type_ = "text"
                , label = "User Input"
                , state = Default
                }
                []
                [ Form.input { state = Default } [ type_ "text" ] [] ]
            ]
        ]
    , example
        { title = "Fields"
        , description = "A set of fields can appear grouped together"
        }
        [ form []
            [ fields []
                [ field
                    { type_ = "text"
                    , label = "First Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "First Name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Middle name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Middle name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Last Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                ]
            ]
        ]
    , example
        { title = "", description = "" }
        [ form []
            [ threeFields []
                [ field
                    { type_ = "text"
                    , label = "First Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "First Name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Middle name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Middle name" ] [] ]
                , field
                    { type_ = "text"
                    , label = "Last Name"
                    , state = Default
                    }
                    []
                    [ Form.input { state = Default } [ type_ "text", placeholder "Last Name" ] [] ]
                ]
            ]
        ]
    , example
        { title = "Text Area"
        , description = "A textarea can be used to allow for extended user input."
        }
        [ form []
            [ field
                { type_ = "textarea"
                , label = "Text"
                , state = Default
                }
                []
                [ textarea { state = Default } [] [] ]
            , field
                { type_ = "textarea"
                , label = "Short Text"
                , state = Default
                }
                []
                [ textarea { state = Default } [ rows 2 ] [] ]
            ]
        ]
    , example
        { title = "Checkbox"
        , description = "A form can contain a checkbox"
        }
        [ form []
            [ field
                { type_ = "checkbox"
                , label = ""
                , state = Default
                }
                []
                [ checkbox []
                    [ Checkbox.input [ id "checkbox_example_2", type_ "checkbox", tabindex 0 ] []
                    , checkboxLabel { state = Default } [ for "checkbox_example_2" ] [ text "Checkbox" ]
                    ]
                ]
            ]
        ]
    , example
        { title = "Field Error"
        , description = "Individual fields may display an error state"
        }
        [ form [] (fieldsWithState { id = "state_example_1", state = Error }) ]
    , example
        { title = "Field Warning"
        , description = "Individual fields may display a warning state"
        }
        [ form [] (fieldsWithState { id = "state_example_2", state = Warning }) ]
    , example
        { title = "Field Success"
        , description = "Individual fields may display a Success state"
        }
        [ form [] (fieldsWithState { id = "state_example_3", state = Success }) ]
    , example
        { title = "Field Info"
        , description = "Individual fields may display an informational state"
        }
        [ form [] (fieldsWithState { id = "state_example_4", state = Info }) ]
    ]


examplesForGrid : { inverted : Bool } -> List (Html msg)
examplesForGrid { inverted } =
    let
        additionalStyles =
            [ position relative
            , before
                [ position absolute
                , top (rem 1)
                , left (rem 1)
                , backgroundColor (hex "FAFAFA")
                , property "content" (qt "")
                , width (calc (pct 100) minus (rem 2))
                , height (calc (pct 100) minus (rem 2))
                , property "box-shadow" "0px 0px 0px 1px #DDDDDD inset"
                ]
            ]

        dummyContent =
            css
                [ after
                    [ property "content" (qt "")
                    , display block
                    , minHeight (px 50)
                    , backgroundColor (rgba 86 61 124 0.1)
                    , property "box-shadow" "0px 0px 0px 1px rgba(86, 61, 124, 0.2) inset"
                    ]
                ]
    in
    [ example
        { title = "Grids"
        , description = """A grid is a structure with a long history used to align negative space in designs.
Using a grid makes content appear to flow more naturally on your page."""
        }
        [ grid [ css additionalStyles ]
            [ fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            ]
        ]
    , example
        { title = "Columns"
        , description = """Grids divide horizontal space into indivisible units called "columns". All columns in a grid must specify their width as proportion of the total available row width.
All grid systems choose an arbitrary column count to allow per row. Fomantic's default theme uses 16 columns.
The example below shows four four wide columns will fit in the first row, 16 / 4 = 4, and three various sized columns in the second row. 2 + 8 + 6 = 16
The default column count, and other arbitrary features of grids can be changed by adjusting Fomantic UI's underlying theming variables."""
        }
        [ grid [ css additionalStyles ]
            [ fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , twoWideColumn [ dummyContent ] []
            , eightWideColumn [ dummyContent ] []
            , sixWideColumn [ dummyContent ] []
            ]
        ]
    , example
        { title = "Automatic Flow"
        , description = "Most grids do not need to specify rows. Content will automatically flow to the next row when all the grid columns are taken in the current row."
        }
        [ grid [ css additionalStyles ]
            [ fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            , fourWideColumn [ dummyContent ] []
            ]
        ]
    , example
        { title = "Column Content"
        , description = "Since columns use padding to create gutters, content stylings should not be applied directly to columns, but to elements inside of columns."
        }
        [ let
            imageSegment =
                segment { inverted = inverted }
                    []
                    [ smallImage [ src "./static/images/wireframe/image.png" ] [] ]
          in
          threeColumnsGrid []
            [ Grid.column [] [ imageSegment ]
            , Grid.column [] [ imageSegment ]
            , Grid.column [] [ imageSegment ]
            ]
        ]
    ]


examplesForMenu : Model -> List (Html msg)
examplesForMenu model =
    [ example
        { title = "Secondary Menu"
        , description = "A menu can adjust its appearance to de-emphasize its contents"
        }
        [ secondaryMenu { inverted = False } [] <|
            [ secondaryMenuActiveItem [] [ text "Home" ]
            , secondaryMenuItem [] [] [ text "Messages" ]
            , secondaryMenuItem [] [] [ text "Friends" ]
            , rightMenu []
                [ secondaryMenuItem [] [] <|
                    [ Input.input []
                        [ input [ type_ "text", placeholder "Search..." ] [] ]
                    ]
                , secondaryMenuItem [] [] [ text "Logout" ]
                ]
            ]
        ]
    , example
        { title = "Vertical Menu"
        , description = "A vertical menu displays elements vertically.."
        }
        [ verticalMenu { inverted = model.darkMode, additionalStyles = [] } [] <|
            [ verticalMenuActiveItem { inverted = model.darkMode } [] <|
                [ text "Inbox"
                , verticalMenuActiveItemLabel [] [ text "1" ]
                ]
            , verticalMenuItem { inverted = model.darkMode, additionalStyles = [] } [] <|
                [ text "Spam"
                , verticalMenuActiveItemLabel [] [ text "51" ]
                ]
            , verticalMenuItem { inverted = model.darkMode, additionalStyles = [] } [] <|
                [ text "Updates"
                , verticalMenuActiveItemLabel [] [ text "1" ]
                ]
            , verticalMenuItem { inverted = model.darkMode, additionalStyles = [] } [] [ text "Search mail..." ]
            ]
        ]
    , example
        { title = "Link Item"
        , description = "A menu may contain a link item, or an item formatted as if it is a link."
        }
        [ verticalMenu { inverted = model.darkMode, additionalStyles = [] } [] <|
            [ verticalMenuLinkItem { inverted = model.darkMode, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
            , verticalMenuLinkItem { inverted = model.darkMode, additionalStyles = [] } [] [ text "Javascript Link" ]
            ]
        ]
    , example
        { title = "Inverted"
        , description = "A menu may have its colors inverted to show greater contrast"
        }
        [ Menu.menu { inverted = True } [] <|
            [ linkItem { inverted = True } [] [ text "Home" ]
            , linkItem { inverted = True } [] [ text "Messages" ]
            , linkItem { inverted = True } [] [ text "Friends" ]
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ invertedSegment []
            [ secondaryMenu { inverted = False } [] <|
                [ linkItem { inverted = True } [] [ text "Home" ]
                , linkItem { inverted = True } [] [ text "Messages" ]
                , linkItem { inverted = True } [] [ text "Friends" ]
                ]
            ]
        ]
    ]


examplesForMessage : { inverted : Bool } -> List (Html msg)
examplesForMessage options =
    [ example
        { title = "Message"
        , description = "A basic message"
        }
        [ message []
            [ div []
                [ Header.header options [] [ text "Changes in Service" ]
                , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                ]
            ]
        ]
    , example
        { title = "Icon Message"
        , description = "A message can contain an icon."
        }
        [ message []
            [ icon [] "fas fa-inbox"
            , div []
                [ Header.header options [] [ text "Have you heard about our mailing list?" ]
                , p [] [ text "Get the best news in your e-mail every day." ]
                ]
            ]
        ]
    ]


examplesForTable : List (Html msg)
examplesForTable =
    [ example
        { title = "Table"
        , description = "A standard table"
        }
        [ celledTable []
            [ thead []
                [ tr [] <|
                    List.map (\item -> th [] [ text item ])
                        [ "Name", "Age", "Job" ]
                ]
            , tbody [] <|
                List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                    [ [ "James", "24", "Engineer" ]
                    , [ "Jill", "26", "Engineer" ]
                    , [ "Elyse", "24", "Designer" ]
                    ]
            ]
        ]
    , example
        { title = "Striped"
        , description = "A table can stripe alternate rows of content with a darker color to increase contrast"
        }
        [ stripedTable []
            [ thead []
                [ tr [] <|
                    List.map (\item -> th [] [ text item ])
                        [ "Name", "Date Joined", "E-mail", "Called" ]
                ]
            , tbody [] <|
                List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                    [ [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                    , [ "Jamie Harington", "January 11, 2014", "jamieharingonton@yahoo.com", "Yes" ]
                    , [ "Jill Lewis", "May 11, 2014", "jilsewris22@yahoo.com", "Yes" ]
                    , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                    , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                    , [ "Jamie Harington", "January 11, 2014", "jamieharingonton@yahoo.com", "Yes" ]
                    , [ "Jill Lewis", "May 11, 2014", "jilsewris22@yahoo.com", "Yes" ]
                    , [ "John Lilki", "September 14, 2013", "jhlilk22@yahoo.com", "No" ]
                    ]
            ]
        ]
    , example
        { title = "Basic"
        , description = "A table can reduce its complexity to increase readability."
        }
        [ basicTable []
            [ thead []
                [ tr [] <|
                    List.map (\item -> th [] [ text item ])
                        [ "Name", "Status", "Notes" ]
                ]
            , tbody [] <|
                List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                    [ [ "John", "Approved", "None" ]
                    , [ "Jamie", "Approved", "Requires call" ]
                    , [ "Jill", "Denied", "None" ]
                    ]
            ]
        ]
    , example
        { title = ""
        , description = ""
        }
        [ veryBasicTable []
            [ thead []
                [ tr [] <|
                    List.map (\item -> th [] [ text item ])
                        [ "Name", "Status", "Notes" ]
                ]
            , tbody [] <|
                List.map (\row -> tr [] <| List.map (\d -> td [] [ text d ]) row)
                    [ [ "John", "Approved", "None" ]
                    , [ "Jamie", "Approved", "Requires call" ]
                    , [ "Jill", "Denied", "None" ]
                    ]
            ]
        ]
    ]


examplesForCard : { inverted : Bool } -> List (Html msg)
examplesForCard options =
    [ example
        { title = "Card"
        , description = "A single card."
        }
        [ card options
            []
            [ image [ src "./static/images/avatar/kristy.png" ] []
            , Card.content options
                []
                { header = [ text "Kristy" ]
                , meta = [ text "Joined in 2013" ]
                , description = [ text "Kristy is an art director living in New York." ]
                }
            , extraContent options
                []
                [ icon [] "fas fa-user"
                , text "22 Friends"
                ]
            ]
        ]
    , example
        { title = "Cards"
        , description = "A group of cards."
        }
        [ cards [] <|
            List.map
                (\{ name, type_, description_, friends, imageUrl } ->
                    card options
                        []
                        [ image [ src imageUrl ] []
                        , Card.content options
                            []
                            { header = [ text name ]
                            , meta = [ text type_ ]
                            , description = [ text description_ ]
                            }
                        , extraContent options
                            []
                            [ icon [] "fas fa-user"
                            , text (String.fromInt friends ++ " Friends")
                            ]
                        ]
                )
                [ { name = "Matt Giampietro"
                  , type_ = "Friends"
                  , description_ = "Matthew is an interior designer living in New York."
                  , friends = 75
                  , imageUrl = "./static/images/avatar/matthew.png"
                  }
                , { name = "Molly"
                  , type_ = "Coworker"
                  , description_ = "Molly is a personal assistant living in Paris."
                  , friends = 35
                  , imageUrl = "./static/images/avatar/molly.png"
                  }
                , { name = "Elyse"
                  , type_ = "Coworker"
                  , description_ = "Elyse is a copywriter working in New York."
                  , friends = 151
                  , imageUrl = "./static/images/avatar/elyse.png"
                  }
                ]
        ]
    , example
        { title = "Header"
        , description = "A card can contain a header"
        }
        [ cards [] <|
            List.map
                (\person ->
                    card options
                        []
                        [ Card.content options
                            []
                            { header = [ text person.name ]
                            , meta = [ text person.type_ ]
                            , description = [ text person.description ]
                            }
                        ]
                )
                [ { name = "Elliot Fu"
                  , type_ = "Friend"
                  , description = "Elliot Fu is a film-maker from New York."
                  }
                , { name = "Veronika Ossi"
                  , type_ = "Friend"
                  , description = "Veronika Ossi is a set designer living in New York who enjoys kittens, music, and partying."
                  }
                , { name = "Jenny Hess"
                  , type_ = "Friend"
                  , description = "Jenny is a student studying Media Management at the New School"
                  }
                ]
        ]
    , example
        { title = "Metadata"
        , description = "A card can contain content metadata"
        }
        [ card options
            []
            [ Card.content options
                []
                { header = [ text "Cute Dog" ]
                , meta =
                    [ text "2 days ago "
                    , a [] [ text "Animals" ]
                    ]
                , description = [ wireframeParagraph ]
                }
            ]
        ]
    , example
        { title = "Description"
        , description = "A card can contain a description with one or more paragraphs"
        }
        [ card options
            []
            [ Card.content options
                []
                { header = [ text "Cute Dog" ]
                , meta = [ text "2 days ago " ]
                , description =
                    [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                    , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                    ]
                }
            ]
        ]
    , example
        { title = "Extra Content"
        , description = "A card can contain extra content meant to be formatted separately from the main content"
        }
        [ card options
            []
            [ Card.content options
                []
                { header = [ text "Cute Dog" ]
                , meta = [ text "2 days ago " ]
                , description =
                    [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                    , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                    ]
                }
            , extraContent options
                []
                [ icon [] "fas fa-check"
                , text "121 Votes"
                ]
            ]
        ]
    ]


examplesForItem : List (Html msg)
examplesForItem =
    [ example
        { title = "Metadata"
        , description = "An item can contain content metadata"
        }
        [ items [] <|
            List.repeat 2
                (Item.item []
                    [ image [ src "./static/images/wireframe/image.png" ] []
                    , Item.content []
                        { header = [ text "Header" ]
                        , meta = [ span [] [ text "Description" ] ]
                        , description = [ wireframeShortParagraph ]
                        , extra = [ text "Additional Details" ]
                        }
                    ]
                )
        ]
    , example
        { title = "Image"
        , description = "An item can contain an image"
        }
        [ dividedItems [] <|
            List.repeat 3
                (Item.item []
                    [ image [ src "./static/images/wireframe/image.png" ] [] ]
                )
        ]
    , example
        { title = "Content"
        , description = "An item can contain content"
        }
        [ dividedItems [] <|
            List.map
                (\{ content } ->
                    Item.item []
                        [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                        , middleAlignedContent [] [ text content ]
                        ]
                )
                [ { content = "Content A" }
                , { content = "Content B" }
                , { content = "Content C" }
                ]
        ]
    , example
        { title = "Header"
        , description = "An item can contain a header"
        }
        [ items [] <|
            List.map
                (\{ title } ->
                    Item.item []
                        [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                        , middleAlignedContent [] [ Item.header [] [ text title ] ]
                        ]
                )
                [ { title = "12 Years a Slave" }
                , { title = "My Neighbor Totoro" }
                , { title = "Watchmen" }
                ]
        ]
    , example
        { title = "Metadata"
        , description = "An item can contain content metadata"
        }
        [ items [] <|
            List.map
                (\plan ->
                    Item.item []
                        [ smallImage [ src "./static/images/wireframe/image.png" ] []
                        , Item.content []
                            { header = [ text plan.title ]
                            , meta =
                                [ span [] [ text plan.price ]
                                , span [] [ text plan.stay ]
                                ]
                            , description = [ wireframeShortParagraph ]
                            , extra = []
                            }
                        ]
                )
                [ { title = "Arrowhead Valley Camp"
                  , price = "$1200"
                  , stay = "1 Month"
                  }
                , { title = "Buck's Homebrew Stayaway"
                  , price = "$1000"
                  , stay = "2 Weeks"
                  }
                , { title = "Astrology Camp"
                  , price = "$1600"
                  , stay = "6 Weeks"
                  }
                ]
        ]
    , example
        { title = "Description"
        , description = "An item can contain a description with a single or multiple paragraphs"
        }
        [ items []
            [ Item.item []
                [ smallImage [ src "./static/images/wireframe/image.png" ] []
                , Item.content []
                    { header = [ text "Cute Dog" ]
                    , meta = []
                    , description =
                        [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                        , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                        ]
                    , extra = []
                    }
                ]
            ]
        ]
    , example
        { title = "Extra Content"
        , description = "An item can contain extra content meant to be formatted separately from the main content"
        }
        [ items []
            [ Item.item []
                [ Item.content []
                    { header = [ text "Cute Dog" ]
                    , meta = []
                    , description =
                        [ wireframeShortParagraph
                        , wireframeShortParagraph
                        ]
                    , extra =
                        [ icon [] "fas fa-check"
                        , text "121 Votes"
                        ]
                    }
                ]
            ]
        ]
    ]


examplesForAccordion : { inverted : Bool } -> List (Html Msg)
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


examplesForTab : List (Html Msg)
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


examplesForSortableTable : Model -> List (Html Msg)
examplesForSortableTable { people, tableState, query } =
    [ let
        config =
            Table.config
                { toId = .name
                , toMsg = SetTableState
                , columns =
                    [ Table.stringColumn "Name" .name
                    , Table.intColumn "Year" .year
                    , Table.stringColumn "City" .city
                    , Table.stringColumn "State" .state
                    ]
                }

        lowerQuery =
            String.toLower query

        acceptablePeople =
            List.filter (String.contains lowerQuery << String.toLower << .name) people
      in
      example
        { title = "Sortable Table"
        , description = ""
        }
        [ input [ placeholder "Search by Name", onInput SetQuery ] []
        , Table.view config tableState acceptablePeople
        ]
    ]


type alias Person =
    { name : String
    , year : Int
    , city : String
    , state : String
    }


presidents : List Person
presidents =
    [ Person "George Washington" 1732 "Westmoreland County" "Virginia"
    , Person "John Adams" 1735 "Braintree" "Massachusetts"
    , Person "Thomas Jefferson" 1743 "Shadwell" "Virginia"
    , Person "James Madison" 1751 "Port Conway" "Virginia"
    , Person "James Monroe" 1758 "Monroe Hall" "Virginia"
    , Person "Andrew Jackson" 1767 "Waxhaws Region" "South/North Carolina"
    , Person "John Quincy Adams" 1767 "Braintree" "Massachusetts"
    , Person "William Henry Harrison" 1773 "Charles City County" "Virginia"
    , Person "Martin Van Buren" 1782 "Kinderhook" "New York"
    , Person "Zachary Taylor" 1784 "Barboursville" "Virginia"
    , Person "John Tyler" 1790 "Charles City County" "Virginia"
    , Person "James Buchanan" 1791 "Cove Gap" "Pennsylvania"
    , Person "James K. Polk" 1795 "Pineville" "North Carolina"
    , Person "Millard Fillmore" 1800 "Summerhill" "New York"
    , Person "Franklin Pierce" 1804 "Hillsborough" "New Hampshire"
    , Person "Andrew Johnson" 1808 "Raleigh" "North Carolina"
    , Person "Abraham Lincoln" 1809 "Sinking spring" "Kentucky"
    , Person "Ulysses S. Grant" 1822 "Point Pleasant" "Ohio"
    , Person "Rutherford B. Hayes" 1822 "Delaware" "Ohio"
    , Person "Chester A. Arthur" 1829 "Fairfield" "Vermont"
    , Person "James A. Garfield" 1831 "Moreland Hills" "Ohio"
    , Person "Benjamin Harrison" 1833 "North Bend" "Ohio"
    , Person "Grover Cleveland" 1837 "Caldwell" "New Jersey"
    , Person "William McKinley" 1843 "Niles" "Ohio"
    , Person "Woodrow Wilson" 1856 "Staunton" "Virginia"
    , Person "William Howard Taft" 1857 "Cincinnati" "Ohio"
    , Person "Theodore Roosevelt" 1858 "New York City" "New York"
    , Person "Warren G. Harding" 1865 "Blooming Grove" "Ohio"
    , Person "Calvin Coolidge" 1872 "Plymouth" "Vermont"
    , Person "Herbert Hoover" 1874 "West Branch" "Iowa"
    , Person "Franklin D. Roosevelt" 1882 "Hyde Park" "New York"
    , Person "Harry S. Truman" 1884 "Lamar" "Missouri"
    , Person "Dwight D. Eisenhower" 1890 "Denison" "Texas"
    , Person "Lyndon B. Johnson" 1908 "Stonewall" "Texas"
    , Person "Ronald Reagan" 1911 "Tampico" "Illinois"
    , Person "Richard M. Nixon" 1913 "Yorba Linda" "California"
    , Person "Gerald R. Ford" 1913 "Omaha" "Nebraska"
    , Person "John F. Kennedy" 1917 "Brookline" "Massachusetts"
    , Person "George H. W. Bush" 1924 "Milton" "Massachusetts"
    , Person "Jimmy Carter" 1924 "Plains" "Georgia"
    , Person "George W. Bush" 1946 "New Haven" "Connecticut"
    , Person "Bill Clinton" 1946 "Hope" "Arkansas"
    , Person "Barack Obama" 1961 "Honolulu" "Hawaii"
    , Person "Donald Trump" 1946 "New York City" "New York"
    ]


examplesForHolyGrail : List (Html msg)
examplesForHolyGrail =
    [ example
        { title = "Holy grail"
        , description = "Holy grail layout"
        }
        [ holyGrail
            { header = [ text "header" ]
            , main = [ wireframeParagraph ]
            , aside_left = [ text "aside" ]
            , aside_right = [ text "aside" ]
            , footer = [ text "footer" ]
            }
        ]
    ]
