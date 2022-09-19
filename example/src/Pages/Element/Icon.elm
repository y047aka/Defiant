module Pages.Element.Icon exposing (Model, Msg, page)

import Config
import Css exposing (..)
import Html.Styled as Html exposing (Attribute, Html, text)
import Html.Styled.Attributes exposing (css)
import Page
import Request exposing (Request)
import Shared
import UI.Grid as Grid exposing (fiveColumnsGrid)
import UI.Icon exposing (icon)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \_ ->
                { title = "Icon"
                , body = view shared
                }
        }



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
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
    [ configAndPreview UpdateConfig { theme = theme } <|
        { title = "Accessibility"
        , preview =
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
        , configSections = []
        }
    ]
