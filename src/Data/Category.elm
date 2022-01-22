module Data.Category exposing (Category(..), toString)


type Category
    = None
    | Globals
    | Elements
    | Collections
    | Views
    | Modules
    | Defiant


toString : Category -> String
toString category =
    case category of
        None ->
            "None"

        Globals ->
            "Globals"

        Elements ->
            "Elements"

        Collections ->
            "Collections"

        Views ->
            "Views"

        Modules ->
            "Modules"

        Defiant ->
            "Defiant"
