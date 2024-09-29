module ApiReference exposing (PropReference, table)

import Css exposing (..)
import Css.Global exposing (children)
import Html.Styled as Html exposing (Html, div, span, tbody, td, text, th, thead, tr)
import Html.Styled.Attributes exposing (css)


type alias PropReference =
    { prop : String
    , type_ : String
    , variants : List String
    , default : String
    }


table : List PropReference -> Html msg
table props =
    div [ css [ borderRadius (px 10), border3 (px 1) solid (hsl 0 0 0.9) ] ]
        [ Html.table [ css [ width (pct 100), borderCollapse collapse ] ]
            [ thead []
                [ tr
                    [ css
                        [ children
                            [ Css.Global.th
                                [ padding (px 15)
                                , textAlign left
                                , backgroundColor (hsla 160 0 0.5 0.05)
                                , nthChild "n+2" [ borderLeft3 (px 1) solid (hsl 0 0 0.9) ]
                                ]
                            ]
                        ]
                    ]
                    [ th [] [ text "Prop" ]
                    , th [] [ text "Type" ]
                    , th [] [ text "Default" ]
                    ]
                ]
            , tbody []
                (List.map
                    (\{ prop, type_, variants, default } ->
                        let
                            variants_ =
                                if List.isEmpty variants then
                                    []

                                else
                                    [ text " = ", greyLabel [ text (String.join " | " variants) ] ]
                        in
                        tr
                            [ css
                                [ borderTop3 (px 1) solid (hsl 0 0 0.9)
                                , children
                                    [ Css.Global.td
                                        [ padding (px 15)
                                        , nthChild "n+2" [ borderLeft3 (px 1) solid (hsl 0 0 0.9) ]
                                        ]
                                    ]
                                ]
                            ]
                            [ td [] [ label [ text prop ] ]
                            , td []
                                (greyLabel [ text type_ ]
                                    :: variants_
                                )
                            , td []
                                [ if default == "-" then
                                    text default

                                  else
                                    greyLabel [ text default ]
                                ]
                            ]
                    )
                    props
                )
            ]
        ]


label : List (Html msg) -> Html msg
label children =
    span
        [ css
            [ padding2 (px 2) (px 5)
            , borderRadius (px 5)
            , backgroundColor (hsla 120 1 0.5 0.05)
            , color (hsl 120 1 0.3)
            , border3 (px 1) solid (hsla 120 1 0.25 0.15)
            ]
        ]
        children


greyLabel : List (Html msg) -> Html msg
greyLabel children =
    span
        [ css
            [ padding2 (px 2) (px 5)
            , borderRadius (px 5)
            , backgroundColor (hsla 0 0 0.5 0.05)
            , color (hsl 0 0 0.4)
            , border3 (px 1) solid (hsla 0 0 0.25 0.15)
            ]
        ]
        children
