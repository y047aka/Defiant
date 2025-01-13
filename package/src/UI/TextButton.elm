module UI.TextButton exposing (textButton)

import Html.Styled exposing (Html, button, node, span, text)
import Html.Styled.Attributes exposing (class, classList)
import Maybe.Extra exposing (isJust)


type Variant
    = Subtle


type alias Props msg =
    { variant : Maybe Variant
    , icon : Html msg
    , iconPosition : Maybe IconPosition
    , underline : Maybe Underline
    }


type IconPosition
    = Start
    | End


type Underline
    = Hover


blockName : String
blockName =
    "defiant-TextButton"


textButton : Props msg -> List (Html msg) -> Html msg
textButton { variant, icon, iconPosition, underline } children =
    button
        [ classList
            [ ( blockName, True )
            , ( blockName ++ "--" ++ Maybe.Extra.unwrap "" variantToString variant, True )
            , ( blockName ++ "--hasIcon", icon /= noHtml )
            , ( blockName ++ "--icon" ++ Maybe.Extra.unwrap "" iconPositionToString iconPosition, icon /= noHtml && isJust iconPosition )
            , ( blockName ++ "--underline" ++ Maybe.Extra.unwrap "" underLineToString underline, isJust underline )
            ]
        ]
        (textButtonStyle
            :: (if icon /= noHtml then
                    span [ class (blockName ++ "-icon") ] [ icon ]
                        :: children

                else
                    children
               )
        )


textButtonStyle : Html msg
textButtonStyle =
    node "style"
        []
        [ text """
/*
 * TextButton
 * NOTE: Styles can be overridden with "--TextButton-*" variables
*/
:root {
  --TextButton-tapHighlightColor: var(--white-60-alpha);
  --TextButton-onFocus-outlineColor: var(--color-focus-clarity);
  --TextButton-color: var(--color-text-accent-primary);
  --TextButton-icon-color: var(--color-object-accent-primary);
  --TextButton-fontWeight: bold;

  --TextButton--subtle-color: var(--color-text-low-emphasis);
  --TextButton--subtle-icon-color: var(--color-object-low-emphasis);
}

.defiant-TextButton {
  background: none;
  border: none;
  border-radius: 4px;
  color: var(--TextButton-color);
  font-family: inherit;
  font-size: 1em;
  font-weight: var(--TextButton-fontWeight);
  line-height: 1.3;
  margin: 0;
  padding: 0;
  -webkit-tap-highlight-color: var(--TextButton-tapHighlightColor);
}

.defiant-TextButton:disabled {
  opacity: 0.3;
}

.defiant-TextButton:focus {
  outline: 2px solid var(--TextButton-onFocus-outlineColor);
  outline-offset: 1px;
}

.defiant-TextButton:focus:not(:focus-visible) {
  outline: none;
}

/*
 * Variant
*/
.defiant-TextButton--subtle {
  color: var(--TextButton--subtle-color);
}

/*
 * Icon
*/
.defiant-TextButton--hasIcon {
  align-items: center;
  display: inline-flex;
}

.defiant-TextButton-icon {
  line-height: 0;
}

.defiant-TextButton--iconstart .defiant-TextButton-icon {
  margin-right: 4px;
}

.defiant-TextButton--iconend {
  flex-direction: row-reverse;
}

.defiant-TextButton--iconend .defiant-TextButton-icon {
  margin-left: 4px;
}

/*
 * Underline management
*/
.defiant-TextButton {
  text-decoration: underline;
}

.defiant-TextButton--hasIcon,
.defiant-TextButton--underlinehover {
  text-decoration: none;
}

.defiant-TextButton:disabled {
  text-decoration: none;
}

@media (hover: hover) {
  .defiant-TextButton:hover {
    text-decoration: none;
  }

  :is(.defiant-TextButton--hasIcon, .defiant-TextButton--underlinehover):hover {
    text-decoration: underline;
  }

  .defiant-TextButton:disabled:hover {
    text-decoration: none;
  }
}
""" ]



-- HELPERS


variantToString : Variant -> String
variantToString variant =
    case variant of
        Subtle ->
            "subtle"


iconPositionToString : IconPosition -> String
iconPositionToString position =
    case position of
        Start ->
            "start"

        End ->
            "end"


underLineToString : Underline -> String
underLineToString underline_ =
    case underline_ of
        Hover ->
            "hover"


noHtml : Html msg
noHtml =
    text ""
