module UI.SnackBar exposing
    ( frame, icon, text, textButton, textLink
    , Position(..), Props, Variant(..)
    )

{-|

@docs frame, icon, text, textButton, textLink

-}

import Html.Styled as Html exposing (Html, div, node, span)
import Html.Styled.Attributes exposing (class, classList)
import Html.Styled.Attributes.Aria exposing (ariaHidden, ariaLabel)
import UI.Icon exposing (crossBold)
import UI.IconButton as IconButton exposing (iconButton)
import UI.TextButton as TextButton
import UI.TextLink as TextLink


type Variant
    = Information
    | Confirmation
    | Error


type alias Props =
    { active : Bool
    , position : Position
    , duration : Int -- milliseconds to hide
    , variant : Variant
    }


type Position
    = TopLeft
    | TopCenter
    | TopRight
    | BottomLeft
    | BottomCenter
    | BottomRight


blockName : String
blockName =
    "defiant-SnackBar"


displayingTimeoutDuration : Int
displayingTimeoutDuration =
    let
        -- Duration for css animation.
        animationDuration =
            300

        maxDuration =
            10000
    in
    maxDuration - animationDuration


defaultVariant : Variant
defaultVariant =
    Information


type alias InternalChildProps msg =
    { setIsShow : Bool
    , variant : Variant

    --
    , icon : Html msg
    }


frame : Props -> List (Html msg) -> Html msg
frame { active, position, variant } children =
    div
        [ classList
            [ ( blockName, True )
            , ( blockName ++ "--" ++ positionToString_vertical position, True )
            , ( blockName ++ "--slide", True )
            , ( blockName ++ "-slide--in", True )
            , ( blockName ++ "--hidden", not active )
            ]
        , ariaHidden active
        ]
        [ snockBarStyle
        , div
            [ classList
                [ ( blockName ++ "-content", True )
                , ( blockName ++ "-content--" ++ variantToString variant, True )
                ]
            ]
            (children
                ++ [ div
                        [ classList
                            [ ( blockName ++ "-iconButton", True )
                            , ( blockName ++ "-iconButton--" ++ variantToString variant, True )
                            ]
                        ]
                        [ iconButton { size = IconButton.ExSmall, variant = IconButton.Neutral }
                            []
                            [ crossBold [ ariaLabel "閉じる" ] ]
                        ]
                   ]
            )
        ]


icon : List (Html msg) -> Html msg
icon children =
    div [ class (blockName ++ "-icon") ] children


text : List (Html msg) -> Html msg
text children =
    span [ class (blockName ++ "-text") ] children


textButton : InternalChildProps msg -> List (Html msg) -> Html msg
textButton ({ variant } as props) children =
    div
        [ classList
            [ ( blockName ++ "-button", True )
            , ( blockName ++ "-button--" ++ variantToString variant, True )
            ]
        ]
        [ TextButton.textButton
            { variant = Nothing
            , icon = props.icon
            , iconPosition = Nothing
            , underline = Nothing
            }
            children
        ]


textLink : InternalChildProps msg -> List (Html msg) -> Html msg
textLink ({ variant } as props) children =
    div
        [ classList
            [ ( blockName ++ "-button", True )
            , ( blockName ++ "-button--" ++ variantToString variant, True )
            ]
        ]
        [ TextLink.textLink
            { variant = Nothing
            , icon = props.icon
            , iconPosition = Nothing
            , underline = Nothing
            }
            children
        ]


