module Playground exposing (playground)

import Css exposing (..)
import Css.Palette as Palette exposing (darkPalette, palette, setBackground, setBorder, setColor)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Html, div, input, p, text)
import Html.Styled.Attributes as Attributes exposing (css, id, placeholder, selected, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Props exposing (BoolAndStringProps, BoolProps, CounterProps, Props(..), RadioProps, SelectProps, StringProps)
import Types exposing (FormState(..))
import UI.Button exposing (button, labeledButton)
import UI.Checkbox as Checkbox
import UI.Input as Input
import UI.Label exposing (basicLabel)
import UI.Layout.Box as Box exposing (box)
import UI.Layout.Sidebar exposing (withSidebar)
import UI.Layout.Stack as Stack exposing (stack)


type alias ConfigSection msg =
    { label : String
    , configs : List (Props msg)
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
    box (Box.defaultProps |> Box.setPadding 0.5 |> Box.setPalette palette_)
        [ css [ borderRadius (px 20) ] ]
        [ withSidebar
            { side = "right"
            , sideWith = 25
            , contentMin = 50
            , space = 0
            , noStretch = False
            }
            []
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
            , palette (Palette.init |> setBackground (hex "#FFF"))
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
    box
        (Box.defaultProps
            |> Box.setPadding 0.5
            |> Box.setBorderWidth 0
            |> Box.setPalette (Palette.init |> setBackground (hex "EEE") |> setBorder (hex "#DDD"))
        )
        [ css [ borderRadius (px 15) ] ]
    <|
        [ stack (Stack.defaultProps |> Stack.setGap 0.5)
            []
            (List.map
                (\configSection ->
                    box
                        (Box.defaultProps
                            |> Box.setPadding 1
                            |> Box.setBorderWidth 0
                            |> Box.setPalette (Palette.init |> setBackground (hex "FFF"))
                        )
                        [ css [ borderRadius (px 10) ] ]
                        [ stack Stack.defaultProps
                            []
                            (div
                                [ css
                                    [ fontWeight bold
                                    , empty [ display none ]
                                    ]
                                ]
                                [ text configSection.label ]
                                :: List.map render configSection.configs
                            )
                        ]
                )
                configSections
            )
        ]


render : Props msg -> Html msg
render props =
    case props of
        String ps ->
            string ps

        Bool ps ->
            bool ps

        Select ps ->
            select ps

        Radio ps ->
            radio ps

        Counter ps ->
            counter ps

        BoolAndString ps ->
            boolAndString ps

        List childProps ->
            div [] (List.map render childProps)

        FieldSet label childProps ->
            Html.fieldset [] <|
                Html.legend [] [ text label ]
                    :: List.map render childProps

        Field labelAndNote ps ->
            field labelAndNote ps

        Customize view ->
            view


field : { label : String, note : String } -> Props msg -> Html msg
field { label, note } ps =
    stack (Stack.defaultProps |> Stack.setGap 0.5)
        []
        [ Html.label [ css [ empty [ display none ] ] ] [ text label ]
        , render ps
        , p
            [ css
                [ color (hex "#999")
                , empty [ display none ]
                ]
            ]
            [ text note ]
        ]


string : StringProps msg -> Html msg
string ps =
    Input.input []
        [ input
            [ type_ "text"
            , value ps.value
            , onInput ps.onInput
            , placeholder ps.placeholder
            ]
            []
        ]


bool : BoolProps msg -> Html msg
bool ps =
    Checkbox.toggleCheckbox
        { id = ps.label
        , label = ps.label
        , checked = ps.value
        , disabled = False
        , onClick = ps.onClick
        }


select : SelectProps msg -> Html msg
select ps =
    Html.select [ onInput ps.onChange ]
        (List.map (\option -> Html.option [ value option, selected (ps.value == option) ] [ text option ])
            ps.options
        )


radio : RadioProps msg -> Html msg
radio ps =
    div [] <|
        List.map
            (\option ->
                Html.label []
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


counter : CounterProps msg -> Html msg
counter ps =
    labeledButton []
        [ button [ onClick ps.onClickMinus ] [ text "-" ]
        , basicLabel [] [ text (ps.toString ps.value) ]
        , button [ onClick ps.onClickPlus ] [ text "+" ]
        ]


boolAndString : BoolAndStringProps msg -> Html msg
boolAndString { label, id, data, onUpdate, placeholder } =
    stack (Stack.defaultProps |> Stack.setGap 0.5)
        []
        [ Checkbox.toggleCheckbox
            { id = id
            , label = label
            , checked = data.visible
            , disabled = False
            , onClick = onUpdate { data | visible = not data.visible }
            }
        , Input.input []
            [ input
                [ type_ "text"
                , value data.value
                , onInput (\string_ -> onUpdate { data | value = string_ })
                , Attributes.placeholder placeholder
                ]
                []
            ]
        ]
