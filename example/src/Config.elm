module Config exposing (string, bool, radio, select, counter)

{-|

@docs string, bool, radio, select, counter

-}

import Css exposing (color, column, displayFlex, flexDirection, hex, property)
import Html.Styled as Html exposing (Html, div, input, p, text)
import Html.Styled.Attributes exposing (checked, css, for, id, name, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Types exposing (FormState(..))
import UI.Button exposing (button, labeledButton)
import UI.Checkbox as Checkbox
import UI.Input as Input
import UI.Label exposing (basicLabel)


field : { label : String, note : String } -> Html msg -> Html msg
field { label, note } child =
    div [ css [ displayFlex, flexDirection column, property "gap" "5px" ] ]
        [ Html.label [] [ text label ]
        , child
        , p [ css [ color (hex "#999") ] ] [ text note ]
        ]


string :
    { label : String
    , value : String
    , onInput : String -> msg
    , note : String
    }
    -> Html msg
string p =
    field { label = p.label, note = p.note } <|
        Input.input []
            [ input [ type_ "text", value p.value, onInput p.onInput ] [] ]


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
                            , checked (p.value == option)
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