snockBarStyle : Html msg
snockBarStyle =
    node "style"
        []
        [ Html.text """
:root {
  --SnackBar-z-index: 1;
  --SnackBar-onFocus-outlineColor: var(--color-focus-clarity);
}

.defiant-SnackBar {
  box-sizing: border-box;
  left: 0;
  opacity: 0;
  padding: 0 var(--SnackBar--offset-right) 0 var(--SnackBar--offset-left);
  pointer-events: none;
  position: fixed;
  right: 0;
  text-align: var(--SnackBar--text-align);
  z-index: var(--SnackBar-z-index);
}

.defiant-SnackBar-content {
  align-items: center;
  border-radius: 16px;
  box-shadow: 0px 11px 28px rgba(8, 18, 26, 0.24);
  box-sizing: border-box;
  display: inline-grid;
  grid-template: 'Icon Text Button IconButton' auto / auto 1fr auto auto;
  max-width: 440px;
  min-height: 52px;
  min-width: 360px;
  padding: 14px 16px 14px 20px;
  pointer-events: auto;
}

.defiant-SnackBar-icon {
  flex-shrink: 0;
  font-size: 1.375rem;
  grid-area: Icon;
  line-height: 0;
  margin-right: 12px;
}

.defiant-SnackBar-text {
  --SnackBar-max-lines: 3;

  font-family: inherit;
  font-size: 0.875rem;
  font-weight: bold;
  grid-area: Text;
  line-height: 1.6;
  max-height: calc(1em * 1.6 * var(--SnackBar-max-lines));
  overflow: hidden;
  text-align: left;
}

.defiant-SnackBar-button {
  font-size: 0.875rem;
  grid-area: Button;
  margin-left: 16px;
  margin-right: 13px; /* margin for border + border width */
  position: relative;
}

.defiant-SnackBar-button::after {
  bottom: 0;
  content: '';
  display: inline-block;
  position: absolute;
  right: -12px;
  top: 0;
  width: 1px;
}

.defiant-SnackBar--top {
  top: 0;
  transform: translateY(
    calc(var(--SnackBar--initial-height-top) - var(--SnackBar--offset-top))
  );
}

.defiant-SnackBar--bottom {
  bottom: 0;
  transform: translateY(
    calc(
      (var(--SnackBar--initial-height-bottom) - var(--SnackBar--offset-bottom)) *
        -1
    )
  );
}

.defiant-SnackBar--slide {
  transition:
    transform 0.3s ease,
    opacity 0.3s ease;
}

.defiant-SnackBar--hidden {
  visibility: hidden;
}

.defiant-SnackBar-slide--in {
  opacity: 1;
  transition:
    transform 0.5s ease,
    opacity 0.5s ease;
}

.defiant-SnackBar-slide--in.defiant-SnackBar--top {
  transform: translateY(var(--SnackBar--order-offset-top));
}

.defiant-SnackBar-slide--in.defiant-SnackBar--bottom {
  transform: translateY(var(--SnackBar--order-offset-bottom));
}

.defiant-SnackBar-iconButton {
  /* stylelint-disable-next-line plugin/selector-bem-pattern */
  --IconButton--neutral-backgroundColor: transparent;
  grid-area: IconButton;
  margin-left: 12px;
}

/* === Information === */

.defiant-SnackBar-content--information {
  /* TODO: use --color-surface-accent-neutral-high-emphasis */
  background-color: var(--gray-80);
  color: var(--color-text-high-emphasis-inverse);
}

.defiant-SnackBar-iconButton--information {
  /* stylelint-disable plugin/selector-bem-pattern */
  --IconButton--neutral-onActive-backgroundColor: var(--white-20-alpha);
  --IconButton--neutral-onHover-backgroundColor: var(--white-20-alpha);
  --IconButton--neutral-color: var(--color-object-high-emphasis-inverse);
  /* stylelint-enable plugin/selector-bem-pattern */
}

.defiant-SnackBar-button--information {
  /* stylelint-disable plugin/selector-bem-pattern */
  --TextLink-color: var(--color-text-high-emphasis-inverse);
  --TextLink-icon-color: var(--color-object-high-emphasis-inverse);
  --TextButton-color: var(--color-text-high-emphasis-inverse);
  --TextButton-icon-color: var(--color-object-high-emphasis-inverse);
  /* stylelint-enable plugin/selector-bem-pattern */
}

.defiant-SnackBar-button--information::after {
  /* TODO: use --color-border-low-emphasis-inverse */
  background: var(--white-20-alpha);
}

/* === Confirmation === */

.defiant-SnackBar-content--confirmation {
  background-color: var(--color-surface-primary);
  border: 2px solid var(--color-border-low-emphasis);
  color: var(--color-text-accent-primary);
}

.defiant-SnackBar-iconButton--confirmation {
  /* stylelint-disable plugin/selector-bem-pattern */
  --IconButton--neutral-onActive-backgroundColor: var(--gray-20-alpha);
  --IconButton--neutral-onHover-backgroundColor: var(--gray-20-alpha);
  --IconButton--neutral-color: var(--color-object-low-emphasis);
  /* stylelint-enable plugin/selector-bem-pattern */
}

.defiant-SnackBar-button--confirmation {
  /* stylelint-disable plugin/selector-bem-pattern */
  --TextLink-color: var(--color-text-low-emphasis);
  --TextLink-icon-color: var(--color-object-low-emphasis);
  --TextButton-color: var(--color-text-low-emphasis);
  --TextButton-icon-color: var(--color-object-low-emphasis);
  /* stylelint-enable plugin/selector-bem-pattern */
}

.defiant-SnackBar-button--confirmation::after {
  background: var(--color-border-low-emphasis);
}

/* === Error === */

.defiant-SnackBar-content--error {
  background-color: var(--color-surface-caution);
  color: var(--color-text-high-emphasis-inverse);
}

.defiant-SnackBar-iconButton--error {
  /* stylelint-disable plugin/selector-bem-pattern */
  --IconButton--neutral-onActive-backgroundColor: var(--white-20-alpha);
  --IconButton--neutral-onHover-backgroundColor: var(--white-20-alpha);
  --IconButton--neutral-color: var(--color-object-high-emphasis-inverse);
  /* stylelint-enable plugin/selector-bem-pattern */
}

.defiant-SnackBar-button--error {
  /* stylelint-disable plugin/selector-bem-pattern */
  --TextLink-color: var(--color-text-high-emphasis-inverse);
  --TextLink-icon-color: var(--color-object-high-emphasis-inverse);
  --TextButton-color: var(--color-text-high-emphasis-inverse);
  --TextButton-icon-color: var(--color-object-high-emphasis-inverse);
  /* stylelint-enable plugin/selector-bem-pattern */
}

.defiant-SnackBar-button--error::after {
  /* TODO: use --color-border-low-emphasis-inverse */
  background: var(--white-20-alpha);
}

@media (prefers-reduced-motion: reduce) {
  .defiant-SnackBar--slide {
    transition-duration: 0.1ms;
  }

  .defiant-SnackBar-slide--in {
    transition-duration: 0.1ms;
  }
}

/* `max-width` for the SnackBar is set to 440px and horizontal margin is 12px on the desktop. */
/* Therefore, breakpoint is 464px that is the sum of the max-width and horizontal margin. */
@media (max-width: 464px) {
  .defiant-SnackBar {
    padding: 0 12px;
    text-align: center;

    /* On mobile device, the snack bar position is fixed at the bottom */
    /* stylelint-disable-next-line order/properties-alphabetical-order */
    bottom: 0;
    top: unset;
    transform: translateY(
      calc(
        (
            var(--SnackBar--initial-height-bottom) -
              var(--SnackBar--offset-bottom)
          ) * -1
      )
    );
  }

  .defiant-SnackBar-slide--in.defiant-SnackBar--top {
    transform: translateY(var(--SnackBar--order-offset-bottom));
  }

  .defiant-SnackBar-content {
    border-radius: 82px;
    max-width: 400px;
    min-width: calc(100% - 24px);
    padding: 14px 16px 14px 20px;
  }
}

@media (max-width: 320px) {
  .defiant-SnackBar-text {
    --SnackBar-max-lines: 4;
  }
}
""" ]



-- HELPERS


variantToString : Variant -> String
variantToString variant =
    case variant of
        Information ->
            "information"

        Confirmation ->
            "confirmation"

        Error ->
            "error"


positionToString_vertical : Position -> String
positionToString_vertical position =
    case position of
        TopLeft ->
            "top"

        TopCenter ->
            "top"

        TopRight ->
            "top"

        BottomLeft ->
            "bottom"

        BottomCenter ->
            "bottom"

        BottomRight ->
            "bottom"
