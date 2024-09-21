module UI.Breadcrumb exposing
    ( breadcrumbList
    , breadcrumbItem
    )

{-|

@docs breadcrumbList
@docs breadcrumbItem

-}

import Html.Styled as Html exposing (Attribute, Html, a, li, nav, ol)
import Html.Styled.Attributes exposing (attribute, class, classList)
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
        ([ attribute "aria-label" "パンくずリスト"
         , classList
            [ ( blockName, True )
            , ( blockName ++ "--standard", True )
            , ( blockName ++ "--wrap", True )
            ]
         ]
            ++ attributes
        )
        [ ol [ class (blockName ++ "-list") ]
            (List.map
                (\child ->
                    li [ class (blockName ++ "-item") ]
                        [ child
                        , chevronRight
                            [ attribute "aria-hidden" "true"
                            , class (blockName ++ "-chevron")
                            ]
                        ]
                )
                children
            )
        ]



----------------------------------------------
-- BreadcrumbItem
----------------------------------------------


type alias BreadcrumbItemProps =
    { current : Bool }


breadcrumbItem : BreadcrumbItemProps -> List (Attribute msg) -> List (Html msg) -> Html msg
breadcrumbItem props attributes children =
    if props.current then
        a (attribute "aria-current" "page" :: attributes)
            children

    else
        a attributes children
