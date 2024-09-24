module UI.Button exposing
    ( Props
    , Layout(..), Size(..), Variant(..), IconPosition(..)
    , button
    )

{-|

@docs Props
@docs Layout, Size, Variant, IconPosition
@docs button

-}

import Html.Styled as Html exposing (Html, node, span)
import Html.Styled.Attributes exposing (classList)
import Maybe.Extra exposing (isJust)


type Layout
    = Intrinsic
    | FullWidth


type Size
    = Large
    | Medium
    | Small


type Variant
    = Contained
    | Outlined
    | Lighted
    | Neutral
    | Danger


type alias Props msg =
    { layout : Layout
    , size : Size
    , variant : Variant
    , icon : Maybe (Html msg)
    , iconPosition : IconPosition
    }


type IconPosition
    = Start
    | End


blockName : String
blockName =
    "defiant-Button"


button : Props msg -> List (Html msg) -> Html msg
button { layout, size, variant, icon, iconPosition } children =
    Html.button
        [ classList
            [ ( blockName, True )
            , ( blockName ++ "--" ++ layoutToString layout, True )
            , ( blockName ++ "--" ++ sizeToString size, True )
            , ( blockName ++ "--" ++ variantToString variant, True )
            , ( blockName ++ "--icon" ++ iconPositionToString iconPosition, isJust icon )
            ]
        ]
        (buttonStyle
            :: (case icon of
                    Just icon_ ->
                        span
                            [ classList
                                [ ( blockName ++ "-icon", True )
                                , ( blockName ++ "-icon--" ++ sizeToString size, True )
                                ]
                            ]
                            [ icon_ ]
                            :: children

                    Nothing ->
                        children
               )
        )


