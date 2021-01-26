module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (..)
import Css.Global exposing (global)
import Css.Reset exposing (normalize)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Html
import Html.Styled exposing (Html, a, div, h1, h2, h3, h4, h5, main_, p, span, strong, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (class, css, href, id, rel, target)
import Html.Styled.Events exposing (onClick)
import UI.Button exposing (..)
import UI.Card as Card exposing (..)
import UI.Container exposing (..)
import UI.Example exposing (..)
import UI.Grid exposing (..)
import UI.Header exposing (..)
import UI.Label exposing (..)
import UI.Menu exposing (..)
import UI.Message exposing (..)
import UI.Modifier exposing (Palette(..))
import UI.Placeholder exposing (..)
import UI.Segment exposing (..)
import UI.Table exposing (..)
import UI.Text exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Html.Html Msg
view model =
    toUnstyled <|
        div []
            [ global (normalize ++ additionalReset ++ globalCustomize)
            , main_ []
                [ toc [] [ tableOfContents ]
                , article []
                    [ sectionForSite
                    , sectionForButtons model
                    , sectionForContainers
                    , sectionForHeaders
                    , sectionForLabels
                    , sectionForPlaceholders
                    , sectionForSegments
                    , sectionForTexts
                    , sectionForGrids
                    , sectionForMenus
                    , sectionForMessages
                    , sectionForTables
                    , sectionForCards
                    ]
                ]
            ]


tableOfContents : Html msg
tableOfContents =
    verticalInvertedMenu [] <|
        List.map (\{ url, label } -> verticalInvertedMenuLinkItem [ href url ] [ text label ])
            [ { url = "#site", label = "Site" }
            , { url = "#button", label = "Button" }
            , { url = "#container", label = "Container" }
            , { url = "#header", label = "Header" }
            , { url = "#label", label = "Label" }
            , { url = "#placeholder", label = "Placeholder" }
            , { url = "#segment", label = "Segment" }
            , { url = "#text", label = "Text" }
            , { url = "#grid", label = "Grid" }
            , { url = "#menu", label = "Menu" }
            , { url = "#message", label = "Message" }
            , { url = "#table", label = "Table" }
            , { url = "#card", label = "Card" }
            ]


sectionForSite : Html Msg
sectionForSite =
    exampleContainer [ id "site" ]
        [ example []
            [ header [] [ text "Headers" ]
            , p [] [ text "A site can define styles for headers" ]
            , h1 [] [ text "First Header" ]
            , h2 [] [ text "Second Header" ]
            , h3 [] [ text "Third Header" ]
            , h4 [] [ text "Fourth Header" ]
            , h5 [] [ text "Fifth Header" ]
            ]
        , example []
            [ header [] [ text "Page Font" ]
            , p [] [ text "A site can specify styles for page content." ]
            , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
            , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
            , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
            ]
        , example []
            [ header [] [ text "Text Selection" ]
            , p [] [ text "A site can specify text selection styles." ]
            , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
            ]
        , example []
            [ header [] [ text "Spacing" ]
            , p [] [ text "A site can define default spacing for headers and paragraphs" ]
            , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
            , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
            , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
            ]
        ]


sectionForButtons : Model -> Html Msg
sectionForButtons model =
    exampleContainer [ id "button" ]
        [ example []
            [ header [] [ text "Button" ]
            , p [] [ text "A standard button" ]
            , button [] [ text "Follow" ]
            ]
        , example []
            [ button [] [ text "Button" ]
            , button [] [ text "Focusable" ]
            ]
        , example []
            [ header [] [ text "Animated" ]
            , p [] [ text "A button can animate to show hidden content" ]
            ]
        , example []
            [ header [] [ text "Labeled" ]
            , p [] [ text "A button can appear alongside a label" ]
            , labeledButton []
                [ button [] [ text "Like" ]
                , basicLabel [] [ text "2048" ]
                ]
            , labeledButton []
                [ button [ onClick Decrement ] [ text "-" ]
                , basicLabel [] [ text (String.fromInt model) ]
                , button [ onClick Increment ] [ text "+" ]
                ]
            ]
        , example []
            [ header [] [ text "Basic" ]
            , p [] [ text "A basic button is less pronounced" ]
            , basicButton [] [ text "Add Friend" ]
            ]
        , example [] <|
            [ header [] [ text "Colored" ]
            , p [] [ text "A button can have different colors" ]
            ]
                ++ [ primaryButton [] [ text "Primary" ]
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


sectionForContainers : Html Msg
sectionForContainers =
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
    exampleContainer [ id "container" ]
        [ example []
            [ header [] [ text "Container" ]
            , p [] [ text "A standard container" ]
            , container [] [ content ]
            ]
        , example []
            [ header [] [ text "Text Container" ]
            , p [] [ text "A container can reduce its maximum width to more naturally accomodate a single column of text" ]
            , textContainer []
                [ h2 [] [ text "Header" ]
                , content
                , content
                ]
            ]
        ]


sectionForHeaders : Html Msg
sectionForHeaders =
    exampleContainer [ id "header" ]
        [ example []
            [ header [] [ text "Content Headers" ]
            , p [] [ text "Headers may be oriented to give the importance of a section in the context of the content that surrounds it" ]
            , massiveHeader [] [ text "Massive Header" ]
            , wireframeShortParagraph
            , hugeHeader [] [ text "Huge Header" ]
            , wireframeShortParagraph
            , bigHeader [] [ text "Big Header" ]
            , wireframeShortParagraph
            , largeHeader [] [ text "Large Header" ]
            , wireframeShortParagraph
            , mediumHeader [] [ text "Medium Header" ]
            , wireframeShortParagraph
            , smallHeader [] [ text "Small Header" ]
            , wireframeShortParagraph
            , tinyHeader [] [ text "Tiny Header" ]
            , wireframeShortParagraph
            , miniHeader [] [ text "Mini Header" ]
            , wireframeShortParagraph
            ]
        ]


sectionForLabels : Html Msg
sectionForLabels =
    exampleContainer [ id "label" ]
        [ example []
            [ header [] [ text "Label" ]
            , p [] [ text "A label" ]
            , label [] [ text "23" ]
            ]
        , example []
            [ header [] [ text "Basic" ]
            , p [] [ text "A label can reduce its complexity" ]
            , basicLabel [] [ text "Basic" ]
            ]
        , example [] <|
            [ header [] [ text "Colored" ]
            , p [] [ text "A label can have different colors" ]
            ]
                ++ [ primaryLabel [] [ text "Primary" ]
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


sectionForPlaceholders : Html msg
sectionForPlaceholders =
    exampleContainer [ id "placeholder" ]
        [ example []
            [ header [] [ text "Lines" ]
            , p [] [ text "A placeholder can contain have lines of text" ]
            , placeholder []
                [ line [] []
                , line [] []
                , line [] []
                , line [] []
                , line [] []
                ]
            ]
        ]


sectionForSegments : Html msg
sectionForSegments =
    exampleContainer [ id "segment" ]
        [ example []
            [ header [] [ text "Segment" ]
            , p [] [ text "A segment of content" ]
            , segment [] [ wireframeShortParagraph ]
            ]
        , example []
            [ header [] [ text "Vertical Segment" ]
            , p [] [ text "A vertical segment formats content to be aligned as part of a vertical group" ]
            , verticalSegment [] [ wireframeShortParagraph ]
            , verticalSegment [] [ wireframeShortParagraph ]
            , verticalSegment [] [ wireframeShortParagraph ]
            ]
        , example []
            [ header [] [ text "Disabled" ]
            , p [] [ text "A segment may show its content is disabled" ]
            , disabledSegment [] [ wireframeShortParagraph ]
            ]
        , example []
            [ header [] [ text "Padded" ]
            , p [] [ text "A segment can increase its padding" ]
            , paddedSegment [] [ wireframeShortParagraph ]
            ]
        , example []
            [ veryPaddedSegment [] [ wireframeShortParagraph ] ]
        , example []
            [ header [] [ text "Basic" ]
            , p [] [ text "A basic segment has no special formatting\n\n" ]
            , basicSegment []
                [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
            ]
        ]


sectionForTexts : Html Msg
sectionForTexts =
    exampleContainer [ id "text" ]
        [ example []
            [ header [] [ text "Text" ]
            , p [] [ text "A text is always used inline and uses one color from the FUI color palette" ]
            , segment []
                [ text "This is "
                , redText { inverted = False } "red"
                , text " inline text and this is "
                , blueText { inverted = False } "blue"
                , text " inline text and this is "
                , purpleText { inverted = False } "purple"
                , text " inline text"
                ]
            , invertedSegment []
                [ text "This is "
                , redText { inverted = True } "red"
                , text " inline text and this is "
                , blueText { inverted = True } "blue"
                , text " inline text and this is "
                , purpleText { inverted = True } "purple"
                , text " inline text"
                ]
            , segment []
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
            , invertedSegment []
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
        , example []
            [ header [] [ text "Size" ]
            , p [] [ text "Text can vary in the same sizes as icons" ]
            , segment []
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


sectionForGrids : Html Msg
sectionForGrids =
    exampleContainer [ id "grid" ]
        [ example []
            [ header [] [ text "Grids" ]
            , p [] [ text "A grid is a structure with a long history used to align negative space in designs." ]
            , p [] [ text "Using a grid makes content appear to flow more naturally on your page." ]
            , let
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
              grid
                [ css
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
                ]
                [ fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                , fourWideColumn [ dummyContent ] []
                ]
            ]
        ]


sectionForMenus : Html Msg
sectionForMenus =
    exampleContainer [ id "menu" ]
        [ example []
            [ header [] [ text "Secondary Menu" ]
            , p [] [ text "A menu can adjust its appearance to de-emphasize its contents" ]
            , secondaryMenu []
                [ secondaryMenuActiveItem [] [ text "Home" ]
                , secondaryMenuItem [] [] [ text "Messages" ]
                , secondaryMenuItem [] [] [ text "Friends" ]
                , rightMenu []
                    [ secondaryMenuItem [] [] [ text "Search..." ]
                    , secondaryMenuItem [] [] [ text "Logout" ]
                    ]
                ]
            ]
        , example []
            [ header [] [ text "Vertical Menu" ]
            , p [] [ text "A vertical menu displays elements vertically.." ]
            , verticalMenu { inverted = False, additionalStyles = [] } [] <|
                [ verticalMenuActiveItem []
                    [ text "Inbox"
                    , verticalMenuActiveItemLabel [] [ text "1" ]
                    ]
                , verticalMenuItem { inverted = False, additionalStyles = [] } [] <|
                    [ text "Spam"
                    , verticalMenuActiveItemLabel [] [ text "51" ]
                    ]
                , verticalMenuItem { inverted = False, additionalStyles = [] } [] <|
                    [ text "Updates"
                    , verticalMenuActiveItemLabel [] [ text "1" ]
                    ]
                , verticalMenuItem { inverted = False, additionalStyles = [] } [] [ text "Search mail..." ]
                ]
            ]
        , example []
            [ header [] [ text "Link Item" ]
            , p [] [ text "A menu may contain a link item, or an item formatted as if it is a link." ]
            , verticalMenu { inverted = False, additionalStyles = [] } [] <|
                [ verticalMenuLinkItem { inverted = False, additionalStyles = [] } [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
                , verticalMenuLinkItem { inverted = False, additionalStyles = [] } [] [ text "Javascript Link" ]
                ]
            ]
        , example []
            [ header [] [ text "Inverted" ]
            , p [] [ text "A menu may have its colors inverted to show greater contrast" ]
            , verticalInvertedMenu []
                [ verticalInvertedMenuItem [] [ text "Home" ]
                , verticalInvertedMenuItem [] [ text "Messages" ]
                , verticalInvertedMenuItem [] [ text "Friends" ]
                ]
            ]
        ]


sectionForMessages : Html msg
sectionForMessages =
    exampleContainer [ id "message" ]
        [ example []
            [ header [] [ text "Message" ]
            , p [] [ text "A basic message" ]
            , message []
                [ header [] [ text "Changes in Service" ]
                , p [] [ text "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes." ]
                ]
            ]
        ]


sectionForTables : Html Msg
sectionForTables =
    exampleContainer [ id "table" ]
        [ example []
            [ header [] [ text "Table" ]
            , p [] [ text "A standard table" ]
            , celledTable []
                [ thead []
                    [ tr []
                        [ th [] [ text "Name" ]
                        , th [] [ text "Age" ]
                        , th [] [ text "Job" ]
                        ]
                    ]
                , tbody []
                    [ tr []
                        [ td [] [ text "James" ]
                        , td [] [ text "24" ]
                        , td [] [ text "Engineer" ]
                        ]
                    , tr []
                        [ td [] [ text "Jill" ]
                        , td [] [ text "26" ]
                        , td [] [ text "Engineer" ]
                        ]
                    , tr []
                        [ td [] [ text "Elyse" ]
                        , td [] [ text "24" ]
                        , td [] [ text "Designer" ]
                        ]
                    ]
                ]
            ]
        , example []
            [ header [] [ text "Striped" ]
            , p [] [ text "A table can stripe alternate rows of content with a darker color to increase contrast" ]
            , stripedTable []
                [ thead []
                    [ tr []
                        [ th [] [ text "Name" ]
                        , th [] [ text "Date Joined" ]
                        , th [] [ text "E-mail" ]
                        , th [] [ text "Called" ]
                        ]
                    ]
                , tbody []
                    [ tr []
                        [ td [] [ text "John Lilki" ]
                        , td [] [ text "September 14, 2013" ]
                        , td [] [ text "jhlilk22@yahoo.com" ]
                        , td [] [ text "No" ]
                        ]
                    , tr []
                        [ td [] [ text "Jamie Harington" ]
                        , td [] [ text "January 11, 2014" ]
                        , td [] [ text "jamieharingonton@yahoo.com" ]
                        , td [] [ text "Yes" ]
                        ]
                    , tr []
                        [ td [] [ text "Jill Lewis" ]
                        , td [] [ text "May 11, 2014" ]
                        , td [] [ text "jilsewris22@yahoo.com" ]
                        , td [] [ text "Yes" ]
                        ]
                    , tr []
                        [ td [] [ text "John Lilki" ]
                        , td [] [ text "September 14, 2013" ]
                        , td [] [ text "jhlilk22@yahoo.com" ]
                        , td [] [ text "No" ]
                        ]
                    , tr []
                        [ td [] [ text "John Lilki" ]
                        , td [] [ text "September 14, 2013" ]
                        , td [] [ text "jhlilk22@yahoo.com" ]
                        , td [] [ text "No" ]
                        ]
                    , tr []
                        [ td [] [ text "Jamie Harington" ]
                        , td [] [ text "January 11, 2014" ]
                        , td [] [ text "jamieharingonton@yahoo.com" ]
                        , td [] [ text "Yes" ]
                        ]
                    , tr []
                        [ td [] [ text "Jill Lewis" ]
                        , td [] [ text "May 11, 2014" ]
                        , td [] [ text "jilsewris22@yahoo.com" ]
                        , td [] [ text "Yes" ]
                        ]
                    , tr []
                        [ td [] [ text "John Lilki" ]
                        , td [] [ text "September 14, 2013" ]
                        , td [] [ text "jhlilk22@yahoo.com" ]
                        , td [] [ text "No" ]
                        ]
                    ]
                ]
            ]
        ]


sectionForCards : Html msg
sectionForCards =
    exampleContainer [ id "card" ]
        [ example []
            [ header [] [ text "Header" ]
            , p [] [ text "A card can contain a header" ]
            , cards []
                [ card []
                    [ Card.content []
                        [ header [] [ text "Elliot Fu" ]
                        , meta [] [ text "Friend" ]
                        , description [] [ text "Elliot Fu is a film-maker from New York." ]
                        ]
                    ]
                , card []
                    [ Card.content []
                        [ header [] [ text "Veronika Ossi" ]
                        , meta [] [ text "Friend" ]
                        , description [] [ text "Veronika Ossi is a set designer living in New York who enjoys kittens, music, and partying." ]
                        ]
                    ]
                , card []
                    [ Card.content []
                        [ header [] [ text "Jenny Hess" ]
                        , meta [] [ text "Friend" ]
                        , description [] [ text "Jenny is a student studying Media Management at the New School" ]
                        ]
                    ]
                ]
            ]
        , example []
            [ header [] [ text "Metadata" ]
            , p [] [ text "A card can contain content metadata" ]
            , card []
                [ Card.content []
                    [ header [] [ text "Cute Dog" ]
                    , meta []
                        [ text "2 days ago "
                        , a [] [ text "Animals" ]
                        ]
                    , wireframeParagraph
                    ]
                ]
            ]
        , example []
            [ header [] [ text "Description" ]
            , p [] [ text "A card can contain a description with one or more paragraphs" ]
            , card []
                [ Card.content []
                    [ header [] [ text "Cute Dog" ]
                    , meta [] [ text "2 days ago " ]
                    , description []
                        [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                        , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                        ]
                    ]
                ]
            ]
        ]
