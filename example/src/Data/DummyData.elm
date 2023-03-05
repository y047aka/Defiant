module Data.DummyData exposing (people)


people :
    List
        { name : String
        , relation : String
        , introduction : String
        , friends : Int
        , imageUrl : String
        }
people =
    [ { name = "Matt Giampietro"
      , relation = "Friends"
      , introduction = "Matthew is an interior designer living in New York."
      , friends = 75
      , imageUrl = "/images/avatar/matthew.png"
      }
    , { name = "Molly"
      , relation = "Coworker"
      , introduction = "Molly is a personal assistant living in Paris."
      , friends = 35
      , imageUrl = "/images/avatar/molly.png"
      }
    , { name = "Elyse"
      , relation = "Coworker"
      , introduction = "Elyse is a copywriter working in New York."
      , friends = 151
      , imageUrl = "/images/avatar/elyse.png"
      }
    , { name = "Kristy"
      , relation = "Friends"
      , introduction = "Kristy is an art director living in New York."
      , friends = 22
      , imageUrl = "/images/avatar/kristy.png"
      }
    ]
