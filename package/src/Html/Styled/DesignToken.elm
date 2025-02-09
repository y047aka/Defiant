module Html.Styled.DesignToken exposing
    ( h1, h2, h3, h4, h5, h6
    , section, nav, article, aside
    )

{-|


# Tags


## Headers

@docs h1, h2, h3, h4, h5, h6


## Sections

@docs section, nav, article, aside, header, footer, address, main_

-}

import Css exposing (Style)
import Html.Styled exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)


type alias HtmlDetails msg =
    DesignToken
    ->
        { tag : List (Attribute msg) -> List (Html msg) -> Html msg
        , attributes : List (Attribute msg)
        , children : List (Html msg)
        }


type alias DesignToken =
    {}


toStyle : DesignToken -> Style
toStyle _ =
    Css.batch []


node : String -> List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
node tagName attributes children =
    \designToken ->
        { tag = Html.Styled.node tagName
        , attributes = css [ toStyle designToken ] :: attributes
        , children =
            children
                |> List.map (\c -> c designToken)
                |> List.map (\c -> c.tag c.attributes c.children)
        }



-- SECTIONS


{-| Defines a section in a document.
-}
section : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
section =
    node "section"


{-| Defines a section that contains only navigation links.
-}
nav : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
nav =
    node "nav"


{-| Defines self-contained content that could exist independently of the rest
of the content.
-}
article : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
article =
    node "article"


{-| Defines some content loosely related to the page content. If it is removed,
the remaining content still makes sense.
-}
aside : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
aside =
    node "aside"


{-| -}
h1 : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
h1 =
    node "h1"


{-| -}
h2 : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
h2 =
    node "h2"


{-| -}
h3 : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
h3 =
    node "h3"


{-| -}
h4 : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
h4 =
    node "h4"


{-| -}
h5 : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
h5 =
    node "h5"


{-| -}
h6 : List (Attribute msg) -> List (HtmlDetails msg) -> HtmlDetails msg
h6 =
    node "h6"
