module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (..)
import Css.Global exposing (global)
import Css.ResetAndCustomize exposing (additionalReset, globalCustomize)
import Css.Reset exposing (normalize)
import Html
import Html.Styled exposing (Html, div, main_, p, span, text, toUnstyled)
import Html.Styled.Attributes as Attributes exposing (class, css, href, id, rel, target)
import Html.Styled.Events exposing (onClick)
import UI exposing (..)
import UI.Button exposing (..)
import UI.Example exposing (..)
import UI.Grid exposing (..)
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
        div []
            [ global (normalize ++ additionalReset ++ globalCustomize)
            , main_ []
                [ toc [] [ tableOfContents ]
                , article []
                    [ sectionForButtons model
                    , sectionForHeaders
                    , sectionForLabels
                    , sectionForTexts
                    , sectionForGrid
                    , sectionForMenus
                    , sectionForTables
                    ]
                ]
            ]


tableOfContents : Html msg
tableOfContents =
    verticalInvertedMenu []
        [ verticalInvertedMenuLinkItem [ href "#button" ] [ text "Button" ]
        , verticalInvertedMenuLinkItem [ href "#header" ] [ text "Header" ]
        , verticalInvertedMenuLinkItem [ href "#label" ] [ text "Label" ]
        , verticalInvertedMenuLinkItem [ href "#text" ] [ text "Text" ]
        , verticalInvertedMenuLinkItem [ href "#grid" ] [ text "Grid" ]
        , verticalInvertedMenuLinkItem [ href "#menu" ] [ text "Menu" ]
        , verticalInvertedMenuLinkItem [ href "#table" ] [ text "Table" ]
        ]


sectionForButtons : Model -> Html Msg
sectionForButtons model =
    section [ id "button" ]
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
    section [ id "header" ]
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
    section [ id "label" ]
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
    section [ id "text" ]
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


sectionForGrid : Html Msg
sectionForGrid =
    section [ id "grid" ]
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
    section [ id "menu" ]
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
            , verticalMenu [] [] <|
                [ verticalMenuActiveItem []
                    [ text "Inbox"
                    , verticalMenuActiveItemLabel [] [ text "1" ]
                    ]
                , verticalMenuItem div [] [] <|
                    [ text "Spam"
                    , verticalMenuActiveItemLabel [] [ text "51" ]
                    ]
                , verticalMenuItem div [] [] <|
                    [ text "Updates"
                    , verticalMenuActiveItemLabel [] [ text "1" ]
                    ]
                , verticalMenuItem div [] [] [ text "Search mail..." ]
                ]
            ]
        , example []
            [ header [] [ text "Link Item" ]
            , p [] [ text "A menu may contain a link item, or an item formatted as if it is a link." ]
            , verticalMenu [] [] <|
                [ verticalMenuLinkItem [] [ href "http://www.google.com", Attributes.target "_blank", rel "noopener" ] [ text "Visit Google" ]
                , verticalMenuLinkItem [] [] [ text "Javascript Link" ]
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


sectionForTables : Html Msg
sectionForTables =
    section [ id "table" ]
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
