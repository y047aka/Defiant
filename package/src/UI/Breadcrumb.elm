module UI.Breadcrumb exposing
    ( breadcrumbList
    , breadcrumbItem
    )

{-|

@docs breadcrumbList
@docs breadcrumbItem

-}

import Html.Styled as Html exposing (Attribute, Html, a, li, nav, node, ol, text)
import Html.Styled.Attributes exposing (class, classList)
import Html.Styled.Attributes.Aria exposing (ariaCurrent, ariaHidden, ariaLabel)
import Svg.Styled.Attributes
import UI.Icon.ChevronRight exposing (chevronRight)



----------------------------------------------
-- BreadcrumbList
----------------------------------------------


blockName : String
blockName =
    "defiant-Breadcrumb"


breadcrumbList : List (Attribute msg) -> List (Html msg) -> Html msg
breadcrumbList attributes children =
    nav
        ([ ariaLabel "パンくずリスト"
         , classList
            [ ( blockName, True )
            , ( blockName ++ "--standard", True )
            , ( blockName ++ "--wrap", True )
            ]
         ]
            ++ attributes
        )
        [ breadcrumbStyles
        , ol [ class (blockName ++ "-list") ]
            (List.map
                (\child ->
                    li [ class (blockName ++ "-item") ]
                        [ child
                        , chevronRight
                            [ ariaHidden True
                            , Svg.Styled.Attributes.class (blockName ++ "-chevron")
                            ]
                        ]
                )
                children
            )
        ]


breadcrumbStyles : Html msg
breadcrumbStyles =
    node "style"
        []
        [ text """
.defiant-Breadcrumb {
  overflow: auto hidden;
}

.defiant-Breadcrumb--wrap {
  overflow: hidden;
}

.defiant-Breadcrumb--standard {
  padding: 12px 0;
  position: relative;
}

.defiant-Breadcrumb-list {
  display: flex;
  list-style: none;
  margin: 0;
  width: max-content;
}

.defiant-Breadcrumb--standard .defiant-Breadcrumb-list {
  padding: 0;
}

.defiant-Breadcrumb--emphasized .defiant-Breadcrumb-list {
  background: var(--color-surface-secondary);
  border-radius: 70px;
  padding: 0 16px;
}

.defiant-Breadcrumb--standard.defiant-Breadcrumb--wrap .defiant-Breadcrumb-list {
  flex-wrap: wrap;
  width: 100%;
}

.defiant-Breadcrumb-item {
  align-items: center;
  display: flex;
}

/* stylelint-disable plugin/selector-bem-pattern */
.defiant-Breadcrumb--emphasized .defiant-Breadcrumb-item,
.defiant-Breadcrumb--emphasized a::before {
  min-height: 44px;
}

.defiant-Breadcrumb a {
  align-items: center;
  border-radius: 4px;
  display: flex;
  font-size: 0.875em;
  line-height: 1.4;
  padding: 4px 8px;
  position: relative;
  text-decoration: none;
}

.defiant-Breadcrumb a:not([aria-current]) {
  color: var(--color-text-accent-primary);
  font-weight: bold;
}

.defiant-Breadcrumb a[aria-current] {
  color: var(--color-text-low-emphasis);
  font-weight: normal;
}

/* To expand tap area */
.defiant-Breadcrumb a::before {
  border-radius: 4px;
  content: '';
  left: 0;
  position: absolute;
  top: -50%;
  width: 100%;
}

.defiant-Breadcrumb a:hover {
  text-decoration: underline;
}

.defiant-Breadcrumb a:not([href]):hover {
  text-decoration: none;
}

.defiant-Breadcrumb a:focus {
  outline: 2px solid var(--color-focus-clarity);
  outline-offset: 1px;
}

/* To avoid overflow, standard variant has no padding */
.defiant-Breadcrumb--standard a:focus {
  outline-offset: -2px;
}

.defiant-Breadcrumb a:focus:not(:focus-visible) {
  outline: none;
}
/* stylelint-enable plugin/selector-bem-pattern */

.defiant-Breadcrumb-chevron {
  box-sizing: content-box;
  color: var(--color-object-low-emphasis);
  height: 16px;
  padding: 0 4px;
  width: 16px;
}

.defiant-Breadcrumb-item:last-of-type > .defiant-Breadcrumb-chevron {
  display: none;
  padding: 0;
}

@media screen and (max-width: 768px) {
  .defiant-Breadcrumb-list {
    padding: 0 14px;
  }

  /* stylelint-disable plugin/selector-bem-pattern */
  .defiant-Breadcrumb--emphasized .defiant-Breadcrumb-item,
  .defiant-Breadcrumb--emphasized a::before {
    min-height: 36px;
  }

  .defiant-Breadcrumb a {
    font-size: 0.8125em;
    padding: 2px 6px;
  }

  .defiant-Breadcrumb--standard.defiant-Breadcrumb--wrap a {
    padding-bottom: 4px;
    padding-top: 4px;
  }
  /* stylelint-enable plugin/selector-bem-pattern */

  .defiant-Breadcrumb-chevron {
    height: 12px;
    padding: 0 2px;
    width: 12px;
  }
}
"""
        ]



----------------------------------------------
-- BreadcrumbItem
----------------------------------------------


type alias BreadcrumbItemProps =
    { current : Bool }


breadcrumbItem : BreadcrumbItemProps -> List (Attribute msg) -> List (Html msg) -> Html msg
breadcrumbItem props attributes children =
    if props.current then
        a (ariaCurrent "page" :: attributes)
            children

    else
        a attributes children
