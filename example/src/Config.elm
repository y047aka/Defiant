module Config exposing
    ( Msg(..), update
    , string, bool, radio, select, counter
    )

{-|

@docs Msg, update
@docs string, bool, radio, select, counter

-}

import Html.Styled as Html exposing (Html, div, input, label, text)
import Html.Styled.Attributes exposing (checked, for, id, name, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Types exposing (FormState(..))
import UI.Button exposing (button, labeledButton)
import UI.Checkbox as Checkbox
import UI.Input as Input
import UI.Label exposing (basicLabel)


type Msg model msg
    = Update (model -> model)
    | Custom msg


update : Msg model msg -> model -> model
update msg =
    case msg of
        Update f ->
            f

        Custom _ ->
            identity


string :
    { label : String
    , value : String
    , setter : String -> model -> model
    }
    -> Html (Msg model msg)
string c =
    Input.input []
        [ if c.label /= "" then
            div [] [ text c.label ]

          else
            text ""
        , input [ type_ "text", value c.value, onInput (c.setter >> Update) ] []
        ]


bool :
    { id : String
    , label : String
    , bool : Bool
    , setter : model -> model
    }
    -> Html (Msg model msg)
bool c =
    Checkbox.toggleCheckbox
        { id = c.id
        , label = c.label
        , checked = c.bool
        , disabled = False
        , onClick = Update c.setter
        }


select :
    { value : option
    , options : List option
    , fromString : String -> Maybe option
    , toString : option -> String
    , setter : option -> model -> model
    }
    -> Html (Msg model msg)
select c =
    Html.select [ onInput (c.fromString >> Maybe.withDefault c.value >> c.setter >> Update) ]
        (List.map (\option -> Html.option [ value (c.toString option), selected (c.value == option) ] [ text (c.toString option) ])
            c.options
        )


radio :
    { name : String
    , value : option
    , options : List option
    , fromString : String -> Maybe option
    , toString : option -> String
    , setter : option -> model -> model
    }
    -> Html (Msg model msg)
radio c =
    div [] <|
        List.map
            (\option ->
                let
                    prefixedId =
                        c.name ++ "_" ++ c.toString option
                in
                div []
                    [ input
                        [ id prefixedId
                        , type_ "radio"
                        , name c.name
                        , value (c.toString option)
                        , checked (c.value == option)
                        , onInput (c.fromString >> Maybe.withDefault c.value >> c.setter >> Update)
                        ]
                        []
                    , label [ for prefixedId ] [ text (c.toString option) ]
                    ]
            )
            c.options


counter :
    { value : Float
    , toString : Float -> String
    , onClickPlus : msg
    , onClickMinus : msg
    }
    -> Html (Msg model msg)
counter c =
    labeledButton []
        [ button [ onClick (Custom c.onClickMinus) ] [ text "-" ]
        , basicLabel [] [ text (c.toString c.value) ]
        , button [ onClick (Custom c.onClickPlus) ] [ text "+" ]
        ]
