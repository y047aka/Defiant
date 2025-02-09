module Html.Styled.DesignToken exposing
    ( HtmlWithDesignToken
    , h1, h2, h3, h4, h5, h6
    , div, p, hr, pre, blockquote
    , span, a, code, em, strong, i, b, u, sub, sup, br
    , ol, ul, li, dl, dt, dd
    , img, iframe, canvas, math
    , form, input, textarea, button, select, option
    , section, nav, article, aside, header, footer, address, main_
    , figure, figcaption
    , table, caption, colgroup, col, tbody, thead, tfoot, tr, td, th
    , fieldset, legend, label, datalist, optgroup, output, progress, meter
    , audio, video, source, track
    , embed, object, param
    , ins, del
    , small, cite, dfn, abbr, time, var, samp, kbd, s, q
    , mark, ruby, rt, rp, bdi, bdo, wbr
    , details, summary, menuitem, menu
    )

{-|


# Primitives

@docs HtmlWithDesignToken, text


# Tags


## Headers

@docs h1, h2, h3, h4, h5, h6


## Grouping Content

@docs div, p, hr, pre, blockquote


## Text

@docs span, a, code, em, strong, i, b, u, sub, sup, br


## Lists

@docs ol, ul, li, dl, dt, dd


## Embedded Content

@docs img, iframe, canvas, math


## Inputs

@docs form, input, textarea, button, select, option


## Sections

@docs section, nav, article, aside, header, footer, address, main_


## Figures

@docs figure, figcaption


## Tables

@docs table, caption, colgroup, col, tbody, thead, tfoot, tr, td, th


## Less Common Elements


### Less Common Inputs

@docs fieldset, legend, label, datalist, optgroup, output, progress, meter


### Audio and Video

@docs audio, video, source, track


### Embedded Objects

@docs embed, object, param


### Text Edits

@docs ins, del


### Semantic Text

@docs small, cite, dfn, abbr, time, var, samp, kbd, s, q


### Less Common Text Tags

@docs mark, ruby, rt, rp, bdi, bdo, wbr


## Interactive Elements

@docs details, summary, menuitem, menu

-}

import Css exposing (Style)
import Html.Styled exposing (Attribute, Html)
import Html.Styled.Attributes exposing (css)


type alias HtmlWithDesignToken msg =
    DesignToken
    ->
        { tag : List (Attribute msg) -> List (Html msg) -> Html msg
        , attributes : List (Attribute msg)
        , children : List (Html msg)
        }


type alias DesignToken =
    {}


toStyle : DesignToken -> Style
toStyle _ =
    Css.batch []


node : String -> List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
node tagName attributes children =
    \designToken ->
        { tag = Html.Styled.node tagName
        , attributes = css [ toStyle designToken ] :: attributes
        , children =
            children
                |> List.map (\c -> c designToken)
                |> List.map (\c -> c.tag c.attributes c.children)
        }



-- SECTIONS


{-| Defines a section in a document.
-}
section : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
section =
    node "section"


{-| Defines a section that contains only navigation links.
-}
nav : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
nav =
    node "nav"


{-| Defines self-contained content that could exist independently of the rest
of the content.
-}
article : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
article =
    node "article"


{-| Defines some content loosely related to the page content. If it is removed,
the remaining content still makes sense.
-}
aside : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
aside =
    node "aside"


{-| -}
h1 : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
h1 =
    node "h1"


{-| -}
h2 : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
h2 =
    node "h2"


{-| -}
h3 : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
h3 =
    node "h3"


{-| -}
h4 : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
h4 =
    node "h4"


{-| -}
h5 : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
h5 =
    node "h5"


{-| -}
h6 : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
h6 =
    node "h6"


{-| Defines the header of a page or section. It often contains a logo, the
title of the web site, and a navigational table of content.
-}
header : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
header =
    node "header"


{-| Defines the footer for a page or section. It often contains a copyright
notice, some links to legal information, or addresses to give feedback.
-}
footer : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
footer =
    node "footer"


{-| Defines a section containing contact information.
-}
address : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
address =
    node "address"


{-| Defines the main or important content in the document. There is only one
`main` element in the document.
-}
main_ : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
main_ =
    node "main"



-- GROUPING CONTENT


{-| Defines a portion that should be displayed as a paragraph.
-}
p : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
p =
    node "p"


{-| Represents a thematic break between paragraphs of a section or article or
any longer content.
-}
hr : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
hr =
    node "hr"


{-| Indicates that its content is preformatted and that this format must be
preserved.
-}
pre : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
pre =
    node "pre"


