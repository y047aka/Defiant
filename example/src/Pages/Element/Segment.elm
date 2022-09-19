module Pages.Element.Segment exposing (Model, Msg, page)

import Config
import Data.Theme exposing (Theme(..))
import Effect exposing (Effect)
import Html.Styled as Html exposing (Html, p, text)
import Page
import Request exposing (Request)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Segment exposing (Padding(..), basicSegment, paddingFromString, paddingToString, segment, segmentWithProps, verticalSegment)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.advanced
        { init = init
        , update = update
        , view =
            \model ->
                { title = "Segment"
                , body = view shared model
                }
        , subscriptions = \_ -> Sub.none
        }



-- INIT


type alias Model =
    { vertical : Bool
    , disabled : Bool
    , inverted : Bool
    , padding : Padding
    }


init : ( Model, Effect Msg )
init =
    ( { vertical = True
      , disabled = False
      , inverted = False
      , padding = Default
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = UpdateConfig (Config.Msg Model)


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        UpdateConfig configMsg ->
            let
                newModel =
                    Config.update configMsg model

                effect =
                    case ( newModel.inverted == model.inverted, newModel.inverted ) of
                        ( True, _ ) ->
                            Effect.none

                        ( False, True ) ->
                            Effect.fromShared (Shared.ChangeTheme Dark)

                        ( False, False ) ->
                            Effect.fromShared (Shared.ChangeTheme Light)
            in
            ( newModel, effect )


view : Shared.Model -> Model -> List (Html Msg)
view shared model =
    let
        options =
            { theme = shared.theme }
    in
    [ configAndPreview UpdateConfig { theme = shared.theme } <|
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
                    [ { label = ""
                      , config =
                            Config.bool
                                { id = "inverted"
                                , label = "Inverted"
                                , bool = shared.theme == Dark
                                , setter = \m -> { m | inverted = not m.inverted }
                                }
                      , note = "A segment can have its colors inverted for contrast"
                      }
                    , { label = "Padding"
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
    , configAndPreview UpdateConfig { theme = shared.theme } <|
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
    , configAndPreview UpdateConfig { theme = shared.theme } <|
        { title = "Basic"
        , preview =
            [ basicSegment options
                []
                [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
            ]
        , configSections = []
        }
    ]
