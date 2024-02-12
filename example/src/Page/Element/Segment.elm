module Page.Element.Segment exposing (Model, Msg, init, update, view)

import Control
import Data.Theme exposing (Theme(..))
import Html.Styled exposing (Html, p, text)
import Playground exposing (playground)
import Shared
import UI.Example exposing (wireframeShortParagraph)
import UI.Header as Header
import UI.Segment exposing (Padding(..), basicSegment, paddingFromString, paddingToString, segment, segmentWithProps, verticalSegment)



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
    [ Header.header options [] [ text "Segment" ]
    , playground
        { theme = shared.theme
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
        , controlSections =
            [ { heading = ""
              , controls =
                    [ Control.field "Inverted"
                        (Control.bool
                            { id = "inverted"
                            , value = model.inverted
                            , onClick = (\ps -> { ps | inverted = not ps.inverted }) |> UpdateConfig
                            }
                        )
                    ]
              }
            , { heading = "States"
              , controls =
                    [ Control.field "Disabled"
                        (Control.bool
                            { id = "disabled"
                            , value = model.disabled
                            , onClick = (\ps -> { ps | disabled = not ps.disabled }) |> UpdateConfig
                            }
                        )
                    , Control.comment "A segment may show its content is disabled"
                    ]
              }
            , { heading = "Variations"
              , controls =
                    [ Control.field "Padding"
                        (Control.select
                            { value = paddingToString model.padding
                            , options = List.map paddingToString [ Default, Padded, VeryPadded ]
                            , onChange =
                                (\padding ps ->
                                    paddingFromString padding
                                        |> Maybe.map (\p -> { ps | padding = p })
                                        |> Maybe.withDefault ps
                                )
                                    >> UpdateConfig
                            }
                        )
                    , Control.comment "A segment can increase its padding"
                    ]
              }
            ]
        }
    , Header.header options [] [ text "Vertical Segment" ]
    , playground
        { theme = shared.theme
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
        , controlSections =
            [ { heading = ""
              , controls =
                    [ Control.field "Vertical Segment"
                        (Control.bool
                            { id = "vertical_segment"
                            , value = model.vertical
                            , onClick = (\ps -> { ps | vertical = not ps.vertical }) |> UpdateConfig
                            }
                        )
                    , Control.comment "A vertical segment formats content to be aligned as part of a vertical group"
                    ]
              }
            ]
        }
    , Header.header options [] [ text "Basic" ]
    , playground
        { theme = shared.theme
        , inverted = False
        , preview =
            [ basicSegment options
                []
                [ p [] [ text "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo." ] ]
            ]
        , controlSections = []
        }
    ]
