module Page.Views.Item exposing (Model, Msg, architecture)

import Html.Styled as Html exposing (Html, p, span, text)
import Html.Styled.Attributes exposing (src)
import Shared exposing (Shared)
import UI.Example exposing (example, wireframeShortParagraph)
import UI.Icon exposing (icon)
import UI.Image exposing (image, smallImage, tinyImage)
import UI.Item as Item exposing (..)


architecture :
    { init : Shared -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }
architecture =
    { init = init
    , update = update
    , view = view
    }


type alias Model =
    { shared : Shared }


init : Shared -> ( Model, Cmd Msg )
init shared =
    ( { shared = shared }, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> List (Html msg)
view _ =
    [ example
        { title = "Metadata"
        , description = "An item can contain content metadata"
        }
        [ items [] <|
            List.repeat 2
                (Item.item []
                    [ image [ src "./static/images/wireframe/image.png" ] []
                    , Item.content []
                        { header = [ text "Header" ]
                        , meta = [ span [] [ text "Description" ] ]
                        , description = [ wireframeShortParagraph ]
                        , extra = [ text "Additional Details" ]
                        }
                    ]
                )
        ]
    , example
        { title = "Image"
        , description = "An item can contain an image"
        }
        [ dividedItems [] <|
            List.repeat 3
                (Item.item []
                    [ image [ src "./static/images/wireframe/image.png" ] [] ]
                )
        ]
    , example
        { title = "Content"
        , description = "An item can contain content"
        }
        [ dividedItems [] <|
            List.map
                (\{ content } ->
                    Item.item []
                        [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                        , middleAlignedContent [] [ text content ]
                        ]
                )
                [ { content = "Content A" }
                , { content = "Content B" }
                , { content = "Content C" }
                ]
        ]
    , example
        { title = "Header"
        , description = "An item can contain a header"
        }
        [ items [] <|
            List.map
                (\{ title } ->
                    Item.item []
                        [ tinyImage [ src "./static/images/wireframe/image.png" ] []
                        , middleAlignedContent [] [ Item.header [] [ text title ] ]
                        ]
                )
                [ { title = "12 Years a Slave" }
                , { title = "My Neighbor Totoro" }
                , { title = "Watchmen" }
                ]
        ]
    , example
        { title = "Metadata"
        , description = "An item can contain content metadata"
        }
        [ items [] <|
            List.map
                (\plan ->
                    Item.item []
                        [ smallImage [ src "./static/images/wireframe/image.png" ] []
                        , Item.content []
                            { header = [ text plan.title ]
                            , meta =
                                [ span [] [ text plan.price ]
                                , span [] [ text plan.stay ]
                                ]
                            , description = [ wireframeShortParagraph ]
                            , extra = []
                            }
                        ]
                )
                [ { title = "Arrowhead Valley Camp"
                  , price = "$1200"
                  , stay = "1 Month"
                  }
                , { title = "Buck's Homebrew Stayaway"
                  , price = "$1000"
                  , stay = "2 Weeks"
                  }
                , { title = "Astrology Camp"
                  , price = "$1600"
                  , stay = "6 Weeks"
                  }
                ]
        ]
    , example
        { title = "Description"
        , description = "An item can contain a description with a single or multiple paragraphs"
        }
        [ items []
            [ Item.item []
                [ smallImage [ src "./static/images/wireframe/image.png" ] []
                , Item.content []
                    { header = [ text "Cute Dog" ]
                    , meta = []
                    , description =
                        [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                        , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                        ]
                    , extra = []
                    }
                ]
            ]
        ]
    , example
        { title = "Extra Content"
        , description = "An item can contain extra content meant to be formatted separately from the main content"
        }
        [ items []
            [ Item.item []
                [ Item.content []
                    { header = [ text "Cute Dog" ]
                    , meta = []
                    , description =
                        [ wireframeShortParagraph
                        , wireframeShortParagraph
                        ]
                    , extra =
                        [ icon [] "fas fa-check"
                        , text "121 Votes"
                        ]
                    }
                ]
            ]
        ]
    ]
