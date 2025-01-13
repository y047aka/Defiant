module Icon_Outdated.Regular exposing (fromString)

import FontAwesome.Icon exposing (Icon)
import FontAwesome.Regular exposing (..)


fromString : String -> Maybe Icon
fromString str =
    case str of
        "address-book" ->
            Just addressBook

        "address-card" ->
            Just addressCard

        "angry" ->
            Just angry

        "arrow-alt-circle-down" ->
            Just arrowAltCircleDown

        "arrow-alt-circle-left" ->
            Just arrowAltCircleLeft

        "arrow-alt-circle-right" ->
            Just arrowAltCircleRight

        "arrow-alt-circle-up" ->
            Just arrowAltCircleUp

        "bell" ->
            Just bell

        "bell-slash" ->
            Just bellSlash

        "bookmark" ->
            Just bookmark

        "building" ->
            Just building

        "calendar" ->
            Just calendar

        "calendar-alt" ->
            Just calendarAlt

        "calendar-check" ->
            Just calendarCheck

        "calendar-minus" ->
            Just calendarMinus

        "calendar-plus" ->
            Just calendarPlus

        "calendar-times" ->
            Just calendarTimes

        "caret-square-down" ->
            Just caretSquareDown

        "caret-square-left" ->
            Just caretSquareLeft

        "caret-square-right" ->
            Just caretSquareRight

        "caret-square-up" ->
            Just caretSquareUp

        "chart-bar" ->
            Just chartBar

        "check-circle" ->
            Just checkCircle

        "check-square" ->
            Just checkSquare

        "circle" ->
            Just circle

        "clipboard" ->
            Just clipboard

        "clock" ->
            Just clock

        "clone" ->
            Just clone

        "closed-captioning" ->
            Just closedCaptioning

        "comment" ->
            Just comment

        "comment-alt" ->
            Just commentAlt

        "comment-dots" ->
            Just commentDots

        "comments" ->
            Just comments

        "compass" ->
            Just compass

        "copy" ->
            Just copy

        "copyright" ->
            Just copyright

        "credit-card" ->
            Just creditCard

        "dizzy" ->
            Just dizzy

        "dot-circle" ->
            Just dotCircle

        "edit" ->
            Just edit

        "envelope" ->
            Just envelope

        "envelope-open" ->
            Just envelopeOpen

        "eye" ->
            Just eye

        "eye-slash" ->
            Just eyeSlash

        "file" ->
            Just file

        "file-alt" ->
            Just fileAlt

        "file-archive" ->
            Just fileArchive

        "file-audio" ->
            Just fileAudio

        "file-code" ->
            Just fileCode

        "file-excel" ->
            Just fileExcel

        "file-image" ->
            Just fileImage

        "file-pdf" ->
            Just filePdf

        "file-powerpoint" ->
            Just filePowerpoint

        "file-video" ->
            Just fileVideo

        "file-word" ->
            Just fileWord

        "flag" ->
            Just flag

        "flushed" ->
            Just flushed

        "folder" ->
            Just folder

        "folder-open" ->
            Just folderOpen

        "font-awesome-logo-full" ->
            Just fontAwesomeLogoFull

        "frown" ->
            Just frown

        "frown-open" ->
            Just frownOpen

        "futbol" ->
            Just futbol

        "gem" ->
            Just gem

        "grimace" ->
            Just grimace

        "grin" ->
            Just grin

        "grin-alt" ->
            Just grinAlt

        "grin-beam" ->
            Just grinBeam

        "grin-beam-sweat" ->
            Just grinBeamSweat

        "grin-hearts" ->
            Just grinHearts

        "grin-squint" ->
            Just grinSquint

        "grin-squint-tears" ->
            Just grinSquintTears

        "grin-stars" ->
            Just grinStars

        "grin-tears" ->
            Just grinTears

        "grin-tongue" ->
            Just grinTongue

        "grin-tongue-squint" ->
            Just grinTongueSquint

        "grin-tongue-wink" ->
            Just grinTongueWink

        "grin-wink" ->
            Just grinWink

        "hand-lizard" ->
            Just handLizard

        "hand-paper" ->
            Just handPaper

        "hand-peace" ->
            Just handPeace

        "hand-point-down" ->
            Just handPointDown

        "hand-point-left" ->
            Just handPointLeft

        "hand-point-right" ->
            Just handPointRight

        "hand-point-up" ->
            Just handPointUp

        "hand-pointer" ->
            Just handPointer

        "hand-rock" ->
            Just handRock

        "hand-scissors" ->
            Just handScissors

        "hand-spock" ->
            Just handSpock

        "handshake" ->
            Just handshake

        "hdd" ->
            Just hdd

        "heart" ->
            Just heart

        "hospital" ->
            Just hospital

        "hourglass" ->
            Just hourglass

        "id-badge" ->
            Just idBadge

        "id-card" ->
            Just idCard

        "image" ->
            Just image

        "images" ->
            Just images

        "keyboard" ->
            Just keyboard

        "kiss" ->
            Just kiss

        "kiss-beam" ->
            Just kissBeam

        "kiss-wink-heart" ->
            Just kissWinkHeart

        "laugh" ->
            Just laugh

        "laugh-beam" ->
            Just laughBeam

        "laugh-squint" ->
            Just laughSquint

        "laugh-wink" ->
            Just laughWink

        "lemon" ->
            Just lemon

        "life-ring" ->
            Just lifeRing

        "lightbulb" ->
            Just lightbulb

        "list-alt" ->
            Just listAlt

        "map" ->
            Just map

        "meh" ->
            Just meh

        "meh-blank" ->
            Just mehBlank

        "meh-rolling-eyes" ->
            Just mehRollingEyes

        "minus-square" ->
            Just minusSquare

        "money-bill-alt" ->
            Just moneyBillAlt

        "moon" ->
            Just moon

        "newspaper" ->
            Just newspaper

        "object-group" ->
            Just objectGroup

        "object-ungroup" ->
            Just objectUngroup

        "paper-plane" ->
            Just paperPlane

        "pause-circle" ->
            Just pauseCircle

        "play-circle" ->
            Just playCircle

        "plus-square" ->
            Just plusSquare

        "question-circle" ->
            Just questionCircle

        "registered" ->
            Just registered

        "sad-cry" ->
            Just sadCry

        "sad-tear" ->
            Just sadTear

        "save" ->
            Just save

        "share-square" ->
            Just shareSquare

        "smile" ->
            Just smile

        "smile-beam" ->
            Just smileBeam

        "smile-wink" ->
            Just smileWink

        "snowflake" ->
            Just snowflake

        "square" ->
            Just square

        "star" ->
            Just star

        "star-half" ->
            Just starHalf

        "sticky-note" ->
            Just stickyNote

        "stop-circle" ->
            Just stopCircle

        "sun" ->
            Just sun

        "surprise" ->
            Just surprise

        "thumbs-down" ->
            Just thumbsDown

        "thumbs-up" ->
            Just thumbsUp

        "times-circle" ->
            Just timesCircle

        "tired" ->
            Just tired

        "trash-alt" ->
            Just trashAlt

        "user" ->
            Just user

        "user-circle" ->
            Just userCircle

        "window-close" ->
            Just windowClose

        "window-maximize" ->
            Just windowMaximize

        "window-minimize" ->
            Just windowMinimize

        "window-restore" ->
            Just windowRestore

        _ ->
            Nothing
