module Icon.Brands exposing (fromString)

import FontAwesome.Brands exposing (..)
import FontAwesome.Icon exposing (Icon)


fromString : String -> Maybe Icon
fromString str =
    case str of
        "500px" ->
            Just fa500px

        "accessible-icon" ->
            Just accessibleIcon

        "accusoft" ->
            Just accusoft

        "acquisitions-incorporated" ->
            Just acquisitionsIncorporated

        "adn" ->
            Just adn

        "adobe" ->
            Just adobe

        "adversal" ->
            Just adversal

        "affiliatetheme" ->
            Just affiliatetheme

        "airbnb" ->
            Just airbnb

        "algolia" ->
            Just algolia

        "alipay" ->
            Just alipay

        "amazon" ->
            Just amazon

        "amazon-pay" ->
            Just amazonPay

        "amilia" ->
            Just amilia

        "android" ->
            Just android

        "angellist" ->
            Just angellist

        "angrycreative" ->
            Just angrycreative

        "angular" ->
            Just angular

        "app-store" ->
            Just appStore

        "app-store-ios" ->
            Just appStoreIos

        "apper" ->
            Just apper

        "apple" ->
            Just apple

        "apple-pay" ->
            Just applePay

        "artstation" ->
            Just artstation

        "asymmetrik" ->
            Just asymmetrik

        "atlassian" ->
            Just atlassian

        "audible" ->
            Just audible

        "autoprefixer" ->
            Just autoprefixer

        "avianex" ->
            Just avianex

        "aviato" ->
            Just aviato

        "aws" ->
            Just aws

        "bandcamp" ->
            Just bandcamp

        "battle-net" ->
            Just battleNet

        "behance" ->
            Just behance

        "behance-square" ->
            Just behanceSquare

        "bimobject" ->
            Just bimobject

        "bitbucket" ->
            Just bitbucket

        "bitcoin" ->
            Just bitcoin

        "bity" ->
            Just bity

        "black-tie" ->
            Just blackTie

        "blackberry" ->
            Just blackberry

        "blogger" ->
            Just blogger

        "blogger-b" ->
            Just bloggerB

        "bluetooth" ->
            Just bluetooth

        "bluetooth-b" ->
            Just bluetoothB

        "bootstrap" ->
            Just bootstrap

        "btc" ->
            Just btc

        "buffer" ->
            Just buffer

        "buromobelexperte" ->
            Just buromobelexperte

        "buy-n-large" ->
            Just buyNLarge

        "buysellads" ->
            Just buysellads

        "canadian-maple-leaf" ->
            Just canadianMapleLeaf

        "cc-amazon-pay" ->
            Just ccAmazonPay

        "cc-amex" ->
            Just ccAmex

        "cc-apple-pay" ->
            Just ccApplePay

        "cc-diners-club" ->
            Just ccDinersClub

        "cc-discover" ->
            Just ccDiscover

        "cc-jcb" ->
            Just ccJcb

        "cc-mastercard" ->
            Just ccMastercard

        "cc-paypal" ->
            Just ccPaypal

        "cc-stripe" ->
            Just ccStripe

        "cc-visa" ->
            Just ccVisa

        "centercode" ->
            Just centercode

        "centos" ->
            Just centos

        "chrome" ->
            Just chrome

        "chromecast" ->
            Just chromecast

        "cloudscale" ->
            Just cloudscale

        "cloudsmith" ->
            Just cloudsmith

        "cloudversify" ->
            Just cloudversify

        "codepen" ->
            Just codepen

        "codiepie" ->
            Just codiepie

        "confluence" ->
            Just confluence

        "connectdevelop" ->
            Just connectdevelop

        "contao" ->
            Just contao

        "cotton-bureau" ->
            Just cottonBureau

        "cpanel" ->
            Just cpanel

        "creative-commons" ->
            Just creativeCommons

        "creative-commons-by" ->
            Just creativeCommonsBy

        "creative-commons-nc" ->
            Just creativeCommonsNc

        "creative-commons-nc-eu" ->
            Just creativeCommonsNcEu

        "creative-commons-nc-jp" ->
            Just creativeCommonsNcJp

        "creative-commons-nd" ->
            Just creativeCommonsNd

        "creative-commons-pd" ->
            Just creativeCommonsPd

        "creative-commons-pd-alt" ->
            Just creativeCommonsPdAlt

        "creative-commons-remix" ->
            Just creativeCommonsRemix

        "creative-commons-sa" ->
            Just creativeCommonsSa

        "creative-commons-sampling" ->
            Just creativeCommonsSampling

        "creative-commons-sampling-plus" ->
            Just creativeCommonsSamplingPlus

        "creative-commons-share" ->
            Just creativeCommonsShare

        "creative-commons-zero" ->
            Just creativeCommonsZero

        "critical-role" ->
            Just criticalRole

        "css3" ->
            Just css3

        "css3-alt" ->
            Just css3Alt

        "cuttlefish" ->
            Just cuttlefish

        "d-and-d" ->
            Just dAndD

        "d-and-d-beyond" ->
            Just dAndDBeyond

        "dailymotion" ->
            Just dailymotion

        "dashcube" ->
            Just dashcube

        "deezer" ->
            Just deezer

        "delicious" ->
            Just delicious

        "deploydog" ->
            Just deploydog

        "deskpro" ->
            Just deskpro

        "dev" ->
            Just dev

        "deviantart" ->
            Just deviantart

        "dhl" ->
            Just dhl

        "diaspora" ->
            Just diaspora

        "digg" ->
            Just digg

        "digital-ocean" ->
            Just digitalOcean

        "discord" ->
            Just discord

        "discourse" ->
            Just discourse

        "dochub" ->
            Just dochub

        "docker" ->
            Just docker

        "draft2digital" ->
            Just draft2digital

        "dribbble" ->
            Just dribbble

        "dribbble-square" ->
            Just dribbbleSquare

        "dropbox" ->
            Just dropbox

        "drupal" ->
            Just drupal

        "dyalog" ->
            Just dyalog

        "earlybirds" ->
            Just earlybirds

        "ebay" ->
            Just ebay

        "edge" ->
            Just edge

        "edge-legacy" ->
            Just edgeLegacy

        "elementor" ->
            Just elementor

        "ello" ->
            Just ello

        "ember" ->
            Just ember

        "empire" ->
            Just empire

        "envira" ->
            Just envira

        "erlang" ->
            Just erlang

        "ethereum" ->
            Just ethereum

        "etsy" ->
            Just etsy

        "evernote" ->
            Just evernote

        "expeditedssl" ->
            Just expeditedssl

        "facebook" ->
            Just facebook

        "facebook-f" ->
            Just facebookF

        "facebook-messenger" ->
            Just facebookMessenger

        "facebook-square" ->
            Just facebookSquare

        "fantasy-flight-games" ->
            Just fantasyFlightGames

        "fedex" ->
            Just fedex

        "fedora" ->
            Just fedora

        "figma" ->
            Just figma

        "firefox" ->
            Just firefox

        "firefox-browser" ->
            Just firefoxBrowser

        "first-order" ->
            Just firstOrder

        "first-order-alt" ->
            Just firstOrderAlt

        "firstdraft" ->
            Just firstdraft

        "flickr" ->
            Just flickr

        "flipboard" ->
            Just flipboard

        "fly" ->
            Just fly

        "font-awesome" ->
            Just fontAwesome

        "font-awesome-alt" ->
            Just fontAwesomeAlt

        "font-awesome-flag" ->
            Just fontAwesomeFlag

        "font-awesome-logo-full" ->
            Just fontAwesomeLogoFull

        "fonticons" ->
            Just fonticons

        "fonticons-fi" ->
            Just fonticonsFi

        "fort-awesome" ->
            Just fortAwesome

        "fort-awesome-alt" ->
            Just fortAwesomeAlt

        "forumbee" ->
            Just forumbee

        "foursquare" ->
            Just foursquare

        "free-code-camp" ->
            Just freeCodeCamp

        "freebsd" ->
            Just freebsd

        "fulcrum" ->
            Just fulcrum

        "galactic-republic" ->
            Just galacticRepublic

        "galactic-senate" ->
            Just galacticSenate

        "get-pocket" ->
            Just getPocket

        "gg" ->
            Just gg

        "gg-circle" ->
            Just ggCircle

        "git" ->
            Just git

        "git-alt" ->
            Just gitAlt

        "git-square" ->
            Just gitSquare

        "github" ->
            Just github

        "github-alt" ->
            Just githubAlt

        "github-square" ->
            Just githubSquare

        "gitkraken" ->
            Just gitkraken

        "gitlab" ->
            Just gitlab

        "gitter" ->
            Just gitter

        "glide" ->
            Just glide

        "glide-g" ->
            Just glideG

        "gofore" ->
            Just gofore

        "goodreads" ->
            Just goodreads

        "goodreads-g" ->
            Just goodreadsG

        "google" ->
            Just google

        "google-drive" ->
            Just googleDrive

        "google-pay" ->
            Just googlePay

        "google-play" ->
            Just googlePlay

        "google-plus" ->
            Just googlePlus

        "google-plus-g" ->
            Just googlePlusG

        "google-plus-square" ->
            Just googlePlusSquare

        "google-wallet" ->
            Just googleWallet

        "gratipay" ->
            Just gratipay

        "grav" ->
            Just grav

        "gripfire" ->
            Just gripfire

        "grunt" ->
            Just grunt

        "gulp" ->
            Just gulp

        "hacker-news" ->
            Just hackerNews

        "hacker-news-square" ->
            Just hackerNewsSquare

        "hackerrank" ->
            Just hackerrank

        "hips" ->
            Just hips

        "hire-a-helper" ->
            Just hireAHelper

        "hooli" ->
            Just hooli

        "hornbill" ->
            Just hornbill

        "hotjar" ->
            Just hotjar

        "houzz" ->
            Just houzz

        "html5" ->
            Just html5

        "hubspot" ->
            Just hubspot

        "ideal" ->
            Just ideal

        "imdb" ->
            Just imdb

        "instagram" ->
            Just instagram

        "instagram-square" ->
            Just instagramSquare

        "intercom" ->
            Just intercom

        "internet-explorer" ->
            Just internetExplorer

        "invision" ->
            Just invision

        "ioxhost" ->
            Just ioxhost

        "itch-io" ->
            Just itchIo

        "itunes" ->
            Just itunes

        "itunes-note" ->
            Just itunesNote

        "java" ->
            Just java

        "jedi-order" ->
            Just jediOrder

        "jenkins" ->
            Just jenkins

        "jira" ->
            Just jira

        "joget" ->
            Just joget

        "joomla" ->
            Just joomla

        "js" ->
            Just js

        "js-square" ->
            Just jsSquare

        "jsfiddle" ->
            Just jsfiddle

        "kaggle" ->
            Just kaggle

        "keybase" ->
            Just keybase

        "keycdn" ->
            Just keycdn

        "kickstarter" ->
            Just kickstarter

        "kickstarter-k" ->
            Just kickstarterK

        "korvue" ->
            Just korvue

        "laravel" ->
            Just laravel

        "lastfm" ->
            Just lastfm

        "lastfm-square" ->
            Just lastfmSquare

        "leanpub" ->
            Just leanpub

        "less" ->
            Just less

        "line" ->
            Just line

        "linkedin" ->
            Just linkedin

        "linkedin-in" ->
            Just linkedinIn

        "linode" ->
            Just linode

        "linux" ->
            Just linux

        "lyft" ->
            Just lyft

        "magento" ->
            Just magento

        "mailchimp" ->
            Just mailchimp

        "mandalorian" ->
            Just mandalorian

        "markdown" ->
            Just markdown

        "mastodon" ->
            Just mastodon

        "maxcdn" ->
            Just maxcdn

        "mdb" ->
            Just mdb

        "medapps" ->
            Just medapps

        "medium" ->
            Just medium

        "medium-m" ->
            Just mediumM

        "medrt" ->
            Just medrt

        "meetup" ->
            Just meetup

        "megaport" ->
            Just megaport

        "mendeley" ->
            Just mendeley

        "microblog" ->
            Just microblog

        "microsoft" ->
            Just microsoft

        "mix" ->
            Just mix

        "mixcloud" ->
            Just mixcloud

        "mixer" ->
            Just mixer

        "mizuni" ->
            Just mizuni

        "modx" ->
            Just modx

        "monero" ->
            Just monero

        "napster" ->
            Just napster

        "neos" ->
            Just neos

        "nimblr" ->
            Just nimblr

        "node" ->
            Just node

        "node-js" ->
            Just nodeJs

        "npm" ->
            Just npm

        "ns8" ->
            Just ns8

        "nutritionix" ->
            Just nutritionix

        "odnoklassniki" ->
            Just odnoklassniki

        "odnoklassniki-square" ->
            Just odnoklassnikiSquare

        "old-republic" ->
            Just oldRepublic

        "opencart" ->
            Just opencart

        "openid" ->
            Just openid

        "opera" ->
            Just opera

        "optin-monster" ->
            Just optinMonster

        "orcid" ->
            Just orcid

        "osi" ->
            Just osi

        "page4" ->
            Just page4

        "pagelines" ->
            Just pagelines

        "palfed" ->
            Just palfed

        "patreon" ->
            Just patreon

        "paypal" ->
            Just paypal

        "penny-arcade" ->
            Just pennyArcade

        "periscope" ->
            Just periscope

        "phabricator" ->
            Just phabricator

        "phoenix-framework" ->
            Just phoenixFramework

        "phoenix-squadron" ->
            Just phoenixSquadron

        "php" ->
            Just php

        "pied-piper" ->
            Just piedPiper

        "pied-piper-alt" ->
            Just piedPiperAlt

        "pied-piper-hat" ->
            Just piedPiperHat

        "pied-piper-pp" ->
            Just piedPiperPp

        "pied-piper-square" ->
            Just piedPiperSquare

        "pinterest" ->
            Just pinterest

        "pinterest-p" ->
            Just pinterestP

        "pinterest-square" ->
            Just pinterestSquare

        "playstation" ->
            Just playstation

        "product-hunt" ->
            Just productHunt

        "pushed" ->
            Just pushed

        "python" ->
            Just python

        "qq" ->
            Just qq

        "quinscape" ->
            Just quinscape

        "quora" ->
            Just quora

        "r-project" ->
            Just rProject

        "raspberry-pi" ->
            Just raspberryPi

        "ravelry" ->
            Just ravelry

        "react" ->
            Just react

        "reacteurope" ->
            Just reacteurope

        "readme" ->
            Just readme

        "rebel" ->
            Just rebel

        "red-river" ->
            Just redRiver

        "reddit" ->
            Just reddit

        "reddit-alien" ->
            Just redditAlien

        "reddit-square" ->
            Just redditSquare

        "redhat" ->
            Just redhat

        "renren" ->
            Just renren

        "replyd" ->
            Just replyd

        "researchgate" ->
            Just researchgate

        "resolving" ->
            Just resolving

        "rev" ->
            Just rev

        "rocketchat" ->
            Just rocketchat

        "rockrms" ->
            Just rockrms

        "rust" ->
            Just rust

        "safari" ->
            Just safari

        "salesforce" ->
            Just salesforce

        "sass" ->
            Just sass

        "schlix" ->
            Just schlix

        "scribd" ->
            Just scribd

        "searchengin" ->
            Just searchengin

        "sellcast" ->
            Just sellcast

        "sellsy" ->
            Just sellsy

        "servicestack" ->
            Just servicestack

        "shirtsinbulk" ->
            Just shirtsinbulk

        "shopify" ->
            Just shopify

        "shopware" ->
            Just shopware

        "simplybuilt" ->
            Just simplybuilt

        "sistrix" ->
            Just sistrix

        "sith" ->
            Just sith

        "sketch" ->
            Just sketch

        "skyatlas" ->
            Just skyatlas

        "skype" ->
            Just skype

        "slack" ->
            Just slack

        "slack-hash" ->
            Just slackHash

        "slideshare" ->
            Just slideshare

        "snapchat" ->
            Just snapchat

        "snapchat-ghost" ->
            Just snapchatGhost

        "snapchat-square" ->
            Just snapchatSquare

        "soundcloud" ->
            Just soundcloud

        "sourcetree" ->
            Just sourcetree

        "speakap" ->
            Just speakap

        "speaker-deck" ->
            Just speakerDeck

        "spotify" ->
            Just spotify

        "squarespace" ->
            Just squarespace

        "stack-exchange" ->
            Just stackExchange

        "stack-overflow" ->
            Just stackOverflow

        "stackpath" ->
            Just stackpath

        "staylinked" ->
            Just staylinked

        "steam" ->
            Just steam

        "steam-square" ->
            Just steamSquare

        "steam-symbol" ->
            Just steamSymbol

        "sticker-mule" ->
            Just stickerMule

        "strava" ->
            Just strava

        "stripe" ->
            Just stripe

        "stripe-s" ->
            Just stripeS

        "studiovinari" ->
            Just studiovinari

        "stumbleupon" ->
            Just stumbleupon

        "stumbleupon-circle" ->
            Just stumbleuponCircle

        "superpowers" ->
            Just superpowers

        "supple" ->
            Just supple

        "suse" ->
            Just suse

        "swift" ->
            Just swift

        "symfony" ->
            Just symfony

        "teamspeak" ->
            Just teamspeak

        "telegram" ->
            Just telegram

        "telegram-plane" ->
            Just telegramPlane

        "tencent-weibo" ->
            Just tencentWeibo

        "the-red-yeti" ->
            Just theRedYeti

        "themeco" ->
            Just themeco

        "themeisle" ->
            Just themeisle

        "think-peaks" ->
            Just thinkPeaks

        "tiktok" ->
            Just tiktok

        "trade-federation" ->
            Just tradeFederation

        "trello" ->
            Just trello

        "tripadvisor" ->
            Just tripadvisor

        "tumblr" ->
            Just tumblr

        "tumblr-square" ->
            Just tumblrSquare

        "twitch" ->
            Just twitch

        "twitter" ->
            Just twitter

        "twitter-square" ->
            Just twitterSquare

        "typo3" ->
            Just typo3

        "uber" ->
            Just uber

        "ubuntu" ->
            Just ubuntu

        "uikit" ->
            Just uikit

        "umbraco" ->
            Just umbraco

        "uniregistry" ->
            Just uniregistry

        "unity" ->
            Just unity

        "unsplash" ->
            Just unsplash

        "untappd" ->
            Just untappd

        "ups" ->
            Just ups

        "usb" ->
            Just usb

        "usps" ->
            Just usps

        "ussunnah" ->
            Just ussunnah

        "vaadin" ->
            Just vaadin

        "viacoin" ->
            Just viacoin

        "viadeo" ->
            Just viadeo

        "viadeo-square" ->
            Just viadeoSquare

        "viber" ->
            Just viber

        "vimeo" ->
            Just vimeo

        "vimeo-square" ->
            Just vimeoSquare

        "vimeo-v" ->
            Just vimeoV

        "vine" ->
            Just vine

        "vk" ->
            Just vk

        "vnv" ->
            Just vnv

        "vuejs" ->
            Just vuejs

        "waze" ->
            Just waze

        "weebly" ->
            Just weebly

        "weibo" ->
            Just weibo

        "weixin" ->
            Just weixin

        "whatsapp" ->
            Just whatsapp

        "whatsapp-square" ->
            Just whatsappSquare

        "whmcs" ->
            Just whmcs

        "wikipedia-w" ->
            Just wikipediaW

        "windows" ->
            Just windows

        "wix" ->
            Just wix

        "wizards-of-the-coast" ->
            Just wizardsOfTheCoast

        "wolf-pack-battalion" ->
            Just wolfPackBattalion

        "wordpress" ->
            Just wordpress

        "wordpress-simple" ->
            Just wordpressSimple

        "wpbeginner" ->
            Just wpbeginner

        "wpexplorer" ->
            Just wpexplorer

        "wpforms" ->
            Just wpforms

        "wpressr" ->
            Just wpressr

        "xbox" ->
            Just xbox

        "xing" ->
            Just xing

        "xing-square" ->
            Just xingSquare

        "y-combinator" ->
            Just yCombinator

        "yahoo" ->
            Just yahoo

        "yammer" ->
            Just yammer

        "yandex" ->
            Just yandex

        "yandex-international" ->
            Just yandexInternational

        "yarn" ->
            Just yarn

        "yelp" ->
            Just yelp

        "yoast" ->
            Just yoast

        "youtube" ->
            Just youtube

        "youtube-square" ->
            Just youtubeSquare

        "zhihu" ->
            Just zhihu

        _ ->
            Nothing
