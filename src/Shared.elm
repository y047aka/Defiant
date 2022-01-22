module Shared exposing (Shared, init, setDarkMode, setPageSummary)

import Browser.Navigation exposing (Key)
import Data.Page exposing (PageSummary)


type alias Shared =
    { key : Key
    , pageSummary : PageSummary
    , darkMode : Bool
    }


init : Key -> PageSummary -> Shared
init key pageSummary =
    { key = key
    , pageSummary = pageSummary
    , darkMode = False
    }



-- SETTERS


setDarkMode : Bool -> Shared -> Shared
setDarkMode darkMode shared =
    { shared | darkMode = darkMode }


setPageSummary : PageSummary -> Shared -> Shared
setPageSummary pageSummary shared =
    { shared | pageSummary = pageSummary }
