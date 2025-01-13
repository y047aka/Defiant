module UI.IconButton exposing (Size(..), Variant(..), iconButton)

import Html.Styled exposing (Attribute, Html, button, node, text)
import Html.Styled.Attributes exposing (classList)


type Size
    = Large
    | Medium
    | Small
    | ExSmall


type Variant
    = Contained
    | Outlined
    | Lighted
    | Neutral
    | Danger


type alias Props =
    { size : Size
    , variant : Variant
    }


blockName : String
blockName =
    "defiant-IconButton"


iconButton : Props -> List (Attribute msg) -> List (Html msg) -> Html msg
iconButton { size, variant } attributes children =
    button
        (classList
            [ ( blockName, True )
            , ( blockName ++ "--" ++ sizeToString size, True )
            , ( blockName ++ "--" ++ variantToString variant, True )
            ]
            :: attributes
        )
        (iconButtonStyle :: children)


sizeToString : Size -> String
sizeToString size =
    case size of
        Large ->
            "large"

        Medium ->
            "medium"

        Small ->
            "small"

        ExSmall ->
            "exSmall"


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


iconButtonStyle : Html msg
iconButtonStyle =
    node "style"
        []
        [ text """
/*
 * IconButton
 * NOTE: Styles can be overridden with "--IconButton-*" variables
*/
:root {
  --IconButton-tapHighlightColor: var(--gray-5-alpha);
  --IconButton-onFocus-outlineColor: var(--color-focus-clarity);

  --IconButton--contained-backgroundColor: var(--color-surface-accent-primary);
  --IconButton--contained-color: var(--color-object-high-emphasis-inverse);
  --IconButton--contained-onActive-backgroundColor: var(--primary-green-100);
  --IconButton--contained-onHover-backgroundColor: var(--primary-green-100);

  --IconButton--outlined-borderColor: var(--color-border-accent-primary);
  --IconButton--outlined-color: var(--color-object-accent-primary);
  --IconButton--outlined-onActive-backgroundColor: var(--primary-green-5);
  --IconButton--outlined-onHover-backgroundColor: var(--primary-green-5);

  --IconButton--lighted-backgroundColor: var(
    --color-surface-accent-primary-light
  );
  --IconButton--lighted-color: var(--color-object-accent-primary);
  --IconButton--lighted-onActive-backgroundColor: var(--primary-green-10);
  --IconButton--lighted-onHover-backgroundColor: var(--primary-green-10);

  --IconButton--neutral-backgroundColor: var(--color-surface-tertiary);
  --IconButton--neutral-color: var(--color-object-medium-emphasis);
  --IconButton--neutral-onActive-backgroundColor: var(--gray-20-alpha);
  --IconButton--neutral-onHover-backgroundColor: var(--gray-20-alpha);

  --IconButton--danger-borderColor: var(--color-border-caution);
  --IconButton--danger-color: var(--color-object-caution);
  --IconButton--danger-onActive-backgroundColor: var(--caution-red-5-alpha);
  --IconButton--danger-onHover-backgroundColor: var(--caution-red-5-alpha);
}

/*
 * IconButton
*/
.defiant-IconButton {
  align-items: center;
  border-radius: 100%;
  box-sizing: border-box;
  display: inline-flex;
  justify-content: center;
  margin: 0;
  padding: 0;
  -webkit-tap-highlight-color: var(--IconButton-tapHighlightColor);
  text-align: center;
  transition: background-color 0.3s;
}

.defiant-IconButton:disabled {
  opacity: 0.3;
}

.defiant-IconButton:focus {
  outline: 2px solid var(--IconButton-onFocus-outlineColor);
  outline-offset: 1px;
}

.defiant-IconButton:focus:not(:focus-visible) {
  outline: none;
}

/*
 * IconButton sizes
*/
.defiant-IconButton--large {
  font-size: 1.375em;
  height: 48px;
  width: 48px;
}

.defiant-IconButton--medium {
  font-size: 1.25em;
  height: 40px;
  width: 40px;
}

.defiant-IconButton--small {
  font-size: 1em;
  height: 32px;
  width: 32px;
}

.defiant-IconButton--exSmall {
  font-size: 1em;
  height: 24px;
  width: 24px;
}

/*
 * IconButton variants
*/
/* contained */
.defiant-IconButton--contained {
  background-color: var(--IconButton--contained-backgroundColor);
  border: none;
  color: var(--IconButton--contained-color);
}

.defiant-IconButton--contained:active {
  background-color: var(--IconButton--contained-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-IconButton--contained:not([disabled]):hover {
    background-color: var(--IconButton--contained-onHover-backgroundColor);
  }
}

/* outlined */
.defiant-IconButton--outlined {
  background-color: transparent;
  border: 2px solid var(--IconButton--outlined-borderColor);
  color: var(--IconButton--outlined-color);
}

.defiant-IconButton--outlined:active {
  background-color: var(--IconButton--outlined-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-IconButton--outlined:not([disabled]):hover {
    background-color: var(--IconButton--outlined-onHover-backgroundColor);
  }
}

/* lighted */
.defiant-IconButton--lighted {
  background-color: var(--IconButton--lighted-backgroundColor);
  border: none;
  color: var(--IconButton--lighted-color);
  padding-bottom: 8px;
  padding-top: 8px;
}

.defiant-IconButton--lighted:active {
  background-color: var(--IconButton--lighted-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-IconButton--lighted:not([disabled]):hover {
    background-color: var(--IconButton--lighted-onHover-backgroundColor);
  }
}

/* neutral */
.defiant-IconButton--neutral {
  background-color: var(--IconButton--neutral-backgroundColor);
  border: none;
  color: var(--IconButton--neutral-color);
}

.defiant-IconButton--neutral:active {
  background-color: var(--IconButton--neutral-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-IconButton--neutral:not([disabled]):hover {
    background-color: var(--IconButton--neutral-onHover-backgroundColor);
  }
}

/* danger */
.defiant-IconButton--danger {
  background-color: transparent;
  border: 2px solid var(--IconButton--danger-borderColor);
  color: var(--IconButton--danger-color);
}

.defiant-IconButton--danger:active {
  background-color: var(--IconButton--danger-onActive-backgroundColor);
}

@media (hover: hover) {
  .defiant-IconButton--danger:hover {
    background-color: var(--IconButton--danger-onHover-backgroundColor);
  }
}
"""
        ]
