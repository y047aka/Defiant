module Control exposing
    ( Control(..)
    , StringProps, BoolProps, SelectProps, RadioProps, CounterProps, BoolAndStringProps
    , render
    , comment, string, bool, select, radio, counter, boolAndString
    , field
    , customize
    )

{-|

@docs Control
@docs StringProps, BoolProps, SelectProps, RadioProps, CounterProps, BoolAndStringProps
@docs render
@docs comment, string, bool, select, radio, counter, boolAndString
@docs field
@docs customize

-}

import Css exposing (..)
import Css.Extra exposing (columnGap, fr, grid, gridColumn, gridRow, gridTemplateColumns)
import Css.Global exposing (children, everything, generalSiblings, selector, typeSelector)
import Css.Palette as Palette exposing (Palette, palette, paletteWithBorder, setBackground, setBorder, setColor)
import Css.Palette.Extra exposing (paletteByState)
import Html.Styled as Html exposing (Attribute, Html, div, input, text)
import Html.Styled.Attributes as Attributes exposing (css, for, id, placeholder, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import UI.Checkbox as Checkbox
import UI.Input as Input
import UI.Layout.Stack as Stack exposing (stack)


type Control msg
    = Comment String
    | String (StringProps msg)
    | Bool (BoolProps msg)
    | Select (SelectProps msg)
    | Radio (RadioProps msg)
    | Counter (CounterProps msg)
    | BoolAndString (BoolAndStringProps msg)
    | Field String (Control msg)
    | Customize (Html msg)


type alias StringProps msg =
    { value : String
    , onInput : String -> msg
    , placeholder : String
    }


type alias BoolProps msg =
    { id : String
    , value : Bool
    , onClick : msg
    }


type alias SelectProps msg =
    { value : String
    , options : List String
    , onChange : String -> msg
    }


type alias RadioProps msg =
    { value : String
    , options : List String
    , onChange : String -> msg
    }


type alias CounterProps msg =
    { value : Float
    , toString : Float -> String
    , onClickPlus : msg
    , onClickMinus : msg
    }


type alias BoolAndStringProps msg =
    { label : String
    , id : String
    , data : { visible : Bool, value : String }
    , onUpdate : { visible : Bool, value : String } -> msg
    , placeholder : String
    }


comment : String -> Control msg
comment =
    Comment


string : StringProps msg -> Control msg
string =
    String


bool : BoolProps msg -> Control msg
bool =
    Bool


select : SelectProps msg -> Control msg
select =
    Select


radio : RadioProps msg -> Control msg
radio =
    Radio


counter : CounterProps msg -> Control msg
counter =
    Counter


boolAndString : BoolAndStringProps msg -> Control msg
boolAndString =
    BoolAndString


field : String -> Control msg -> Control msg
field label control =
    Field label control


customize : Html msg -> Control msg
customize =
    Customize



-- Palette


textOptional : Palette Color
textOptional =
    { background = Nothing
    , color = Just (hsl 0 0 0.6)
    , border = Nothing
    }


formField : Palette Color
formField =
    { background = Just (rgba 0 0 0 0)
    , color = Just (rgba 0 0 0 0.87)
    , border = Just (rgba 34 36 38 0.15)
    }



-- VIEW


render : Control msg -> Html msg
render control =
    case control of
        Comment str ->
            Html.div
                [ css
                    [ palette textOptional
                    , empty [ display none ]
                    ]
                ]
                [ text str ]

        String ps ->
            input
                [ type_ "text"
                , value ps.value
                , onInput ps.onInput
                , placeholder ps.placeholder
                , css
                    [ property "appearance" "none"
                    , width (pct 100)
                    , padding (em 0.75)
                    , fontSize inherit
                    , lineHeight (em 1)
                    , borderRadius (em 0.25)
                    , paletteWithBorder (border3 (px 1) solid) formField
                    , focus
                        [ palette
                            { background = Nothing
                            , color = Just (rgba 0 0 0 0.95)
                            , border = Just (hex "#85b7d9")
                            }
                        , outline none
                        ]
                    ]
                ]
                []

        Bool ps ->
            toggleCheckbox
                { id = ps.id
                , checked = ps.value
                , onClick = ps.onClick
                }

        Select ps ->
            Html.div
                [ css
                    [ display grid
                    , property "grid-template-columns" "1fr auto"
                    , alignItems center
                    , before
                        [ property "content" (qt "▼")
                        , gridColumn "2"
                        , gridRow "1"
                        , padding (em 1)
                        , fontSize (em 0.6)
                        ]
                    ]
                ]
                [ Html.select
                    [ onInput ps.onChange
                    , css
                        [ gridColumn "1 / -1"
                        , gridRow "1"
                        , property "appearance" "none"
                        , width (pct 100)
                        , padding (em 0.75)
                        , fontSize inherit
                        , lineHeight (em 1)
                        , borderRadius (em 0.25)
                        , paletteWithBorder (border3 (px 1) solid) formField
                        , focus
                            [ palette
                                { background = Nothing
                                , color = Just (rgba 0 0 0 0.95)
                                , border = Just (hex "#85b7d9")
                                }
                            , outline none
                            ]
                        ]
                    ]
                    (List.map (\option -> Html.option [ value option, selected (ps.value == option) ] [ text option ])
                        ps.options
                    )
                ]

        Radio ps ->
            Html.div []
                (List.map
                    (\option ->
                        Html.label [ css [ display block ] ]
                            [ input
                                [ type_ "radio"
                                , value option
                                , Attributes.checked (ps.value == option)
                                , onInput ps.onChange
                                ]
                                []
                            , text option
                            ]
                    )
                    ps.options
                )

        Counter ps ->
            labeledButtons []
                [ button_ [ onClick ps.onClickMinus ] [ text "-" ]
                , basicLabel [] [ text (ps.toString ps.value) ]
                , button_ [ onClick ps.onClickPlus ] [ text "+" ]
                ]

        BoolAndString ({ data } as ps) ->
            stack (Stack.defaultProps |> Stack.setGap 0.5)
                []
                [ Checkbox.toggleCheckbox
                    { id = ps.id
                    , label = ps.label
                    , checked = data.visible
                    , disabled = False
                    , onClick = ps.onUpdate { data | visible = not data.visible }
                    }
                , Input.input []
                    [ input
                        [ type_ "text"
                        , value data.value
                        , onInput (\string_ -> ps.onUpdate { data | value = string_ })
                        , Attributes.placeholder ps.placeholder
                        ]
                        []
                    ]
                ]

        Field label cntl ->
            div
                [ css
                    [ display grid
                    , gridTemplateColumns [ fr 1, fr 1 ]
                    , alignItems center
                    , columnGap (em 0.25)
                    ]
                ]
                [ Html.label [] [ text label ]
                , render cntl
                ]

        Customize view ->
            view



-- VIEW HELPERS


toggleCheckbox :
    { id : String
    , checked : Bool
    , onClick : msg
    }
    -> Html msg
toggleCheckbox props =
    Html.styled Html.div
        [ display grid
        , children [ everything [ gridColumn "1", gridRow "1" ] ]
        ]
        []
        [ toggleInput
            [ id props.id
            , type_ "checkbox"
            , Attributes.checked props.checked
            , onClick props.onClick
            ]
            []
        , toggleLabel [ for props.id ] []
        ]


toggleInput : List (Attribute msg) -> List (Html msg) -> Html msg
toggleInput =
    Html.styled Html.input
        [ cursor pointer
        , width (rem 3.5)
        , height (rem 1.5)
        , opacity zero
        , focus
            [ generalSiblings
                [ Css.Global.label
                    [ before [ palette (Palette.init |> setBackground (rgba 0 0 0 0.15)) ] ]
                ]
            ]
        , checked
            [ generalSiblings
                [ Css.Global.label
                    [ before
                        [ palette
                            (Palette.init
                                |> setBackground (hex "#2185D0")
                                |> setBorder (rgba 34 36 38 0.35)
                            )
                        ]
                    , after
                        [ left (rem 2.15) ]
                    ]
                ]
            , focus
                [ generalSiblings
                    [ Css.Global.label
                        [ before
                            [ backgroundColor (hex "#0d71bb") ]
                        ]
                    ]
                ]
            ]
        ]


toggleLabel : List (Attribute msg) -> List (Html msg) -> Html msg
toggleLabel =
    Html.styled Html.label
        [ position relative
        , outline none
        , before
            [ position absolute
            , top zero
            , left zero
            , zIndex (int 1)
            , property "content" "''"
            , display block
            , width (rem 3.5)
            , height (rem 1.5)
            , borderRadius (rem 500)
            , property "-webkit-transition" "border 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, transform 0.1s ease, box-shadow 0.1s ease"
            , property "transition" "border 0.1s ease, opacity 0.1s ease, transform 0.1s ease, box-shadow 0.1s ease, -webkit-transform 0.1s ease, -webkit-box-shadow 0.1s ease"
            , palette
                (Palette.init
                    |> setBackground (rgba 0 0 0 0.05)
                    |> setBorder (hex "#D4D4D5")
                )
            ]
        , after
            [ position absolute
            , top zero
            , left (rem -0.05)
            , zIndex (int 2)
            , property "content" "''"
            , width (rem 1.5)
            , height (rem 1.5)
            , borderRadius (rem 500)
            , property "-webkit-transition" "background 0.3s ease, left 0.3s ease"
            , property "transition" "background 0.3s ease, left 0.3s ease"
            , property "background" "#FFFFFF -webkit-gradient(linear, left top, left bottom, from(transparent), to(rgba(0, 0, 0, 0.05)))"
            , property "background" "#FFFFFF -webkit-linear-gradient(transparent, rgba(0, 0, 0, 0.05))"
            , property "background" "#FFFFFF linear-gradient(transparent, rgba(0, 0, 0, 0.05))"
            , property "-webkit-box-shadow" "0 1px 2px 0 rgba(34, 36, 38, 0.15), 0 0 0 1px rgba(34, 36, 38, 0.15) inset"
            , property "box-shadow" "0 1px 2px 0 rgba(34, 36, 38, 0.15), 0 0 0 1px rgba(34, 36, 38, 0.15) inset"
            ]
        , active
            [ before
                [ palette (Palette.init |> setBackground (hex "#F9FAFB")) ]
            , after
                [ color (rgba 0 0 0 0.95) ]
            ]
        , hover
            [ before
                [ palette (Palette.init |> setBackground (rgba 0 0 0 0.15)) ]
            ]
        ]


labeledButtons : List (Attribute msg) -> List (Html msg) -> Html msg
labeledButtons attributes =
    Html.div <|
        css
            [ cursor pointer
            , display grid
            , property "grid-template-columns" "auto 1fr auto"
            , children
                [ typeSelector "button"
                    [ firstChild
                        [ borderTopRightRadius zero
                        , borderBottomRightRadius zero
                        ]
                    , lastChild
                        [ borderTopLeftRadius zero
                        , borderBottomLeftRadius zero
                        ]
                    ]
                , selector "*:not(button)"
                    [ displayFlex
                    , alignItems center
                    , justifyContent center
                    , fontSize (em 1)
                    , borderColor (rgba 34 36 38 0.15)

                    -- Extra Styles
                    , borderRadius zero
                    ]
                ]
            ]
            :: attributes


button_ : List (Attribute msg) -> List (Html msg) -> Html msg
button_ =
    Html.styled Html.button
        [ cursor pointer
        , minHeight (em 1)
        , outline none
        , borderStyle none
        , textAlign center
        , lineHeight (em 1)
        , fontWeight bold
        , padding2 (em 0.75) (em 1.5)
        , borderRadius (em 0.25)
        , property "user-select" "none"
        , paletteByState defaultPalettes
        , disabled
            [ cursor default
            , opacity (num 0.45)
            , backgroundImage none
            , pointerEvents none
            ]
        ]


defaultPalettes : ( Palette (ColorValue Color), List ( List Style -> Style, Palette (ColorValue Color) ) )
defaultPalettes =
    let
        default =
            { background = Just (hex "#E0E1E2")
            , color = Just (rgba 0 0 0 0.6)
            , border = Nothing
            }
    in
    ( default
    , [ ( hover, default |> setBackground (hex "#CACBCD") |> setColor (rgba 0 0 0 0.8) )
      , ( focus, default |> setBackground (hex "#CACBCD") |> setColor (rgba 0 0 0 0.8) )
      , ( active, default |> setBackground (hex "#BABBBC") |> setColor (rgba 0 0 0 0.9) )
      ]
    )


basicLabel : List (Attribute msg) -> List (Html msg) -> Html msg
basicLabel =
    Html.styled Html.div
        [ display inlineBlock
        , fontSize (rem 0.85714286)
        , lineHeight (num 1)
        , palette
            { background = Nothing
            , color = Just (rgba 0 0 0 0.87)
            , border = Nothing
            }
        , border3 (px 1) solid (rgba 34 36 38 0.15)
        , borderRadius (rem 0.25)
        , property "-webkit-transition" "background 0.1s ease"
        , property "transition" "background 0.1s ease"
        ]
