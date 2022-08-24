module Pages.Elements.Segment exposing (Model, Msg, page)

import Html.Styled as Html exposing (Html, option, p, select, text)
import Html.Styled.Attributes exposing (selected, value)
import Html.Styled.Events exposing (onInput)
import Page
import Request exposing (Request)
import Shared
import UI.Checkbox exposing (checkbox)
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
    = ToggleVertical
    | ToggleDisabled
    | ChangePadding Padding


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleVertical ->
            { model | vertical = not model.vertical }

        ToggleDisabled ->
            { model | disabled = not model.disabled }

        ChangePadding padding ->
            { model | padding = padding }


view : Shared.Model -> Model -> List (Html Msg)
view shared model =
    let
        options =
            { theme = shared.theme }
    in
    [ configAndPreview
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
        , configs =
            [ { label = "States"
              , fields =
                    [ { label = ""
                      , description = "A segment may show its content is disabled"
                      , content =
                            checkbox
                                { id = "disabled"
                                , label = "Disabled"
                                , checked = model.disabled
                                , onClick = ToggleDisabled
                                }
                      }
                    ]
              }
            , { label = "Variations"
              , fields =
                    [ { label = "Padding"
                      , description = "A segment can increase its padding"
                      , content =
                            select [ onInput (paddingFromString >> Maybe.withDefault model.padding >> ChangePadding) ] <|
                                List.map (\padding -> option [ value (paddingToString padding), selected (model.padding == padding) ] [ text (paddingToString padding) ])
                                    [ Default, Padded, VeryPadded ]
                      }
                    ]
              }
            ]
        }
    , configAndPreview
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
        , configs =
            [ { label = ""
              , fields =
                    [ { label = "Vertical Segment"
                      , description = "A vertical segment formats content to be aligned as part of a vertical group"
                      , content =
                            checkbox
                                { id = "vertical"
                                , label = "Vertical"
                                , checked = model.vertical
                                , onClick = ToggleVertical
                                }
                      }
                    ]
              }
            ]
        }
    , configAndPreview
        { title = "Inverted"
        , preview =
            [ invertedSegment []
                [ p [] [ text "I'm here to tell you something, and you will probably read me first." ] ]
            ]
        , configs = []
        }
    , configAndPreview
        { title = "Basic"
        , preview =
            [ basicSegment options
                []
                [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
            ]
        , configs = []
        }
    ]
