module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import BackendTask exposing (BackendTask)
import Css exposing (..)
import Css.Extra exposing (marginInline)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Styled exposing (header, main_, node, text)
import Html.Styled.Attributes exposing (css, href)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import UI.Breadcrumb as Breadcrumb
import UrlPath exposing (UrlPath)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Nothing
    }



-- MODEL


type alias Model =
    {}


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( {}, Effect.none )



-- UPDATE


type Msg
    = SharedMsg SharedMsg


type SharedMsg
    = NoOp


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SharedMsg globalMsg ->
            ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none



-- DATA


type alias Data =
    ()


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()



-- VIEW


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view sharedData page model toMsg pageView =
    { body =
        List.map Html.Styled.toUnstyled
            [ defiantColorPaletteStyle
            , header []
                [ Breadcrumb.breadcrumbList []
                    [ Breadcrumb.breadcrumbItem { current = False } [ href "/" ] [ text "Top" ]
                    , Breadcrumb.breadcrumbItem { current = False } [ href "#" ] [ text "UI" ]
                    , Breadcrumb.breadcrumbItem { current = True } [ href "#" ] [ text pageView.title ]
                    ]
                ]
            , main_
                [ css
                    [ maxWidth (em 60)
                    , marginInline auto
                    , displayFlex
                    , flexDirection column
                    , property "row-gap" "3em"
                    ]
                ]
                pageView.body
            ]
    , title = pageView.title
    }


