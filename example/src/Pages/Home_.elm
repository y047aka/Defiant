module Pages.Home_ exposing (page)

import Html
import Html.Attributes exposing (href)
import View exposing (View)


page : View msg
page =
    { title = "Homepage"
    , body = [ Html.a [ href "/text" ] [ Html.text "Text" ] ]
    }