{-| Represents a content that is quoted from another source.
-}
blockquote : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
blockquote =
    node "blockquote"


{-| Defines an ordered list of items.
-}
ol : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
ol =
    node "ol"


{-| Defines an unordered list of items.
-}
ul : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
ul =
    node "ul"


{-| Defines a item of an enumeration list.
-}
li : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
li =
    node "li"


{-| Defines a definition list, that is, a list of terms and their associated
definitions.
-}
dl : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
dl =
    node "dl"


{-| Represents a term defined by the next `dd`.
-}
dt : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
dt =
    node "dt"


{-| Represents the definition of the terms immediately listed before it.
-}
dd : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
dd =
    node "dd"


{-| Represents a figure illustrated as part of the document.
-}
figure : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
figure =
    node "figure"


{-| Represents the legend of a figure.
-}
figcaption : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
figcaption =
    node "figcaption"


{-| Represents a generic container with no special meaning.
-}
div : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
div =
    node "div"



-- TEXT LEVEL SEMANTIC


{-| Represents a hyperlink, linking to another resource.
-}
a : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
a =
    node "a"


{-| Represents emphasized text, like a stress accent.
-}
em : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
em =
    node "em"


{-| Represents especially important text.
-}
strong : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
strong =
    node "strong"


{-| Represents a side comment, that is, text like a disclaimer or a
copyright, which is not essential to the comprehension of the document.
-}
small : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
small =
    node "small"


{-| Represents content that is no longer accurate or relevant.
-}
s : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
s =
    node "s"


{-| Represents the title of a work.
-}
cite : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
cite =
    node "cite"


{-| Represents an inline quotation.
-}
q : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
q =
    node "q"


{-| Represents a term whose definition is contained in its nearest ancestor
content.
-}
dfn : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
dfn =
    node "dfn"


{-| Represents an abbreviation or an acronym; the expansion of the
abbreviation can be represented in the title attribute.
-}
abbr : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
abbr =
    node "abbr"


{-| Represents a date and time value; the machine-readable equivalent can be
represented in the datetime attribute.
-}
time : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
time =
    node "time"


{-| Represents computer code.
-}
code : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
code =
    node "code"


{-| Represents a variable. Specific cases where it should be used include an
actual mathematical expression or programming context, an identifier
representing a constant, a symbol identifying a physical quantity, a function
parameter, or a mere placeholder in prose.
-}
var : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
var =
    node "var"


{-| Represents the output of a program or a computer.
-}
samp : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
samp =
    node "samp"


{-| Represents user input, often from the keyboard, but not necessarily; it
may represent other input, like transcribed voice commands.
-}
kbd : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
kbd =
    node "kbd"


{-| Represent a subscript.
-}
sub : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
sub =
    node "sub"


{-| Represent a superscript.
-}
sup : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
sup =
    node "sup"


{-| Represents some text in an alternate voice or mood, or at least of
different quality, such as a taxonomic designation, a technical term, an
idiomatic phrase, a thought, or a ship name.
-}
i : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
i =
    node "i"


{-| Represents a text which to which attention is drawn for utilitarian
purposes. It doesn't convey extra importance and doesn't imply an alternate
voice.
-}
b : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
b =
    node "b"


{-| Represents a non-textual annotation for which the conventional
presentation is underlining, such labeling the text as being misspelt or
labeling a proper name in Chinese text.
-}
u : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
u =
    node "u"


{-| Represents text highlighted for reference purposes, that is for its
relevance in another context.
-}
mark : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
mark =
    node "mark"


{-| Represents content to be marked with ruby annotations, short runs of text
presented alongside the text. This is often used in conjunction with East Asian
language where the annotations act as a guide for pronunciation, like the
Japanese furigana.
-}
ruby : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
ruby =
    node "ruby"


{-| Represents the text of a ruby annotation.
-}
rt : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
rt =
    node "rt"


{-| Represents parenthesis around a ruby annotation, used to display the
annotation in an alternate way by browsers not supporting the standard display
for annotations.
-}
rp : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
rp =
    node "rp"


{-| Represents text that must be isolated from its surrounding for
bidirectional text formatting. It allows embedding a span of text with a
different, or unknown, directionality.
-}
bdi : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
bdi =
    node "bdi"


{-| Represents the directionality of its children, in order to explicitly
override the Unicode bidirectional algorithm.
-}
bdo : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
bdo =
    node "bdo"


{-| Represents text with no specific meaning. This has to be used when no other
text-semantic element conveys an adequate meaning, which, in this case, is
often brought by global attributes like `class`, `lang`, or `dir`.
-}
span : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
span =
    node "span"


