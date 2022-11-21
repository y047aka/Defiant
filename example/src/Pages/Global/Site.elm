module Pages.Global.Site exposing (Model, Msg, page)

import Config
import Effect
import Html.Styled as Html exposing (Html, h1, h2, h3, h4, h5, p, text)
import Layouts.Default exposing (layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                { title = "Site"
                , body = view shared
                }
                    |> layout shared route
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
    [ configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Headers"
        , preview =
            [ h1 [] [ text "First Header" ]
            , h2 [] [ text "Second Header" ]
            , h3 [] [ text "Third Header" ]
            , h4 [] [ text "Fourth Header" ]
            , h5 [] [ text "Fifth Header" ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Page Font"
        , preview =
            [ p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
            , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
            , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Text Selection"
        , preview = [ p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ] ]
        , configSections = []
        }
    , configAndPreview UpdateConfig { theme = theme, inverted = False } <|
        { title = "Spacing"
        , preview =
            [ p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel tincidunt eros, nec venenatis ipsum. Nulla hendrerit urna ex, id sagittis mi scelerisque vitae. Vestibulum posuere rutrum interdum. Sed ut ullamcorper odio, non pharetra eros. Aenean sed lacus sed enim ornare vestibulum quis a felis. Sed cursus nunc sit amet mauris sodales tempus. Nullam mattis, dolor non posuere commodo, sapien ligula hendrerit orci, non placerat erat felis vel dui. Cras vulputate ligula ut ex tincidunt tincidunt. Maecenas eget gravida lorem. Nunc nec facilisis risus. Mauris congue elit sit amet elit varius mattis. Praesent convallis placerat magna, a bibendum nibh lacinia non." ]
            , p [] [ text "Fusce mollis sagittis elit ut maximus. Nullam blandit lacus sit amet luctus euismod. Duis luctus leo vel consectetur consequat. Phasellus ex ligula, pellentesque et neque vitae, elementum placerat eros. Proin eleifend odio nec velit lacinia suscipit. Morbi mollis ante nec dapibus gravida. In tincidunt augue eu elit porta, vel condimentum purus posuere. Maecenas tincidunt, erat sed elementum sagittis, tortor erat faucibus tellus, nec molestie mi purus sit amet tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris a tincidunt metus. Fusce congue metus aliquam ex auctor eleifend." ]
            , p [] [ text "Ut imperdiet dignissim feugiat. Phasellus tristique odio eu justo dapibus, nec rutrum ipsum luctus. Ut posuere nec tortor eu ullamcorper. Etiam pellentesque tincidunt tortor, non sagittis nibh pretium sit amet. Sed neque dolor, blandit eu ornare vel, lacinia porttitor nisi. Vestibulum sit amet diam rhoncus, consectetur enim sit amet, interdum mauris. Praesent feugiat finibus quam, porttitor varius est egestas id." ]
            ]
        , configSections = []
        }
    ]
