module ApiReference exposing (PropReference, table)

import Css exposing (..)
import Css.Global exposing (children)
import Html.Styled as Html exposing (Html, tbody, td, text, th, thead, tr)
import Html.Styled.Attributes exposing (css)


type alias PropReference =
    { prop : String
    , type_ : String
    , variants : List String
    , default : String
    }


table : List PropReference -> Html msg
table props =
    Html.table [ css [ width (pct 100), borderCollapse collapse ] ]
        [ thead []
            [ tr
                [ css
                    [ children
                        [ Css.Global.th
                            [ padding2 (px 10) (px 15)
                            , textAlign left
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
                        typeAndVariants =
                            if List.isEmpty variants then
                                type_

                            else
                                type_ ++ " = " ++ String.join " | " variants
                    in
                    tr
                        [ css
                            [ nthChild "2n+1" [ backgroundColor (hsl 0 0 0.95) ]
                            , children
                                [ Css.Global.td
                                    [ padding2 (px 10) (px 15)
                                    , firstChild [ borderRadius4 (px 10) zero zero (px 10) ]
                                    , nthChild "n+2" [ borderLeft3 (px 1) solid (hsl 0 0 0.9) ]
                                    , lastChild [ borderRadius4 zero (px 10) (px 10) zero ]
                                    ]
                                ]
                            ]
                        ]
                        [ td [] [ text prop ]
                        , td [] [ text typeAndVariants ]
                        , td [] [ text default ]
                        ]
                )
                props
            )
        ]
