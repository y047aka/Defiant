module Shared exposing (Shared, init, setDarkMode)

import Browser.Navigation exposing (Key)


type alias Shared =
    { key : Key
    , darkMode : Bool
    }


init : Key -> Shared
init key =
    { key = key
    , darkMode = False
    }



-- SETTERS


setDarkMode : Bool -> Shared -> Shared
setDarkMode darkMode shared =
    { shared | darkMode = darkMode }
