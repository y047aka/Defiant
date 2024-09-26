module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import BackendTask.Glob as Glob
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html.Styled as Html exposing (Attribute, Html, a, h1, li, text, ul)
import Html.Styled.Attributes as Attributes
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route exposing (Route)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import String.Extra
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }



-- DATA


type alias Data =
    List ( Route, ArticleMetadata )


data : BackendTask FatalError Data
data =
    allMetadata


type alias File =
    { filePath : String
    , name : String
    }


componentPagesGlob : BackendTask FatalError (List File)
componentPagesGlob =
    Glob.succeed File
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "app/Route/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".elm")
        |> Glob.toBackendTask


allMetadata : BackendTask FatalError (List ( Route, ArticleMetadata ))
allMetadata =
    componentPagesGlob
        |> BackendTask.map
            (List.filterMap
                (\{ name } ->
                    Route.segmentsToRoute [ String.Extra.dasherize name |> String.dropLeft 1 ]
                        |> Maybe.map (\route_ -> ( route_, { title = name, slug = name } ))
                )
            )


type alias ArticleMetadata =
    { title : String
    , slug : String
    }


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = [ "images", "icon-png.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Welcome to elm-pages!"
        , locale = Nothing
        , title = "elm-pages is running"
        }
        |> Seo.website



-- VIEW


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "elm-pages is running"
    , body =
        [ h1 [] [ text "elm-pages is up and running!" ]
        , ul []
            (List.map
                (\( route_, page ) ->
                    li [] [ link route_ [] [ text page.title ] ]
                )
                app.data
            )
        ]
    }


link : Route -> List (Attribute msg) -> List (Html msg) -> Html msg
link route_ attrs children =
    Route.toLink
        (\anchorAttrs ->
            a
                (List.map Attributes.fromUnstyled anchorAttrs ++ attrs)
                children
        )
        route_
