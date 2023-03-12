module Pages.Element.Segment exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Effect
import Html.Styled as Html exposing (Html, p, text)
import Layouts exposing (Layout)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Segment exposing (Padding(..), basicSegment, paddingFromString, paddingToString, segment, segmentWithProps, verticalSegment)
import View.ConfigAndPreview exposing (configAndPreview)
import View.Playground exposing (playground)


layout : Model -> Layout
layout model =
    Layouts.Default { default = () }


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = \() -> ( init, Effect.none )
        , update = \msg model -> ( update msg model, Effect.none )
        , subscriptions = \_ -> Sub.none
        , view =
            \model ->
                { title = "Segment"
                , body = view shared model
                }
        }
        |> Page.withLayout layout



-- INIT


type alias Model =
    { vertical : Bool
    , disabled : Bool
    , inverted : Bool
    , padding : Padding
    }


init : Model
init =
    { vertical = True
    , disabled = False
    , inverted = False
    , padding = Default
    }



-- UPDATE


type Msg
    = UpdateConfig (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig updater ->
            updater model


view : Shared.Model -> Model -> List (Html Msg)
view shared model =
    let
        options =
            { theme = shared.theme }
    in
    [ playground
        { title = "Segment"
        , toMsg = UpdateConfig
        , theme = shared.theme
        , inverted = model.inverted
        , preview =
            [ segmentWithProps
                { padding = model.padding
                , border = True
                , shadow = True
                , theme =
                    if model.inverted then
                        Dark

                    else
                        shared.theme
                , disabled = model.disabled
                , additionalStyles = []
                }
                []
                [ wireframeShortParagraph ]
            ]
        , configSections =
            [ { label = "States"
              , configs =
                    [ Config.bool
                        { label = "Disabled"
                        , id = "disabled"
                        , bool = model.disabled
                        , onClick = (\c -> { c | disabled = not c.disabled }) |> UpdateConfig
                        , note = "A segment may show its content is disabled"
                        }
                    ]
              }
            , { label = "Variations"
              , configs =
                    [ Config.select
                        { label = "Padding"
                        , value = model.padding
                        , options = [ Default, Padded, VeryPadded ]
                        , fromString = paddingFromString
                        , toString = paddingToString
                        , onChange = (\padding c -> { c | padding = padding }) >> UpdateConfig
                        , note = "A segment can increase its padding"
                        }
                    ]
              }
            ]
        }
    , configAndPreview
        { title = "Vertical Segment"
        , theme = shared.theme
        , inverted = False
        , preview =
            if model.vertical then
                [ verticalSegment options [] [ wireframeShortParagraph ]
                , verticalSegment options [] [ wireframeShortParagraph ]
                , verticalSegment options [] [ wireframeShortParagraph ]
                ]

            else
                [ segment options [] [ wireframeShortParagraph ]
                , segment options [] [ wireframeShortParagraph ]
                , segment options [] [ wireframeShortParagraph ]
                ]
        , configSections =
            [ { label = ""
              , configs =
                    [ Config.bool
                        { label = "Vertical Segment"
                        , id = "vertical"
                        , bool = model.vertical
                        , onClick = (\c -> { c | vertical = not c.vertical }) |> UpdateConfig
                        , note = "A vertical segment formats content to be aligned as part of a vertical group"
                        }
                    ]
              }
            ]
        }
    , configAndPreview
        { title = "Basic"
        , theme = shared.theme
        , inverted = False
        , preview =
            [ basicSegment options
                []
                [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
            ]
        , configSections = []
        }
    ]
