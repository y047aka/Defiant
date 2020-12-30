module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (em, margin2, padding2, position, relative, zero)
import Html
import Html.Styled exposing (Attribute, Html, div, main_, p, span, text, toUnstyled)
import Html.Styled.Attributes exposing (class, css)
import Html.Styled.Events exposing (onClick)
import UI exposing (..)
import UI.Button exposing (..)
import UI.Header exposing (..)
import UI.Label exposing (..)
import UI.Menu exposing (..)
import UI.Modifier exposing (Palette(..))
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
        main_ []
            [ sectionForButtons model
            , sectionForHeaders
            , sectionForLabels
            , sectionForTexts
            , sectionForMenus
            , sectionForTables
            ]


sectionForButtons : Model -> Html Msg
sectionForButtons model =
    section []
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


sectionForHeaders : Html Msg
sectionForHeaders =
    section []
        [ example []
            [ header [] [ text "Content Headers" ]
            , p [] [ text "Headers may be oriented to give the importance of a section in the context of the content that surrounds it" ]
            , massiveHeader [] [ text "Massive Header" ]
            , wireframeParagraph
            , hugeHeader [] [ text "Huge Header" ]
            , wireframeParagraph
            , bigHeader [] [ text "Big Header" ]
            , wireframeParagraph
            , largeHeader [] [ text "Large Header" ]
            , wireframeParagraph
            , mediumHeader [] [ text "Medium Header" ]
            , wireframeParagraph
            , smallHeader [] [ text "Small Header" ]
            , wireframeParagraph
            , tinyHeader [] [ text "Tiny Header" ]
            , wireframeParagraph
            , miniHeader [] [ text "Mini Header" ]
            , wireframeParagraph
            ]
        ]


sectionForLabels : Html Msg
sectionForLabels =
    section []
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


sectionForTexts : Html Msg
sectionForTexts =
    section []
        [ example []
            [ header [] [ text "Text" ]
            , p [] [ text "A text is always used inline and uses one color from the FUI color palette" ]
            , div []
                [ text "This is "
                , redText "red"
                , text " inline text and this is "
                , blueText "blue"
                , text " inline text and this is "
                , purpleText "purple"
                , text " inline text"
                ]
            , div []
                [ text "This is "
                , span [ class "inverted red" ] [ text "red" ]
                , text " inline text and this is "
                , span [ class "inverted blue" ] [ text "blue" ]
                , text " inline text and this is "
                , span [ class "inverted purple" ] [ text "purple" ]
                , text " inline text"
                ]
            , div []
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
            , div []
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
            , p [] [ text "Starting with ", miniText "mini", text " text" ]
            , p [] [ text "which turns into ", tinyText "tiny", text " text" ]
            , p [] [ text "changing to ", smallText "small", text " text until it is" ]
            , p [] [ text "the default ", mediumText "medium", text " text" ]
            , p [] [ text "and could be ", largeText "large", text " text" ]
            , p [] [ text "to turn into ", bigText "big", text " text" ]
            , p [] [ text "then growing to ", hugeText "huge", text " text" ]
            , p [] [ text "to finally become ", massiveText "massive", text " text" ]
            ]
        ]


sectionForMenus : Html Msg
sectionForMenus =
    section []
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
            , verticalMenu []
                [ verticalMenuActiveItem []
                    [ text "Inbox"
                    , verticalMenuActiveItemLabel [] [ text "1" ]
                    ]
                , verticalMenuItem [] [] <|
                    [ text "Spam"
                    , verticalMenuActiveItemLabel [] [ text "51" ]
                    ]
                , verticalMenuItem [] [] <|
                    [ text "Updates"
                    , verticalMenuActiveItemLabel [] [ text "1" ]
                    ]
                , verticalMenuItem [] [] [ text "Search mail..." ]
                ]
            ]
        ]


sectionForTables : Html Msg
sectionForTables =
    section []
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


example : List (Attribute Msg) -> List (Html Msg) -> Html Msg
example attributes =
    div <|
        css
            [ -- .example {
              margin2 (em 1) zero
            , padding2 (em 1) zero
            , position relative
            ]
            :: attributes
