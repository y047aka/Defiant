module Pages.Element.Image exposing (Model, Msg, init, update, view)

import Html.Styled exposing (Html)
import Html.Styled.Attributes exposing (src)
import Playground exposing (playground)
import Shared
import UI.Image exposing (smallImage)



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type alias Msg =
    ()


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Shared.Model -> List (Html Msg)
view { theme } =
    [ playground
        { title = "Image"
        , theme = theme
        , inverted = False
        , preview = [ smallImage [ src "/images/wireframe/image.png" ] [] ]
        , configSections = []
        }
    ]
