module Pages.Elements.Segment exposing (Model, Msg, page)

import Config
import Html.Styled as Html exposing (Html, p, text)
import Page
import Request exposing (Request)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Segment exposing (Padding(..), basicSegment, invertedSegment, paddingFromString, paddingToString, segment, segmentWithProps, verticalSegment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.sandbox
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Segment"
                , body = view shared model
                }
        }



-- INIT


type alias Model =
    { vertical : Bool
    , disabled : Bool
    , padding : Padding
    }


init : Model
init =
    { vertical = True
    , disabled = False
    , padding = Default
    }



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateConfig configMsg ->
            Config.update configMsg model


view : Shared.Model -> Model -> List (Html Msg)
view shared model =
    let
        options =
            { theme = shared.theme }
    in
    [ configAndPreview UpdateConfig
        { title = "Segment"
        , preview =
            [ segmentWithProps
                { padding = model.padding
                , border = True
                , shadow = True
                , theme = shared.theme
                , disabled = model.disabled
                , additionalStyles = []
                }
                []
                [ wireframeShortParagraph ]
            ]
        , configSections =
            [ { label = "States"
              , configs =
                    [ { label = ""
                      , config =
                            Config.bool
                                { id = "disabled"
                                , label = "Disabled"
                                , bool = model.disabled
                                , setter = \m -> { m | disabled = not m.disabled }
                                }
                      , note = "A segment may show its content is disabled"
                      }
                    ]
              }
            , { label = "Variations"
              , configs =
                    [ { label = "Padding"
                      , config =
                            Config.select
                                { value = model.padding
                                , options = [ Default, Padded, VeryPadded ]
                                , fromString = paddingFromString
                                , toString = paddingToString
                                , setter = \padding m -> { m | padding = padding }
                                }
                      , note = "A segment can increase its padding"
                      }
                    ]
              }
            ]
        }
    , configAndPreview UpdateConfig
        { title = "Vertical Segment"
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
                    [ { label = "Vertical Segment"
                      , config =
                            Config.bool
                                { id = "vertical"
                                , label = "Vertical"
                                , bool = model.vertical
                                , setter = \m -> { m | vertical = not m.vertical }
                                }
                      , note = "A vertical segment formats content to be aligned as part of a vertical group"
                      }
                    ]
              }
            ]
        }
    , configAndPreview UpdateConfig
        { title = "Inverted"
        , preview =
            [ invertedSegment []
                [ p [] [ text "I'm here to tell you something, and you will probably read me first." ] ]
            ]
        , configSections = []
        }
    , configAndPreview UpdateConfig
        { title = "Basic"
        , preview =
            [ basicSegment options
                []
                [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
            ]
        , configSections = []
        }
    ]