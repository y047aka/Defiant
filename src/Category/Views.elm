module Category.Views exposing
    ( Architecture, architecture
    , Model, Msg
    )

{-|

@docs Architecture, architecture
@docs Model, Msg

-}

import Data.Page exposing (Page(..))
import Html.Styled as Html exposing (Html, a, p, span, text)
import Html.Styled.Attributes exposing (name, src, type_)
import Shared exposing (Shared)
import UI.Card as Card exposing (card, cards, extraContent)
import UI.Example exposing (..)
import UI.Icon exposing (icon)
import UI.Image exposing (image, smallImage, tinyImage)
import UI.Item as Item exposing (..)


type alias Architecture =
    { init : Shared -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view : Model -> List (Html Msg)
    }


architecture : Page -> Architecture
architecture page =
    { init = init
    , update = update
    , view = view page
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


view : Page -> Model -> List (Html Msg)
view page =
    case page of
        Card ->
            \{ shared } -> examplesForCard { inverted = shared.darkMode }

        Item ->
            \_ -> examplesForItem

        _ ->
            \_ -> []


examplesForCard : { inverted : Bool } -> List (Html msg)
examplesForCard options =
    [ example
        { title = "Card"
        , description = "A single card."
        }
        [ card options
            []
            [ image [ src "./static/images/avatar/kristy.png" ] []
            , Card.content options
                []
                { header = [ text "Kristy" ]
                , meta = [ text "Joined in 2013" ]
                , description = [ text "Kristy is an art director living in New York." ]
                }
            , extraContent options
                []
                [ icon [] "fas fa-user"
                , text "22 Friends"
                ]
            ]
        ]
    , example
        { title = "Cards"
        , description = "A group of cards."
        }
        [ cards [] <|
            List.map
                (\{ name, type_, description_, friends, imageUrl } ->
                    card options
                        []
                        [ image [ src imageUrl ] []
                        , Card.content options
                            []
                            { header = [ text name ]
                            , meta = [ text type_ ]
                            , description = [ text description_ ]
                            }
                        , extraContent options
                            []
                            [ icon [] "fas fa-user"
                            , text (String.fromInt friends ++ " Friends")
                            ]
                        ]
                )
                [ { name = "Matt Giampietro"
                  , type_ = "Friends"
                  , description_ = "Matthew is an interior designer living in New York."
                  , friends = 75
                  , imageUrl = "./static/images/avatar/matthew.png"
                  }
                , { name = "Molly"
                  , type_ = "Coworker"
                  , description_ = "Molly is a personal assistant living in Paris."
                  , friends = 35
                  , imageUrl = "./static/images/avatar/molly.png"
                  }
                , { name = "Elyse"
                  , type_ = "Coworker"
                  , description_ = "Elyse is a copywriter working in New York."
                  , friends = 151
                  , imageUrl = "./static/images/avatar/elyse.png"
                  }
                ]
        ]
    , example
        { title = "Header"
        , description = "A card can contain a header"
        }
        [ cards [] <|
            List.map
                (\person ->
                    card options
                        []
                        [ Card.content options
                            []
                            { header = [ text person.name ]
                            , meta = [ text person.type_ ]
                            , description = [ text person.description ]
                            }
                        ]
                )
                [ { name = "Elliot Fu"
                  , type_ = "Friend"
                  , description = "Elliot Fu is a film-maker from New York."
                  }
                , { name = "Veronika Ossi"
                  , type_ = "Friend"
                  , description = "Veronika Ossi is a set designer living in New York who enjoys kittens, music, and partying."
                  }
                , { name = "Jenny Hess"
                  , type_ = "Friend"
                  , description = "Jenny is a student studying Media Management at the New School"
                  }
                ]
        ]
    , example
        { title = "Metadata"
        , description = "A card can contain content metadata"
        }
        [ card options
            []
            [ Card.content options
                []
                { header = [ text "Cute Dog" ]
                , meta =
                    [ text "2 days ago "
                    , a [] [ text "Animals" ]
                    ]
                , description = [ wireframeParagraph ]
                }
            ]
        ]
    , example
        { title = "Description"
        , description = "A card can contain a description with one or more paragraphs"
        }
        [ card options
            []
            [ Card.content options
                []
                { header = [ text "Cute Dog" ]
                , meta = [ text "2 days ago " ]
                , description =
                    [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                    , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                    ]
                }
            ]
        ]
    , example
        { title = "Extra Content"
        , description = "A card can contain extra content meant to be formatted separately from the main content"
        }
        [ card options
            []
            [ Card.content options
                []
                { header = [ text "Cute Dog" ]
                , meta = [ text "2 days ago " ]
                , description =
                    [ p [] [ text "Cute dogs come in a variety of shapes and sizes. Some cute dogs are cute for their adorable faces, others for their tiny stature, and even others for their massive size." ]
                    , p [] [ text "Many people also have their own barometers for what makes a cute dog." ]
                    ]
                }
            , extraContent options
                []
                [ icon [] "fas fa-check"
                , text "121 Votes"
                ]
            ]
        ]
    ]


examplesForItem : List (Html msg)
examplesForItem =
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