{-| Represents a line break.
-}
br : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
br =
    node "br"


{-| Represents a line break opportunity, that is a suggested point for
wrapping text in order to improve readability of text split on several lines.
-}
wbr : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
wbr =
    node "wbr"



-- EDITS


{-| Defines an addition to the document.
-}
ins : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
ins =
    node "ins"


{-| Defines a removal from the document.
-}
del : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
del =
    node "del"



-- EMBEDDED CONTENT


{-| Represents an image.
-}
img : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
img =
    node "img"


{-| Embedded an HTML document.
-}
iframe : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
iframe =
    node "iframe"


{-| Represents a integration point for an external, often non-HTML,
application or interactive content.
-}
embed : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
embed =
    node "embed"


{-| Represents an external resource, which is treated as an image, an HTML
sub-document, or an external resource to be processed by a plug-in.
-}
object : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
object =
    node "object"


{-| Defines parameters for use by plug-ins invoked by `object` elements.
-}
param : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
param =
    node "param"


{-| Represents a video, the associated audio and captions, and controls.
-}
video : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
video =
    node "video"


{-| Represents a sound or audio stream.
-}
audio : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
audio =
    node "audio"


{-| Allows authors to specify alternative media resources for media elements
like `video` or `audio`.
-}
source : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
source =
    node "source"


{-| Allows authors to specify timed text track for media elements like `video`
or `audio`.
-}
track : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
track =
    node "track"


{-| Represents a bitmap area for graphics rendering.
-}
canvas : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
canvas =
    node "canvas"


{-| Defines a mathematical formula.
-}
math : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
math =
    node "math"



-- TABULAR DATA


{-| Represents data with more than one dimension.
-}
table : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
table =
    node "table"


{-| Represents the title of a table.
-}
caption : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
caption =
    node "caption"


{-| Represents a set of one or more columns of a table.
-}
colgroup : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
colgroup =
    node "colgroup"


{-| Represents a column of a table.
-}
col : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
col =
    node "col"


{-| Represents the block of rows that describes the concrete data of a table.
-}
tbody : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
tbody =
    node "tbody"


{-| Represents the block of rows that describes the column labels of a table.
-}
thead : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
thead =
    node "thead"


{-| Represents the block of rows that describes the column summaries of a table.
-}
tfoot : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
tfoot =
    node "tfoot"


{-| Represents a row of cells in a table.
-}
tr : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
tr =
    node "tr"


{-| Represents a data cell in a table.
-}
td : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
td =
    node "td"


{-| Represents a header cell in a table.
-}
th : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
th =
    node "th"



-- FORMS


{-| Represents a form, consisting of controls, that can be submitted to a
server for processing.
-}
form : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
form =
    node "form"


{-| Represents a set of controls.
-}
fieldset : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
fieldset =
    node "fieldset"


{-| Represents the caption for a `fieldset`.
-}
legend : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
legend =
    node "legend"


{-| Represents the caption of a form control.
-}
label : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
label =
    node "label"


{-| Represents a typed data field allowing the user to edit the data.
-}
input : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
input =
    node "input"


{-| Represents a button.
-}
button : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
button =
    node "button"


{-| Represents a control allowing selection among a set of options.
-}
select : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
select =
    node "select"


{-| Represents a set of predefined options for other controls.
-}
datalist : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
datalist =
    node "datalist"


{-| Represents a set of options, logically grouped.
-}
optgroup : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
optgroup =
    node "optgroup"


{-| Represents an option in a `select` element or a suggestion of a `datalist`
element.
-}
option : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
option =
    node "option"


{-| Represents a multiline text edit control.
-}
textarea : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
textarea =
    node "textarea"


{-| Represents a key-pair generator control.
-}
keygen : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
keygen =
    node "keygen"


{-| Represents the result of a calculation.
-}
output : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
output =
    node "output"


{-| Represents the completion progress of a task.
-}
progress : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
progress =
    node "progress"


{-| Represents a scalar measurement (or a fractional value), within a known
range.
-}
meter : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
meter =
    node "meter"



-- INTERACTIVE ELEMENTS


{-| Represents a widget from which the user can obtain additional information
or controls.
-}
details : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
details =
    node "details"


{-| Represents a summary, caption, or legend for a given `details`.
-}
summary : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
summary =
    node "summary"


{-| Represents a command that the user can invoke.
-}
menuitem : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
menuitem =
    node "menuitem"


{-| Represents a list of commands.
-}
menu : List (Attribute msg) -> List (HtmlWithDesignToken msg) -> HtmlWithDesignToken msg
menu =
    node "menu"