defiantColorPaletteStyle : Html.Styled.Html msg
defiantColorPaletteStyle =
    node "style"
        []
        [ text """
/* custom properties https://www.w3.org/TR/css-variables/ */
:root {
  /**
   * Ameba Color Palette from Spindle (Design System)
   */

  /**
   * Swatch Colors
   */

  /* Brand Colors */
  --ameba-green: #2d8c3c;
  --ameba-black: #000;
  --ameba-yellow-green: #82be28;
  --ameba-neutral-gray: #f6f6f6;
  --ameba-white: #fff;
  --ameba-yellow: #f5e100;

  /* Base Colors */
  --primary-green-100: #0f5c1f;
  --primary-green-90: #186b27;
  --primary-green-80: #237b31;
  --primary-green-70: #298737;
  --primary-green-60: #389e46;
  --primary-green-50: #41ad4f;
  --primary-green-40: #5eb969;
  --primary-green-30: #7bc583;
  --primary-green-20: #a1d5a7;
  --primary-green-10: #c6e5c9;
  --primary-green-5: #e7f5e9;
  --secondary-green-100: #366600;
  --secondary-green-90: #427504;
  --secondary-green-80: #477d00;
  --secondary-green-70: #5e9b15;
  --secondary-green-60: #73ae20;
  --secondary-green-50: #82be28;
  --secondary-green-40: #95c84d;
  --secondary-green-30: #a9d16f;
  --secondary-green-20: #c2de99;
  --secondary-green-10: #daebc1;
  --secondary-green-5: #f0f7e6;
  --gray-100: #08121a;
  --gray-90-alpha: rgba(8, 18, 26, 0.95);
  --gray-80-alpha: rgba(8, 18, 26, 0.8);
  --gray-70-alpha: rgba(8, 18, 26, 0.74);
  --gray-60-alpha: rgba(8, 18, 26, 0.61);
  --gray-50-alpha: rgba(8, 18, 26, 0.47);
  --gray-40-alpha: rgba(8, 18, 26, 0.4);
  --gray-30-alpha: rgba(8, 18, 26, 0.3);
  --gray-20-alpha: rgba(8, 18, 26, 0.16);
  --gray-10-alpha: rgba(8, 18, 26, 0.08);
  --gray-5-alpha: rgba(8, 18, 26, 0.04);
  --gray-90: #141e25;
  --gray-80: #394148;
  --gray-70: #464d53;
  --gray-60: #686e73;
  --gray-50: #8b9093;
  --gray-40: #9ca0a3;
  --gray-30: #b5b8ba;
  --gray-20: #d8d9da;
  --gray-10: #ebeced;
  --gray-5: #f5f6f6;
  --white-100: #fff;
  --white-90-alpha: rgba(255, 255, 255, 0.9);
  --white-80-alpha: rgba(255, 255, 255, 0.8);
  --white-70-alpha: rgba(255, 255, 255, 0.7);
  --white-60-alpha: rgba(255, 255, 255, 0.6);
  --white-50-alpha: rgba(255, 255, 255, 0.5);
  --white-40-alpha: rgba(255, 255, 255, 0.43);
  --white-30-alpha: rgba(255, 255, 255, 0.3);
  --white-20-alpha: rgba(255, 255, 255, 0.16);
  --white-10-alpha: rgba(255, 255, 255, 0.1);
  --white-5-alpha: rgba(255, 255, 255, 0.05);
  --black-100: #000;
  --black-90-alpha: rgba(0, 0, 0, 0.9);
  --black-80-alpha: rgba(0, 0, 0, 0.8);
  --black-70-alpha: rgba(0, 0, 0, 0.7);
  --black-60-alpha: rgba(0, 0, 0, 0.6);
  --black-50-alpha: rgba(0, 0, 0, 0.5);
  --black-40-alpha: rgba(0, 0, 0, 0.4);
  --black-30-alpha: rgba(0, 0, 0, 0.3);
  --black-20-alpha: rgba(0, 0, 0, 0.2);
  --black-10-alpha: rgba(0, 0, 0, 0.1);
  --black-5-alpha: rgba(0, 0, 0, 0.05);
  --caution-red-100: #d91c0b;
  --caution-red-20-alpha: rgba(217, 28, 11, 0.2);
  --caution-red-5-alpha: rgba(217, 28, 11, 0.05);
  --caution-red-vivid-100: #ff6a59;
  --caution-red-vivid-20-alpha: rgba(255, 106, 89, 0.2);
  --caution-red-vivid-5-alpha: rgba(255, 106, 89, 0.05);

  /* Expressive Colors */
  --expressive-blue: #4795c8;
  --expressive-green: #4ac3aa;
  --expressive-purple: #ca5ce6;
  --expressive-lavender: #755ce6;
  --expressive-orange: #e6815c;
  --expressive-yellow: #e6ac5c;
  --expressive-pink: #e6456a;

  /* Third Party Colors */
  --facebook-blue: #1877f2;
  --facebook-white: #fff;
  --twitter-blue: #1da1f2;
  --twitter-white: #fff;
  --x-black: #000;
  --x-white: #fff;
  --instagram-pink: #f20076;
  --apple-black: #000;
  --apple-white: #fff;
  --youtube-red: #f00;
  --youtube-white: #fff;
  --amazon-yellow: #f90;
  --amazon-black: #000;
  --rakuten-red: #bf0000;
  --rakuten-white: #fff;
  --yahoo-red: #f03;
  --yahoo-white: #fff;

  /* System Colors */
  --focus-blue-100: #0091ff;
  --focus-blue-30-alpha: rgba(0, 145, 255, 0.3);
  --highlight-yellow-100: #f5e100;
  --highlight-yellow-30-alpha: rgba(245, 225, 0, 0.3);

  /**
   * Ameba Theme
   */

  /* Background Colors */
  --color-background: var(--gray-5);

  /* Surface Colors */
  --color-surface-primary: var(--white-100);
  --color-surface-secondary: var(--gray-5-alpha);
  --color-surface-tertiary: var(--gray-10-alpha);
  --color-surface-quaternary: var(--gray-20-alpha);
  --color-surface-accent-primary: var(--primary-green-70);
  --color-surface-accent-primary-light: var(--primary-green-5);
  --color-surface-accent-secondary: var(--secondary-green-50);
  --color-surface-accent-secondary-light: var(--secondary-green-5);
  --color-surface-accent-neutral-high-emphasis: var(--gray-80);
  --color-surface-accent-neutral-medium-emphasis: var(--gray-60-alpha);
  --color-surface-caution: var(--caution-red-100);
  --color-surface-caution-light: var(--caution-red-5-alpha);
  --color-surface-positive: var(--primary-green-70);
  --color-surface-positive-light: var(--primary-green-5);

  /* Text Colors */
  --color-text-high-emphasis: var(--gray-100);
  --color-text-medium-emphasis: var(--gray-70-alpha);
  --color-text-low-emphasis: var(--gray-60-alpha);
  --color-text-disabled: var(--gray-30-alpha);
  --color-text-high-emphasis-inverse: var(--white-100);
  --color-text-accent-primary: var(--primary-green-80);
  --color-text-accent-secondary: var(--secondary-green-80);
  --color-text-caution: var(--caution-red-100);
  --color-text-positive: var(--primary-green-80);

  /* Highlight Colors */
  --color-highlight-error: var(--caution-red-20-alpha);
  --color-highlight-hover: var(--black-30-alpha);
  --color-highlight-yellow: var(--highlight-yellow-100);

  /* Object Colors */
  --color-object-high-emphasis: var(--gray-100);
  --color-object-medium-emphasis: var(--gray-70-alpha);
  --color-object-low-emphasis: var(--gray-60-alpha);
  --color-object-disable: var(--gray-30-alpha);
  --color-object-accent-primary: var(--primary-green-70);
  --color-object-accent-secondary: var(--secondary-green-70);
  --color-object-caution: var(--caution-red-100);
  --color-object-positive: var(--primary-green-70);
  --color-object-high-emphasis-inverse: var(--white-100);
  --color-object-expressive-pink: var(--expressive-pink);

  /* Overlay Colors */
  --color-overlay-dark: var(--black-80-alpha);
  --color-overlay-light: var(--black-20-alpha);
  --color-overlay-medium: var(--black-60-alpha);

  /* Focus Colors */
  --color-focus-clarity: var(--focus-blue-100);
  --color-focus-ambiguous: var(--focus-blue-30-alpha);

  /* Border Colors */
  --color-border-strong-emphasis: var(--gray-100);
  --color-border-high-emphasis: var(--gray-60-alpha);
  --color-border-medium-emphasis: var(--gray-30-alpha);
  --color-border-low-emphasis: var(--gray-10-alpha);
  --color-border-accent-primary: var(--primary-green-70);
  --color-border-high-emphasis-inverse: var(--white-100);
  --color-border-low-emphasis-inverse: var(--white-20-alpha);
  --color-border-caution: var(--caution-red-100);

  /* Third Party Colors */
  --color-third-party-facebook-blue: var(--facebook-blue);
  --color-third-party-facebook-white: var(--facebook-white);
  --color-third-party-twitter-blue: var(--twitter-blue);
  --color-third-party-twitter-white: var(--twitter-white);
  --color-third-party-x-blue: var(--x-blue); /* deprecated. --x-blue- is undefined. specifying it won't change the color. */
  --color-third-party-x-black: var(--x-black);
  --color-third-party-x-white: var(--x-white);
  --color-third-party-instagram-pink: var(--instagram-pink);
  --color-third-party-apple-black: var(--apple-black);
  --color-third-party-apple-white: var(--apple-white);
  --color-third-party-youtube-red: var(--youtube-red);
  --color-third-party-youtube-white: var(--youtube-white);
  --color-third-party-amazon-yellow: var(--amazon-yellow);
  --color-third-party-amazon-black: var(--amazon-black);
  --color-third-party-rakuten-red: var(--rakuten-red);
  --color-third-party-rakuten-white: var(--rakuten-white);
  --color-third-party-yahoo-red: var(--yahoo-red);
  --color-third-party-yahoo-white: var(--yahoo-white);

  /* System Colors */
  --color-system-black: var(--black-100);

  /* Tap Highlight Colors */
  --color-tap-highlight-base: var(--gray-5-alpha);
}
"""
        ]
