module Pages.Views.Card exposing (page)

import Html.Styled as Html exposing (Html, a, p, text)
import Html.Styled.Attributes exposing (name, src, type_)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI.Card as Card exposing (card, cards, extraContent)
import UI.Example exposing (wireframeParagraph)
import UI.Icon exposing (icon)
import UI.Image exposing (image)
import View.ConfigAndPreview exposing (configAndPreview)


page : Shared.Model -> Request -> Page
page shared _ =
    Page.static
        { view =
            { title = "Card"
            , body = view { shared = shared }
            }
        }


type alias Model =
    { shared : Shared.Model }


view : Model -> List (Html msg)
view { shared } =
    let
        options =
            { theme = shared.theme }
    in
    [ configAndPreview { title = "Card" }
        (card options
            []
            [ image [ src "/static/images/avatar/kristy.png" ] []
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
        )
        []
    , configAndPreview { title = "Cards" }
        (cards [] <|
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
                  , imageUrl = "/static/images/avatar/matthew.png"
                  }
                , { name = "Molly"
                  , type_ = "Coworker"
                  , description_ = "Molly is a personal assistant living in Paris."
                  , friends = 35
                  , imageUrl = "/static/images/avatar/molly.png"
                  }
                , { name = "Elyse"
                  , type_ = "Coworker"
                  , description_ = "Elyse is a copywriter working in New York."
                  , friends = 151
                  , imageUrl = "/static/images/avatar/elyse.png"
                  }
                ]
        )
        []
    , configAndPreview { title = "Header" }
        (cards [] <|
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
        )
        []
    , configAndPreview { title = "Metadata" }
        (card options
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
        )
        []
    , configAndPreview { title = "Description" }
        (card options
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
        )
        []
    , configAndPreview { title = "Extra Content" }
        (card options
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
        )
        []
    ]
