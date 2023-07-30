module Playground exposing
    ( playground
    , string, bool, radio, select, counter
    , boolAndString
    )

{-|

@docs playground
@docs string, bool, radio, select, counter
@docs boolAndString

-}

import Css exposing (..)
import Css.Global exposing (children, selector)
import Css.Palette as Palette exposing (darkPalette, palette, setBackground, setColor)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, div, input, p, text)
import Html.Styled.Attributes as Attributes exposing (css, for, id, name, placeholder, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Types exposing (FormState(..))
import UI.Button exposing (button, labeledButton)
import UI.Checkbox as Checkbox
import UI.Input as Input
import UI.Label exposing (basicLabel)
import UI.Layout.Box as Box exposing (box, setPadding)
import UI.Layout.Sidebar exposing (withSidebar)
import UI.Layout.Stack as Stack exposing (stack)


type alias ConfigSection msg =
    { label : String
    , configs : List (Html msg)
    }


playground :
    { theme : Theme
    , inverted : Bool
    , preview : List (Html msg)
    , configSections : List (ConfigSection msg)
    }
    -> Html msg
playground { theme, inverted, preview, configSections } =
    let
        palette_ =
            Palette.init
                |> (\p ->
                        { p
                            | background = Just (hex "FFF")
                            , color = Just (hex "000")
                            , border = Just (hex "DDD")
                        }
                   )
    in
    box (Box.defaultProps |> Box.setPadding 0 |> Box.setPalette palette_)
        [ css [ borderRadius (px 15), overflow hidden ] ]
        [ withSidebar
            { side = "right"
            , sideWith = 25
            , contentMin = 50
            , space = 0
            , noStretch = False
            }
            [ css
                [ children
                    [ selector ":nth-child(n+2)"
                        [ borderLeft3 (px 1) solid (hex "#DDD") ]
                    ]
                ]
            ]
            [ previewPanel { inverted = inverted } preview
            , configPanel configSections
            ]
        ]


previewPanel : { inverted : Bool } -> List (Html msg) -> Html msg
previewPanel { inverted } previewSections =
    let
        theme =
            if inverted then
                Dark

            else
                Light
    in
    div
        [ css
            [ displayFlex
            , flexDirection column
            , justifyContent center
            , padding (em 2)
            , palette (Palette.init |> setBackground (hex "#FFFFFF"))
            , darkPalette theme
                (Palette.init
                    |> setBackground (hex "#1B1C1D")
                    |> setColor (rgba 255 255 255 0.9)
                )
            ]
        ]
        previewSections


configPanel : List (ConfigSection msg) -> Html msg
configPanel configSections =
    box (Box.defaultProps |> Box.setBorderWidth 0 |> Box.setPadding 0)
        [ css
            [ children
                [ selector ":nth-child(n+2)"
                    [ borderTop3 (px 1) solid (hex "#DDD") ]
                ]
            ]
        ]
        (List.map
            (\configSection ->
                box (Box.defaultProps |> Box.setBorderWidth 0 |> setPadding 1)
                    []
                    [ stack Stack.defaultProps
                        []
                        (div
                            [ css
                                [ fontWeight bold
                                , empty [ display none ]
                                ]
                            ]
                            [ text configSection.label ]
                            :: configSection.configs
                        )
                    ]
            )
            configSections
        )


field : { label : String, note : String } -> Html msg -> Html msg
field { label, note } child =
    stack (Stack.defaultProps |> Stack.setGap 0.5)
        []
        [ Html.label [ css [ empty [ display none ] ] ] [ text label ]
        , child
        , p
            [ css
                [ color (hex "#999")
                , empty [ display none ]
                ]
            ]
            [ text note ]
        ]


string :
    { label : String
    , value : String
    , onInput : String -> msg
    , placeholder : String
    , note : String
    }
    -> Html msg
string p =
    field { label = p.label, note = p.note } <|
        Input.input []
            [ input
                [ type_ "text"
                , value p.value
                , onInput p.onInput
                , placeholder p.placeholder
                ]
                []
            ]


bool :
    { label : String
    , id : String
    , bool : Bool
    , onClick : msg
    , note : String
    }
    -> Html msg
bool p =
    field { label = "", note = p.note } <|
        Checkbox.toggleCheckbox
            { id = p.id
            , label = p.label
            , checked = p.bool
            , disabled = False
            , onClick = p.onClick
            }


select :
    { label : String
    , value : option
    , options : List option
    , fromString : String -> Maybe option
    , toString : option -> String
    , onChange : option -> msg
    , note : String
    }
    -> Html msg
select p =
    field { label = p.label, note = p.note } <|
        Html.select [ onInput (p.fromString >> Maybe.withDefault p.value >> p.onChange) ]
            (List.map (\option -> Html.option [ value (p.toString option), selected (p.value == option) ] [ text (p.toString option) ])
                p.options
            )


radio :
    { label : String
    , name : String
    , value : option
    , options : List option
    , fromString : String -> Maybe option
    , toString : option -> String
    , onChange : option -> msg
    , note : String
    }
    -> Html msg
radio p =
    field { label = p.label, note = p.note } <|
        div [] <|
            List.map
                (\option ->
                    let
                        prefixedId =
                            p.name ++ "_" ++ p.toString option
                    in
                    div []
                        [ input
                            [ id prefixedId
                            , type_ "radio"
                            , name p.name
                            , value (p.toString option)
                            , Attributes.checked (p.value == option)
                            , onInput (p.fromString >> Maybe.withDefault p.value >> p.onChange)
                            ]
                            []
                        , Html.label [ for prefixedId ] [ text (p.toString option) ]
                        ]
                )
                p.options


counter :
    { label : String
    , value : Float
    , toString : Float -> String
    , onClickPlus : msg
    , onClickMinus : msg
    , note : String
    }
    -> Html msg
counter p =
    field { label = p.label, note = p.note } <|
        labeledButton []
            [ button [ onClick p.onClickMinus ] [ text "-" ]
            , basicLabel [] [ text (p.toString p.value) ]
            , button [ onClick p.onClickPlus ] [ text "+" ]
            ]


boolAndString :
    { label : String
    , id : String
    , data : { visible : Bool, value : String }
    , onUpdate : { visible : Bool, value : String } -> msg
    , placeholder : String
    , note : String
    }
    -> Html msg
boolAndString { label, id, data, onUpdate, placeholder, note } =
    stack (Stack.defaultProps |> Stack.setGap 0.5)
        []
        [ bool
            { label = label
            , id = id
            , bool = data.visible
            , onClick = onUpdate { data | visible = not data.visible }
            , note = ""
            }
        , string
            { label = ""
            , value = data.value
            , onInput = \string_ -> onUpdate { data | value = string_ }
            , placeholder = placeholder
            , note = note
            }
        ]
