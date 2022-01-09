module UI.Tab exposing (State(..), tab)

import Css exposing (..)
import Css.Animations as Animations exposing (keyframes)
import Css.Extra exposing (prefixed)
import Css.Global exposing (children, descendants, everything)
import Html.Styled as Html exposing (Attribute, Html)


type State
    = Inactive
    | Active
    | Loading


tabBasis : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
tabBasis { state } =
    Html.styled Html.div <|
        case state of
            Inactive ->
                [ -- .ui.tab
                  display none
                ]

            Active ->
                [ -- .ui.tab.active
                  -- .ui.tab.open
                  display block
                ]

            Loading ->
                [ -- .ui.tab.loading
                  position relative
                , overflow hidden
                , display block
                , minHeight (px 250)

                -- .ui.tab.loading *
                , descendants
                    [ everything
                        [ position relative |> important
                        , left (px -10000) |> important
                        ]
                    ]

                -- .ui.tab.loading:before
                -- .ui.tab.loading.segment:before
                , before
                    [ position absolute
                    , property "content" (qt "")
                    , top (pct 50)
                    , left (pct 50)
                    , margin4 (em -1.25) zero zero (em -1.25)
                    , width (em 2.5)
                    , height (em 2.5)
                    , borderRadius (rem 500)
                    , border3 (em 0.2) solid (rgba 0 0 0 0.1)
                    ]

                -- .ui.tab.loading:after
                -- .ui.tab.loading.segment:after
                , let
                    loader_ =
                        keyframes
                            [ ( 100
                              , [ Animations.property "-webkit-transform" "rotate(360deg)"
                                , Animations.transform [ rotate (deg 360) ]
                                ]
                              )
                            ]
                  in
                  after
                    [ position absolute
                    , property "content" (qt "")
                    , top (pct 50)
                    , left (pct 50)
                    , margin4 (em -1.25) zero zero (em -1.25)
                    , width (em 2.5)
                    , height (em 2.5)

                    -- , prefixed [] "animation" "loader 0.6s infinite linear"
                    , animationName loader_
                    , animationDuration (sec 0.6)
                    , property "animation-timing-function" "linear"
                    , animationIterationCount infinite
                    , border3 (em 0.2) solid (hex "#767676")
                    , borderRadius (rem 500)
                    , prefixed [] "box-shadow" "0 0 0 1px transparent"

                    -- .ui.elastic.loader.loader:before
                    -- .ui.elastic.loading.loading.loading:before
                    -- .ui.elastic.loading.loading.loading .input > i.icon:before
                    -- .ui.elastic.loading.loading.loading > i.icon:before
                    -- .ui.loading.loading.loading.loading:not(.usual):after
                    -- .ui.loading.loading.loading.loading .input > i.icon:after
                    -- .ui.loading.loading.loading.loading > i.icon:after
                    -- .ui.loader.loader.loader:after
                    , borderColor currentColor

                    -- .ui.loading.loading.loading.loading.loading.loading:after
                    -- .ui.loading.loading.loading.loading.loading.loading .input > i.icon:after
                    -- .ui.loading.loading.loading.loading.loading.loading > i.icon:after
                    -- .ui.loader.loader.loader.loader.loader:after
                    , borderLeftColor transparent
                    , borderRightColor transparent

                    -- .ui.loading.loading.loading.loading.loading.loading.loading:not(.double):after
                    -- .ui.loading.loading.loading.loading.loading.loading.loading:not(.double) .input > i.icon:after
                    -- .ui.loading.loading.loading.loading.loading.loading.loading:not(.double) > i.icon:after
                    -- .ui.loader.loader.loader.loader.loader.loader:not(.double):after
                    , borderBottomColor transparent
                    ]
                ]


tab : { state : State } -> List (Attribute msg) -> List (Html msg) -> Html msg
tab options =
    tabBasis options
