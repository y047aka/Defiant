module UI.TextLink exposing (textLink)

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
    "defiant-TextLink"


textLink : Props msg -> List (Html msg) -> Html msg
textLink { variant, icon, iconPosition, underline } children =
    button
        [ classList
            [ ( blockName, True )
            , ( blockName ++ "--" ++ Maybe.Extra.unwrap "" variantToString variant, True )
            , ( blockName ++ "--hasIcon", icon /= noHtml )
            , ( blockName ++ "--icon" ++ Maybe.Extra.unwrap "" iconPositionToString iconPosition, icon /= noHtml && isJust iconPosition )
            , ( blockName ++ "--underline" ++ Maybe.Extra.unwrap "" underLineToString underline, isJust underline )
            ]
        ]
        (textLinkStyle
            :: (if icon /= noHtml then
                    span [ class (blockName ++ "-icon") ] [ icon ]
                        :: children

                else
                    children
               )
        )


textLinkStyle : Html msg
textLinkStyle =
    node "style"
        []
        [ text """
/*
 * TextLink
 * NOTE: Styles can be overridden with "--TextLink-*" variables
*/
:root {
  --TextLink-tapHighlightColor: var(--white-60-alpha);
  --TextLink-onFocus-outlineColor: var(--color-focus-clarity);
  --TextLink-color: var(--color-text-accent-primary);
  --TextLink-icon-color: var(--color-object-accent-primary);
  --TextLink-fontWeight: bold;

  --TextLink--subtle-color: var(--color-text-low-emphasis);
  --TextLink--subtle-icon-color: var(--color-object-low-emphasis);
}

.spui-TextLink {
  border-radius: 4px;
  color: var(--TextLink-color);
  font-family: inherit;
  font-weight: var(--TextLink-fontWeight);
  line-height: 1.3;
  -webkit-tap-highlight-color: var(--TextLink-tapHighlightColor);
}

.spui-TextLink:focus {
  outline: 2px solid var(--TextLink-onFocus-outlineColor);
  outline-offset: 1px;
}

.spui-TextLink:focus:not(:focus-visible) {
  outline: none;
}

/*
 * Variant
*/
.spui-TextLink--subtle {
  color: var(--TextLink--subtle-color);
}

/*
 * Icon
*/
.spui-TextLink--hasIcon {
  align-items: center;
  display: inline-flex;
}

.spui-TextLink-icon {
  line-height: 0;
}

.spui-TextLink--iconstart .spui-TextLink-icon {
  margin-right: 4px;
}

.spui-TextLink--iconend {
  flex-direction: row-reverse;
}

.spui-TextLink--iconend .spui-TextLink-icon {
  margin-left: 4px;
}

/*
 * Underline management
*/
.spui-TextLink {
  text-decoration: underline;
}

.spui-TextLink--hasIcon,
.spui-TextLink--underlinehover {
  text-decoration: none;
}

@media (hover: hover) {
  .spui-TextLink:hover {
    text-decoration: none;
  }

  :is(.spui-TextLink--hasIcon, .spui-TextLink--underlinehover):hover {
    text-decoration: underline;
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
