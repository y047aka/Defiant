module UI.HolyGrail exposing (holyGrail)

import Css exposing (..)
import Html.Styled as Html exposing (Html, aside, div, footer, header, main_, text)
import Html.Styled.Attributes exposing (css)


holyGrail :
    { header : List (Html msg)
    , main : List (Html msg)
    , aside_left : List (Html msg)
    , aside_right : List (Html msg)
    , footer : List (Html msg)
    }
    -> Html msg
holyGrail options =
    let
        header_ =
            case options.header of
                [] ->
                    text ""

                children ->
                    header
                        [ css
                            [ padding (px 10)
                            , borderBottom3 (px 1) solid (hex "#ccc")
                            ]
                        ]
                        children

        footer_ =
            case options.footer of
                [] ->
                    text ""

                children ->
                    footer
                        [ css
                            [ padding (px 10)
                            , borderTop3 (px 1) solid (hex "#ccc")
                            ]
                        ]
                        children
    in
    div [ css [ displayFlex, flexDirection column ] ]
        [ header_
        , main_
            [ css
                [ flexGrow (int 1)
                , displayFlex
                , flexDirection row
                ]
            ]
            [ aside [ css [ width (pct 25), padding2 (px 15) (px 10) ] ] options.aside_left
            , div [ css [ flexGrow (int 1), padding2 (px 15) zero ] ] options.main
            , aside [ css [ width (pct 25), padding2 (px 15) (px 10) ] ] options.aside_right
            ]
        , footer_
        ]
