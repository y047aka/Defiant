module Page.Element.Header exposing (Model, Msg, init, update, view)

import Control
import Html.Styled exposing (Html, text)
import Playground exposing (playground)
import Shared
import Types exposing (PresetColor(..), Size(..), sizeFromString, sizeToString)
import UI.Example exposing (wireframeShortParagraph)
import UI.Header as Header exposing (..)
import UI.Icon exposing (icon)



-- INIT


type alias Model =
    { header : String
    , subHeader : String
    , size : Size
    }


init : Model
init =
    { header = "Header"
    , subHeader = "Subheader"
    , size = Medium
    }



-- UPDATE


type Msg
    = UpdateProps (Model -> Model)


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateProps updater ->
            updater model



-- VIEW


view : Shared.Model -> Model -> List (Html Msg)
view { theme } model =
    let
        options =
            { theme = theme }
    in
    [ Header.header { theme = theme } [] [ text "Content Headers" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ headerWithProps { size = model.size, theme = theme }
                []
                [ text <| sizeToString model.size ++ " " ++ model.header
                , subHeader options [] [ text model.subHeader ]
                ]
            , wireframeShortParagraph
            ]
        , controlSections =
            [ { heading = "Content"
              , controls =
                    [ Control.field "Header"
                        (Control.string
                            { value = model.header
                            , onInput = (\string ps -> { ps | header = string }) >> UpdateProps
                            , placeholder = ""
                            }
                        )
                    , Control.field "Subheader"
                        (Control.string
                            { value = model.subHeader
                            , onInput = (\string ps -> { ps | subHeader = string }) >> UpdateProps
                            , placeholder = ""
                            }
                        )
                    ]
              }
            , { heading = "Variations"
              , controls =
                    [ Control.field "Size"
                        (Control.select
                            { value = sizeToString model.size
                            , options = List.map sizeToString [ Massive, Huge, Big, Large, Medium, Small, Tiny, Mini ]
                            , onChange =
                                (\size ps ->
                                    sizeFromString size
                                        |> Maybe.map (\s -> { ps | size = s })
                                        |> Maybe.withDefault ps
                                )
                                    >> UpdateProps
                            }
                        )
                    , Control.comment "Text can vary in the same sizes as icons"
                    ]
              }
            ]
        }
    , Header.header { theme = theme } [] [ text "Icon Headers" ]
    , playground
        { theme = theme
        , inverted = False
        , preview =
            [ iconHeader options
                []
                [ icon [] "fas fa-cogs"
                , iconHeaderContent []
                    [ text "Account Settings"
                    , subHeader options [] [ text "Manage your account settings and set e-mail preferences." ]
                    ]
                ]
            ]
        , controlSections = []
        }
    ]
