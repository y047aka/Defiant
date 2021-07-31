module UI.Modal exposing
    ( modal, header, content, description, actions
    , basicModal, basicHeader, basicContent, basicActions
    )

{-|

@docs modal, header, content, description, actions
@docs basicModal, basicHeader, basicContent, basicActions

-}

import Css exposing (..)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, each, selector)
import Css.Prefix as Prefix
import Css.Typography exposing (fomanticFont)
import Html.Styled as Html exposing (Attribute, Html, text)


modalBasis : { shadow : Bool, inverted : Bool, additionalStyles : List Style } -> List (Attribute msg) -> List (Html msg) -> Html msg
modalBasis { shadow, inverted, additionalStyles } =
    Html.styled Html.div <|
        [ -- .ui.modal
          position absolute

        -- display: none;
        , zIndex (int 1001)
        , textAlign left
        , if inverted then
            property "background" "#FFFFFF"

          else
            -- .ui.inverted.modal
            property "background" "rgba(0, 0, 0, 0.9)"
        , property "border" "none"
        , if shadow then
            prefixed [] "box-shadow" "1px 3px 3px 0 rgba(0, 0, 0, 0.2), 1px 3px 15px 2px rgba(0, 0, 0, 0.2)"

          else
            prefixed [] "box-shadow" "none" |> important
        , property "-webkit-transform-origin" "50% 25%"
        , property "transform-origin" "50% 25%"
        , Prefix.flex "0 0 auto"
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
        ]
            ++ additionalStyles


modal :
    { inverted : Bool }
    -> List (Attribute msg)
    ->
        { header : List (Html msg)
        , content : List (Html msg)
        , actions : List (Html msg)
        }
    -> Html msg
modal { inverted } attributes hca =
    let
        has list f =
            case list of
                [] ->
                    text ""

                nonEmpty ->
                    f nonEmpty

        options =
            { inverted = inverted }
    in
    modalBasis { shadow = True, inverted = inverted, additionalStyles = [] }
        attributes
        [ has hca.header (header options [])
        , has hca.content (content options [])
        , has hca.actions (actions options [])
        ]


basicModal :
    List (Attribute msg)
    ->
        { header : List (Html msg)
        , content : List (Html msg)
        , actions : List (Html msg)
        }
    -> List (Html msg)
    -> Html msg
basicModal attributes hca children =
    let
        has list f =
            case list of
                [] ->
                    text ""

                nonEmpty ->
                    f nonEmpty
    in
    modalBasis
        { shadow = False
        , inverted = False
        , additionalStyles =
            [ -- .ui.basic.modal
              backgroundColor transparent
            , color (hex "#FFFFFF")
            ]
        }
        attributes
        ([ has hca.header (basicHeader [])
         , has hca.content (basicContent [])
         , has hca.actions (basicActions [])
         ]
            ++ children
        )


headerBasis : { inverted : Bool, additionalStyles : List Style } -> List (Attribute msg) -> List (Html msg) -> Html msg
headerBasis { inverted, additionalStyles } =
    Html.styled Html.header <|
        [ -- .ui.modal > .header
          display block
        , fontFamilies fomanticFont
        , if inverted then
            batch
                [ property "background" "rgba(0, 0, 0, 0.9)"
                , color (hex "#FFFFFF")
                ]

          else
            batch
                [ property "background" "#FFFFFF"
                , color (rgba 0 0 0 0.85)
                ]
        , margin zero
        , padding2 (rem 1.25) (rem 1.5)
        , prefixed [] "box-shadow" "none"
        , borderBottom3 (px 1) solid (rgba 34 36 38 0.15)

        -- .ui.modal > .header:not(.ui)
        , fontSize (rem 1.42857143)
        , lineHeight (em 1.28571429)
        , fontWeight bold
        ]
            ++ additionalStyles


header : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
header { inverted } =
    headerBasis { inverted = inverted, additionalStyles = [] }


basicHeader : List (Attribute msg) -> List (Html msg) -> Html msg
basicHeader =
    headerBasis
        { inverted = False
        , additionalStyles =
            [ backgroundColor transparent

            -- .ui.basic.modal > .header
            , color (hex "#FFFFFF")
            , property "border-bottom" "none"
            ]
        }


contentBasis : { inverted : Bool, additionalStyles : List Style } -> List (Attribute msg) -> List (Html msg) -> Html msg
contentBasis { inverted, additionalStyles } =
    Html.styled Html.div <|
        [ -- .ui.modal > .content
          display block
        , width (pct 100)
        , fontSize (em 1)
        , lineHeight (num 1.4)
        , padding (rem 1.5)
        , if inverted then
            batch
                [ property "background" "rgba(0, 0, 0, 0.9)"
                , color (hex "#FFFFFF")
                ]

          else
            property "background" "#FFFFFF"
        ]
            ++ additionalStyles


content : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
content { inverted } =
    contentBasis { inverted = inverted, additionalStyles = [] }


basicContent : List (Attribute msg) -> List (Html msg) -> Html msg
basicContent =
    contentBasis
        { inverted = False
        , additionalStyles = [ backgroundColor transparent ]
        }


description : List (Attribute msg) -> List (Html msg) -> Html msg
description =
    Html.styled Html.div
        [ -- .ui.modal > .content > .description
          display block
        , Prefix.flex "1 0 auto"
        , minWidth zero
        , Prefix.alignSelf "start"
        ]


actionsBasis : { inverted : Bool } -> List Style -> List (Attribute msg) -> List (Html msg) -> Html msg
actionsBasis { inverted } additionalStyles =
    Html.styled Html.div <|
        [ -- .ui.modal > .actions
          if inverted then
            batch
                [ -- .ui.inverted.modal > .actions
                  property "background" "#191A1B"
                , borderTop3 (px 1) solid (rgba 34 36 38 0.85)
                , color (hex "#FFFFFF")
                ]

          else
            batch
                [ property "background" "#F9FAFB"
                , borderTop3 (px 1) solid (rgba 34 36 38 0.15)
                ]
        , padding2 (rem 1) (rem 1)
        , textAlign right
        ]
            ++ additionalStyles


actions : { inverted : Bool } -> List (Attribute msg) -> List (Html msg) -> Html msg
actions { inverted } =
    actionsBasis { inverted = inverted } []


basicActions : List (Attribute msg) -> List (Html msg) -> Html msg
basicActions =
    actionsBasis { inverted = False } [ backgroundColor transparent ]