buttonStyle : Html msg
buttonStyle =
    node "style"
        []
        [ Html.text """
/*
 * Button
 * NOTE: Styles can be overridden with "--Button-*" variables
*/
:root {
  --Button-tapHighlightColor: var(--gray-5-alpha);
  --Button-onFocus-outlineColor: var(--color-focus-clarity);

  --Button--contained-backgroundColor: var(--color-surface-accent-primary);
  --Button--contained-color: var(--color-text-high-emphasis-inverse);
  --Button--contained-onActive-backgroundColor: var(--primary-green-100);
  --Button--contained-onHover-backgroundColor: var(--primary-green-100);

  --Button--outlined-borderColor: var(--color-border-accent-primary);
  --Button--outlined-color: var(--color-text-accent-primary);
  --Button--outlined-onActive-backgroundColor: var(--primary-green-5);
  --Button--outlined-onHover-backgroundColor: var(--primary-green-5);

  --Button--lighted-backgroundColor: var(--color-surface-accent-primary-light);
  --Button--lighted-color: var(--color-text-accent-primary);
  --Button--lighted-onActive-backgroundColor: var(--primary-green-10);
  --Button--lighted-onHover-backgroundColor: var(--primary-green-10);

  --Button--neutral-backgroundColor: var(--color-surface-tertiary);
  --Button--neutral-color: var(--color-text-medium-emphasis);
  --Button--neutral-onActive-backgroundColor: var(--gray-20-alpha);
  --Button--neutral-onHover-backgroundColor: var(--gray-20-alpha);

  --Button--danger-borderColor: var(--color-border-caution);
  --Button--danger-color: var(--color-text-caution);
  --Button--danger-onActive-backgroundColor: var(--caution-red-5-alpha);
  --Button--danger-onHover-backgroundColor: var(--caution-red-5-alpha);
}

/*
 * Button base
*/
.defiant-Button {
  align-items: center;
  box-sizing: border-box;
  display: inline-flex;
  font-family: inherit;
  font-weight: bold;
  justify-content: center;
  line-height: 1.3;
  margin: 0;
  -webkit-tap-highlight-color: var(--Button-tapHighlightColor);
  text-align: center;
  transition: background-color 0.3s;
}

.defiant-Button:disabled {
  opacity: 0.3;
}

.defiant-Button:focus {
  outline: 2px solid var(--Button-onFocus-outlineColor);
  outline-offset: 1px;
}

.defiant-Button:focus:not(:focus-visible) {
  outline: none;
}

/*
 * Button layout
*/
.defiant-Button--fullWidth {
  width: 100%;
}

/*
 * Button sizes
*/
.defiant-Button--large {
  /* To be relative value with font size; this means base height / base font size  */
  border-radius: calc(48em / 16);
  font-size: 1em;
  min-height: 48px;
  padding: 8px 16px;
}

.defiant-Button--medium {
  border-radius: calc(40em / 14);
  font-size: 0.875em;
  min-height: 40px;
  padding: 8px 16px;
}

.defiant-Button--small {
  border-radius: calc(32em / 13);
  font-size: 0.8125em;
  min-height: 32px;
  padding: 6px 10px;
}

/* Bordered small buttons exceeds the minimum height with the default padding */
.defiant-Button--small:is(.defiant-Button--outlined, .defiant-Button--danger) {
  padding-bottom: 5px;
  padding-top: 5px;
}

/*
 * Setting height to a value less then min-height fixes the align-items: center issue in IE11
 * @see https://github.com/philipwalton/flexbugs/issues/231#issue-245848315
*/
@media all and (-ms-high-contrast: none), (-ms-high-contrast: active) {
  .defiant-Button--large,
  .defiant-Button--medium,
  .defiant-Button--small {
    height: 1px;
  }
}

/*
 * Button variants
*/
/* contained */
.defiant-Button--contained {
  background-color: var(--Button--contained-backgroundColor);
  border: none;
  color: var(--Button--contained-color);
}

.defiant-Button--contained:active {
  background-color: var(--Button--contained-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-Button--contained:not([disabled]):hover {
    background-color: var(--Button--contained-onHover-backgroundColor);
  }
}

/* outlined */
.defiant-Button--outlined {
  background-color: transparent;
  border: 2px solid var(--Button--outlined-borderColor);
  color: var(--Button--outlined-color);
}

.defiant-Button--outlined:active {
  background-color: var(--Button--outlined-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-Button--outlined:not([disabled]):hover {
    background-color: var(--Button--outlined-onHover-backgroundColor);
  }
}

/* lighted */
.defiant-Button--lighted {
  background-color: var(--Button--lighted-backgroundColor);
  border: none;
  color: var(--Button--lighted-color);
}

.defiant-Button--lighted:active {
  background-color: var(--Button--lighted-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-Button--lighted:not([disabled]):hover {
    background-color: var(--Button--lighted-onHover-backgroundColor);
  }
}

/* neutral */
.defiant-Button--neutral {
  background-color: var(--Button--neutral-backgroundColor);
  border: none;
  color: var(--Button--neutral-color);
}

.defiant-Button--neutral:active {
  background-color: var(--Button--neutral-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-Button--neutral:not([disabled]):hover {
    background-color: var(--Button--neutral-onHover-backgroundColor);
  }
}

/* danger */
.defiant-Button--danger {
  background-color: transparent;
  border: 2px solid var(--Button--danger-borderColor);
  color: var(--Button--danger-color);
}

.defiant-Button--danger:active {
  background-color: var(--Button--danger-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-Button--danger:not([disabled]):hover {
    background-color: var(--Button--danger-onHover-backgroundColor);
  }
}

/*
 * with Icon
*/
.defiant-Button-icon {
  line-height: 0; /* Fix Icon position align */
}

.defiant-Button--iconstart .defiant-Button-icon--large {
  font-size: 1.375em; /* Icon 22px / Text 16px = 1.375 */
  margin-right: 6px;
}

.defiant-Button--iconstart .defiant-Button-icon--medium {
  font-size: 1.429em; /* Icon 20px / Text 14px =  1.42857142857 */
  margin-right: 4px;
}

.defiant-Button--iconstart .defiant-Button-icon--small {
  font-size: 1.23em; /* Icon 16px / Text 13px = 1.23076923077 */
  margin-right: 2px;
}

.defiant-Button--iconend {
  flex-direction: row-reverse;
}

.defiant-Button--iconend .defiant-Button-icon--large {
  font-size: 1.125em; /* Icon 18px / Text 16px = 1.125 */
  margin-left: 6px;
}

.defiant-Button--iconend .defiant-Button-icon--medium {
  font-size: 1.143em; /* Icon 16px / Text 14px =  1.14285714285 */
  margin-left: 4px;
}

.defiant-Button--iconend .defiant-Button-icon--small {
  font-size: 1.077em; /* Icon 14px / Text 13px = 1.07692307692 */
  margin-left: 2px;
}
""" ]



-- HELPERS


layoutToString : Layout -> String
layoutToString layout =
    case layout of
        Intrinsic ->
            "intrinsic"

        FullWidth ->
            "fullWidth"


sizeToString : Size -> String
sizeToString size =
    case size of
        Large ->
            "large"

        Medium ->
            "medium"

        Small ->
            "small"


variantToString : Variant -> String
variantToString variant =
    case variant of
        Contained ->
            "contained"

        Outlined ->
            "outlined"

        Lighted ->
            "lighted"

        Neutral ->
            "neutral"

        Danger ->
            "danger"


iconPositionToString : IconPosition -> String
iconPositionToString iconPosition =
    case iconPosition of
        Start ->
            "start"

        End ->
            "end"
