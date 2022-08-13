module UI.Modal exposing
    ( modal, header, content, description, actions
    , basicModal, basicHeader, basicContent, basicActions
    , dialog
    )

{-|

@docs modal, header, content, description, actions
@docs basicModal, basicHeader, basicContent, basicActions

@docs dialog

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, each, selector)
import Css.Palette as Palette exposing (darkPalette, darkPaletteWith, palette, paletteWith, setBackground, setBorder, setColor)
import Css.Typography as Typography exposing (typography)
import Data.Theme exposing (Theme(..))
import Html.Styled as Html exposing (Attribute, Html, text)
import Html.Styled.Attributes as Attributes
import UI.Dimmer exposing (pageDimmer)


modalBasis :
    { toggle : msg, shadow : Bool, theme : Theme, additionalStyles : List Style }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
modalBasis { toggle, shadow, theme, additionalStyles } attributes children_ =
    pageDimmer { isActive = True, toggle = toggle }
        []
        [ Html.styled Html.div
            [ -- .ui.modal
              position absolute

            -- display: none;
            , zIndex (int 1001)
            , textAlign left
            , palette (Palette.init |> setBackground (hex "#FFFFFF"))
            , -- .ui.inverted.modal
              darkPalette theme (Palette.init |> setBackground (rgba 0 0 0 0.9))
            , property "border" "none"
            , if shadow then
                prefixed [] "box-shadow" "1px 3px 3px 0 rgba(0, 0, 0, 0.2), 1px 3px 15px 2px rgba(0, 0, 0, 0.2)"

              else
                prefixed [] "box-shadow" "none" |> important
            , property "-webkit-transform-origin" "50% 25%"
            , property "transform-origin" "50% 25%"
            , prefixed [] "flex" "0 0 auto"
            , if shadow then
                borderRadius (rem 0.28571429)

              else
                borderRadius zero
            , prefixed [] "user-select" "text"
            , property "will-change" "top, left, margin, transform, opacity"
            , children
                [ -- .ui.modal > :first-child:not(.icon):not(.dimmer)
                  -- .ui.modal > i.icon:first-child + *
                  -- .ui.modal > .dimmer:first-child + *:not(.icon)
                  -- .ui.modal > .dimmer:first-child + i.icon + *
                  each
                    [ selector ":first-child:not(.icon):not(.dimmer)"
                    , selector "i.icon:first-child + *"
                    , selector ".dimmer:first-child + *:not(.icon)"
                    , selector ".dimmer:first-child + i.icon + *"
                    ]
                    [ borderTopLeftRadius (rem 0.28571429)
                    , borderTopRightRadius (rem 0.28571429)
                    ]

                -- .ui.modal > :last-child
                , selector ":last-child"
                    [ borderBottomLeftRadius (rem 0.28571429)
                    , borderBottomRightRadius (rem 0.28571429)
                    ]
                ]

            -- AdditionalStyles
            , batch additionalStyles
            ]
            attributes
            children_
        ]


modal :
    { open : Bool, toggle : msg, theme : Theme }
    -> List (Attribute msg)
    ->
        { header : List (Html msg)
        , content : List (Html msg)
        , actions : List (Html msg)
        }
    -> Html msg
modal { open, toggle, theme } attributes hca =
    let
        has list f =
            case list of
                [] ->
                    text ""

                nonEmpty ->
                    f nonEmpty

        options =
            { theme = theme }
    in
    if open then
        modalBasis
            { toggle = toggle
            , shadow = True
            , theme = theme
            , additionalStyles = []
            }
            attributes
            [ has hca.header (header options [])
            , has hca.content (content options [])
            , has hca.actions (actions options [])
            ]

    else
        text ""


basicModal :
    { open : Bool, toggle : msg }
    -> List (Attribute msg)
    ->
        { header : List (Html msg)
        , content : List (Html msg)
        , actions : List (Html msg)
        }
    -> List (Html msg)
    -> Html msg
basicModal { open, toggle } attributes hca children =
    let
        has list f =
            case list of
                [] ->
                    text ""

                nonEmpty ->
                    f nonEmpty
    in
    if open then
        modalBasis
            { toggle = toggle
            , shadow = False
            , theme = Light
            , additionalStyles =
                [ -- .ui.basic.modal
                  palette
                    (Palette.init
                        |> setBackground Palette.transparent
                        |> setColor (hex "#FFFFFF")
                    )
                ]
            }
            attributes
            ([ has hca.header (basicHeader [])
             , has hca.content (basicContent [])
             , has hca.actions (basicActions [])
             ]
                ++ children
            )

    else
        text ""


headerBasis : { theme : Theme, additionalStyles : List Style } -> List (Attribute msg) -> List (Html msg) -> Html msg
headerBasis { theme, additionalStyles } =
    Html.styled Html.header
        [ -- .ui.modal > .header
          display block
        , typography Typography.bold
        , paletteWith { border = borderBottom3 (px 1) solid }
            (Palette.init
                |> setBackground (hex "#FFFFFF")
                |> setColor (rgba 0 0 0 0.85)
                |> setBorder (rgba 34 36 38 0.15)
            )
        , darkPalette theme
            (Palette.init
                |> setBackground (rgba 0 0 0 0.9)
                |> setColor (hex "#FFFFFF")
            )
        , margin zero
        , padding2 (rem 1.25) (rem 1.5)
        , prefixed [] "box-shadow" "none"

        -- .ui.modal > .header:not(.ui)
        , fontSize (rem 1.42857143)
        , lineHeight (em 1.28571429)

        -- AdditionalStyles
        , batch additionalStyles
        ]


header : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
header { theme } =
    headerBasis { theme = theme, additionalStyles = [] }


basicHeader : List (Attribute msg) -> List (Html msg) -> Html msg
basicHeader =
    headerBasis
        { theme = Light
        , additionalStyles =
            [ backgroundColor transparent

            -- .ui.basic.modal > .header
            , color (hex "#FFFFFF")
            , property "border-bottom" "none"
            ]
        }


contentBasis : { theme : Theme, additionalStyles : List Style } -> List (Attribute msg) -> List (Html msg) -> Html msg
contentBasis { theme, additionalStyles } =
    Html.styled Html.div
        [ -- .ui.modal > .content
          display block
        , width (pct 100)
        , fontSize (em 1)
        , lineHeight (num 1.4)
        , padding (rem 1.5)
        , palette (Palette.init |> setBackground (hex "#FFFFFF"))
        , darkPalette theme
            (Palette.init
                |> setBackground (rgba 0 0 0 0.9)
                |> setColor (hex "#FFFFFF")
            )

        -- AdditionalStyles
        , batch additionalStyles
        ]


content : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
content { theme } =
    contentBasis { theme = theme, additionalStyles = [] }


basicContent : List (Attribute msg) -> List (Html msg) -> Html msg
basicContent =
    contentBasis
        { theme = Light
        , additionalStyles = [ backgroundColor transparent ]
        }


description : List (Attribute msg) -> List (Html msg) -> Html msg
description =
    Html.styled Html.div
        [ -- .ui.modal > .content > .description
          display block
        , prefixed [] "flex" "1 0 auto"
        , minWidth zero
        , prefixed [] "align-self" "start"
        ]


actionsBasis : { theme : Theme } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
actionsBasis { theme } additionalStyles =
    Html.styled Html.div
        [ -- .ui.modal > .actions
          padding2 (rem 1) (rem 1)
        , textAlign right

        -- Palette
        , paletteWith { border = borderTop3 (px 1) solid }
            (Palette.init
                |> setBackground (hex "#F9FAFB")
                |> setBorder (rgba 34 36 38 0.15)
            )
        , darkPaletteWith theme { border = borderTop3 (px 1) solid } <|
            -- .ui.inverted.modal > .actions
            (Palette.init
                |> setBackground (hex "#191A1B")
                |> setColor (hex "#FFFFFF")
                |> setBorder (rgba 34 36 38 0.85)
            )

        -- AdditionalStyles
        , batch additionalStyles
        ]


actions : { theme : Theme } -> List (Attribute msg) -> List (Html msg) -> Html msg
actions { theme } =
    actionsBasis { theme = theme } []


basicActions : List (Attribute msg) -> List (Html msg) -> Html msg
basicActions =
    actionsBasis { theme = Light } [ backgroundColor transparent ]


dialogBasis : { shadow : Bool, theme : Theme, additionalStyles : List Style } -> List (Attribute msg) -> List (Html msg) -> Html msg
dialogBasis { shadow, theme, additionalStyles } =
    Html.styled (Html.node "dialog")
        [ -- .ui.modal
          position absolute

        -- display: none;
        , zIndex (int 1001)
        , textAlign left
        , palette (Palette.init |> setBackground (hex "#FFFFFF"))
        , -- .ui.inverted.modal
          darkPalette theme (Palette.init |> setBackground (rgba 0 0 0 0.9))
        , property "border" "none"
        , if shadow then
            prefixed [] "box-shadow" "1px 3px 3px 0 rgba(0, 0, 0, 0.2), 1px 3px 15px 2px rgba(0, 0, 0, 0.2)"

          else
            prefixed [] "box-shadow" "none" |> important
        , property "-webkit-transform-origin" "50% 25%"
        , property "transform-origin" "50% 25%"
        , prefixed [] "flex" "0 0 auto"
        , if shadow then
            borderRadius (rem 0.28571429)

          else
            borderRadius zero
        , prefixed [] "user-select" "text"
        , property "will-change" "top, left, margin, transform, opacity"
        , children
            [ -- .ui.modal > :first-child:not(.icon):not(.dimmer)
              -- .ui.modal > i.icon:first-child + *
              -- .ui.modal > .dimmer:first-child + *:not(.icon)
              -- .ui.modal > .dimmer:first-child + i.icon + *
              each
                [ selector ":first-child:not(.icon):not(.dimmer)"
                , selector "i.icon:first-child + *"
                , selector ".dimmer:first-child + *:not(.icon)"
                , selector ".dimmer:first-child + i.icon + *"
                ]
                [ borderTopLeftRadius (rem 0.28571429)
                , borderTopRightRadius (rem 0.28571429)
                ]

            -- .ui.modal > :last-child
            , selector ":last-child"
                [ borderBottomLeftRadius (rem 0.28571429)
                , borderBottomRightRadius (rem 0.28571429)
                ]
            ]

        -- AdditionalStyles
        , batch additionalStyles
        ]


dialog :
    { open : Bool, theme : Theme }
    -> List (Attribute msg)
    ->
        { header : List (Html msg)
        , content : List (Html msg)
        , actions : List (Html msg)
        }
    -> Html msg
dialog options attributes hca =
    let
        has list f =
            case list of
                [] ->
                    text ""

                nonEmpty ->
                    f nonEmpty

        options_ =
            { theme = options.theme }
    in
    dialogBasis { shadow = True, theme = options.theme, additionalStyles = [] }
        (if options.open then
            Attributes.attribute "open" "" :: attributes

         else
            attributes
        )
        [ has hca.header (header options_ [])
        , has hca.content (content options_ [])
        , has hca.actions (actions options_ [])
        ]
