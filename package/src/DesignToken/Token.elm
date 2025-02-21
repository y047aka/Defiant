module DesignToken.Token exposing (..)

{-|

@docs Entity
@docs md

-}


type alias Entity =
    { class : String
    , type_ : String
    , id : String
    , name : String
    , value : String
    , category_id : String
    , last_updated : String
    , last_updated_by : String
    , description : String
    , tags : List String
    }


{-| <https://github.com/material-foundation/material-tokens/blob/main/dsp/data/tokens.json>
-}
md =
    { ref =
        { palette =
            { error0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error0"
                , name = "md.ref.palette.error0"
                , value = "#000000ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , error10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error10"
                , name = "md.ref.palette.error10"
                , value = "#410e0bff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , error20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error20"
                , name = "md.ref.palette.error20"
                , value = "#601410ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , error30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error30"
                , name = "md.ref.palette.error30"
                , value = "#8c1d18ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , error40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error40"
                , name = "md.ref.palette.error40"
                , value = "#b3261eff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , error50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error50"
                , name = "md.ref.palette.error50"
                , value = "#dc362eff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , error60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error60"
                , name = "md.ref.palette.error60"
                , value = "#e46962ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , error70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error70"
                , name = "md.ref.palette.error70"
                , value = "#ec928eff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , error80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error80"
                , name = "md.ref.palette.error80"
                , value = "#f2b8b5ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , error90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error90"
                , name = "md.ref.palette.error90"
                , value = "#f9dedcff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , error95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error95"
                , name = "md.ref.palette.error95"
                , value = "#fceeeeff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , error99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error99"
                , name = "md.ref.palette.error99"
                , value = "#fffbf9ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , error100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error100"
                , name = "md.ref.palette.error100"
                , value = "#ffffffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Error 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary0"
                , name = "md.ref.palette.tertiary0"
                , value = "#000000ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary10"
                , name = "md.ref.palette.tertiary10"
                , value = "#31111dff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary20"
                , name = "md.ref.palette.tertiary20"
                , value = "#492532ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary30"
                , name = "md.ref.palette.tertiary30"
                , value = "#633b48ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary40"
                , name = "md.ref.palette.tertiary40"
                , value = "#7d5260ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary50"
                , name = "md.ref.palette.tertiary50"
                , value = "#986977ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary60"
                , name = "md.ref.palette.tertiary60"
                , value = "#b58392ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary70"
                , name = "md.ref.palette.tertiary70"
                , value = "#d29dacff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary80"
                , name = "md.ref.palette.tertiary80"
                , value = "#efb8c8ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary90"
                , name = "md.ref.palette.tertiary90"
                , value = "#ffd8e4ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary95"
                , name = "md.ref.palette.tertiary95"
                , value = "#ffecf1ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary99"
                , name = "md.ref.palette.tertiary99"
                , value = "#fffbfaff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary100"
                , name = "md.ref.palette.tertiary100"
                , value = "#ffffffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Tertiary 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary0"
                , name = "md.ref.palette.secondary0"
                , value = "#000000ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary10"
                , name = "md.ref.palette.secondary10"
                , value = "#1d192bff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary20"
                , name = "md.ref.palette.secondary20"
                , value = "#332d41ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary30"
                , name = "md.ref.palette.secondary30"
                , value = "#4a4458ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary40"
                , name = "md.ref.palette.secondary40"
                , value = "#625b71ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary50"
                , name = "md.ref.palette.secondary50"
                , value = "#7a7289ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary60"
                , name = "md.ref.palette.secondary60"
                , value = "#958da5ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary70"
                , name = "md.ref.palette.secondary70"
                , value = "#b0a7c0ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary80"
                , name = "md.ref.palette.secondary80"
                , value = "#ccc2dcff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary90"
                , name = "md.ref.palette.secondary90"
                , value = "#e8def8ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary95"
                , name = "md.ref.palette.secondary95"
                , value = "#f6edffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary99"
                , name = "md.ref.palette.secondary99"
                , value = "#fffbfeff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary100"
                , name = "md.ref.palette.secondary100"
                , value = "#ffffffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Secondary 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary0"
                , name = "md.ref.palette.primary0"
                , value = "#000000ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary10"
                , name = "md.ref.palette.primary10"
                , value = "#21005dff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary20"
                , name = "md.ref.palette.primary20"
                , value = "#381e72ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary30"
                , name = "md.ref.palette.primary30"
                , value = "#4f378bff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary40"
                , name = "md.ref.palette.primary40"
                , value = "#6750a4ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary50"
                , name = "md.ref.palette.primary50"
                , value = "#7f67beff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary60"
                , name = "md.ref.palette.primary60"
                , value = "#9a82dbff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary70"
                , name = "md.ref.palette.primary70"
                , value = "#b69df8ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary80"
                , name = "md.ref.palette.primary80"
                , value = "#d0bcffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary90"
                , name = "md.ref.palette.primary90"
                , value = "#eaddffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary95"
                , name = "md.ref.palette.primary95"
                , value = "#f6edffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary99"
                , name = "md.ref.palette.primary99"
                , value = "#fffbfeff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary100"
                , name = "md.ref.palette.primary100"
                , value = "#ffffffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Primary 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant0"
                , name = "md.ref.palette.neutral-variant0"
                , value = "#000000ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant10"
                , name = "md.ref.palette.neutral-variant10"
                , value = "#1d1a22ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant20"
                , name = "md.ref.palette.neutral-variant20"
                , value = "#322f37ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant30"
                , name = "md.ref.palette.neutral-variant30"
                , value = "#49454fff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant40"
                , name = "md.ref.palette.neutral-variant40"
                , value = "#605d66ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant50"
                , name = "md.ref.palette.neutral-variant50"
                , value = "#79747eff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant60"
                , name = "md.ref.palette.neutral-variant60"
                , value = "#938f99ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant70"
                , name = "md.ref.palette.neutral-variant70"
                , value = "#aea9b4ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant80"
                , name = "md.ref.palette.neutral-variant80"
                , value = "#cac4d0ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant90"
                , name = "md.ref.palette.neutral-variant90"
                , value = "#e7e0ecff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant95"
                , name = "md.ref.palette.neutral-variant95"
                , value = "#f5eefaff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant99"
                , name = "md.ref.palette.neutral-variant99"
                , value = "#fffbfeff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant100"
                , name = "md.ref.palette.neutral-variant100"
                , value = "#ffffffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral Variant 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral0"
                , name = "md.ref.palette.neutral0"
                , value = "#000000ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral10"
                , name = "md.ref.palette.neutral10"
                , value = "#1c1b1fff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral20"
                , name = "md.ref.palette.neutral20"
                , value = "#313033ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral30"
                , name = "md.ref.palette.neutral30"
                , value = "#484649ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral40"
                , name = "md.ref.palette.neutral40"
                , value = "#605d62ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral50"
                , name = "md.ref.palette.neutral50"
                , value = "#787579ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral60"
                , name = "md.ref.palette.neutral60"
                , value = "#939094ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral70"
                , name = "md.ref.palette.neutral70"
                , value = "#aeaaaeff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral80"
                , name = "md.ref.palette.neutral80"
                , value = "#c9c5caff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral90"
                , name = "md.ref.palette.neutral90"
                , value = "#e6e1e5ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral95"
                , name = "md.ref.palette.neutral95"
                , value = "#f4eff4ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral99"
                , name = "md.ref.palette.neutral99"
                , value = "#fffbfeff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral100"
                , name = "md.ref.palette.neutral100"
                , value = "#ffffffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Neutral 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , black =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.black"
                , name = "md.ref.palette.black"
                , value = "#000000ff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Black"
                , tags = [ "ref", "color", "palette" ]
                }
            , white =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.white"
                , name = "md.ref.palette.white"
                , value = "#ffffffff"
                , category_id = "ref.color.palette"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "White"
                , tags = [ "ref", "color", "palette" ]
                }
            }
        , typeface =
            { plain =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.plain"
                , name = "md.ref.typeface.plain"
                , value = "Roboto"
                , category_id = "ref.typography.typeface"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Plain typeface"
                , tags = [ "ref", "typography", "typeface" ]
                }
            , brand =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.brand"
                , name = "md.ref.typeface.brand"
                , value = "Roboto"
                , category_id = "ref.typography.typeface"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Brand typeface"
                , tags = [ "ref", "typography", "typeface" ]
                }
            , weightBold =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.weight-bold"
                , name = "md.ref.typeface.weight-bold"
                , value = "700"
                , category_id = "ref.typography.typeface"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Bold weight"
                , tags = [ "ref", "typography", "typeface" ]
                }
            , weightMedium =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.weight-medium"
                , name = "md.ref.typeface.weight-medium"
                , value = "500"
                , category_id = "ref.typography.typeface"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Medium weight"
                , tags = [ "ref", "typography", "typeface" ]
                }
            , weightRegular =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.weight-regular"
                , name = "md.ref.typeface.weight-regular"
                , value = "400"
                , category_id = "ref.typography.typeface"
                , last_updated = "2022-03-30T17:34:16.000Z"
                , last_updated_by = "Material"
                , description = "Regular weight"
                , tags = [ "ref", "typography", "typeface" ]
                }
            }
        }
    }


md_sys_color_surfaceTint_light : Entity
md_sys_color_surfaceTint_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-tint.light"
    , name = "md.sys.color.surface-tint.light"
    , value = "{md.sys.color.primary}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface tint"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onErrorContainer_light : Entity
md_sys_color_onErrorContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error-container.light"
    , name = "md.sys.color.on-error-container.light"
    , value = "{md.ref.palette.error10}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On error container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onError_light : Entity
md_sys_color_onError_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error.light"
    , name = "md.sys.color.on-error.light"
    , value = "{md.ref.palette.error100}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On error"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_errorContainer_light : Entity
md_sys_color_errorContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error-container.light"
    , name = "md.sys.color.error-container.light"
    , value = "{md.ref.palette.error90}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Error container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onTertiaryContainer_light : Entity
md_sys_color_onTertiaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary-container.light"
    , name = "md.sys.color.on-tertiary-container.light"
    , value = "{md.ref.palette.tertiary10}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On tertiary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onTertiary_light : Entity
md_sys_color_onTertiary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary.light"
    , name = "md.sys.color.on-tertiary.light"
    , value = "{md.ref.palette.tertiary100}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On tertiary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_tertiaryContainer_light : Entity
md_sys_color_tertiaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary-container.light"
    , name = "md.sys.color.tertiary-container.light"
    , value = "{md.ref.palette.tertiary90}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Tertiary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_tertiary_light : Entity
md_sys_color_tertiary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary.light"
    , name = "md.sys.color.tertiary.light"
    , value = "{md.ref.palette.tertiary40}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Tertiary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_shadow_light : Entity
md_sys_color_shadow_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.shadow.light"
    , name = "md.sys.color.shadow.light"
    , value = "{md.ref.palette.neutral0}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Shadow"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_error_light : Entity
md_sys_color_error_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error.light"
    , name = "md.sys.color.error.light"
    , value = "{md.ref.palette.error40}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Error"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_outline_light : Entity
md_sys_color_outline_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.outline.light"
    , name = "md.sys.color.outline.light"
    , value = "{md.ref.palette.neutral-variant50}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Outline"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onBackground_light : Entity
md_sys_color_onBackground_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-background.light"
    , name = "md.sys.color.on-background.light"
    , value = "{md.ref.palette.neutral10}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On background"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_background_light : Entity
md_sys_color_background_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.background.light"
    , name = "md.sys.color.background.light"
    , value = "{md.ref.palette.neutral99}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Background"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_inverseOnSurface_light : Entity
md_sys_color_inverseOnSurface_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-on-surface.light"
    , name = "md.sys.color.inverse-on-surface.light"
    , value = "{md.ref.palette.neutral95}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse on surface"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_inverseSurface_light : Entity
md_sys_color_inverseSurface_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-surface.light"
    , name = "md.sys.color.inverse-surface.light"
    , value = "{md.ref.palette.neutral20}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse surface"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onSurfaceVariant_light : Entity
md_sys_color_onSurfaceVariant_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface-variant.light"
    , name = "md.sys.color.on-surface-variant.light"
    , value = "{md.ref.palette.neutral-variant30}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On surface variant"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onSurface_light : Entity
md_sys_color_onSurface_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface.light"
    , name = "md.sys.color.on-surface.light"
    , value = "{md.ref.palette.neutral10}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On surface"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_surfaceVariant_light : Entity
md_sys_color_surfaceVariant_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-variant.light"
    , name = "md.sys.color.surface-variant.light"
    , value = "{md.ref.palette.neutral-variant90}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface variant"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_surface_light : Entity
md_sys_color_surface_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface.light"
    , name = "md.sys.color.surface.light"
    , value = "{md.ref.palette.neutral99}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onSecondaryContainer_light : Entity
md_sys_color_onSecondaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary-container.light"
    , name = "md.sys.color.on-secondary-container.light"
    , value = "{md.ref.palette.secondary10}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On secondary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onSecondary_light : Entity
md_sys_color_onSecondary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary.light"
    , name = "md.sys.color.on-secondary.light"
    , value = "{md.ref.palette.secondary100}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On secondary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_secondaryContainer_light : Entity
md_sys_color_secondaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary-container.light"
    , name = "md.sys.color.secondary-container.light"
    , value = "{md.ref.palette.secondary90}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Secondary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_secondary_light : Entity
md_sys_color_secondary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary.light"
    , name = "md.sys.color.secondary.light"
    , value = "{md.ref.palette.secondary40}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Secondary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_inversePrimary_light : Entity
md_sys_color_inversePrimary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-primary.light"
    , name = "md.sys.color.inverse-primary.light"
    , value = "{md.ref.palette.primary80}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse primary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onPrimaryContainer_light : Entity
md_sys_color_onPrimaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary-container.light"
    , name = "md.sys.color.on-primary-container.light"
    , value = "{md.ref.palette.primary10}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On primary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onPrimary_light : Entity
md_sys_color_onPrimary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary.light"
    , name = "md.sys.color.on-primary.light"
    , value = "{md.ref.palette.primary100}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On primary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_primaryContainer_light : Entity
md_sys_color_primaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary-container.light"
    , name = "md.sys.color.primary-container.light"
    , value = "{md.ref.palette.primary90}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Primary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_primary_light : Entity
md_sys_color_primary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary.light"
    , name = "md.sys.color.primary.light"
    , value = "{md.ref.palette.primary40}"
    , category_id = "sys.color.light"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Primary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_surfaceTint_dark : Entity
md_sys_color_surfaceTint_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-tint.dark"
    , name = "md.sys.color.surface-tint.dark"
    , value = "{md.sys.color.primary}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface tint"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onErrorContainer_dark : Entity
md_sys_color_onErrorContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error-container.dark"
    , name = "md.sys.color.on-error-container.dark"
    , value = "{md.ref.palette.error80}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On error container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onError_dark : Entity
md_sys_color_onError_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error.dark"
    , name = "md.sys.color.on-error.dark"
    , value = "{md.ref.palette.error20}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On error"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_errorContainer_dark : Entity
md_sys_color_errorContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error-container.dark"
    , name = "md.sys.color.error-container.dark"
    , value = "{md.ref.palette.error30}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Error container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onTertiaryContainer_dark : Entity
md_sys_color_onTertiaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary-container.dark"
    , name = "md.sys.color.on-tertiary-container.dark"
    , value = "{md.ref.palette.tertiary90}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On tertiary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onTertiary_dark : Entity
md_sys_color_onTertiary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary.dark"
    , name = "md.sys.color.on-tertiary.dark"
    , value = "{md.ref.palette.tertiary20}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On tertiary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_tertiaryContainer_dark : Entity
md_sys_color_tertiaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary-container.dark"
    , name = "md.sys.color.tertiary-container.dark"
    , value = "{md.ref.palette.tertiary30}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Tertiary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_tertiary_dark : Entity
md_sys_color_tertiary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary.dark"
    , name = "md.sys.color.tertiary.dark"
    , value = "{md.ref.palette.tertiary80}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Tertiary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_shadow_dark : Entity
md_sys_color_shadow_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.shadow.dark"
    , name = "md.sys.color.shadow.dark"
    , value = "{md.ref.palette.neutral0}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Shadow"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_error_dark : Entity
md_sys_color_error_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error.dark"
    , name = "md.sys.color.error.dark"
    , value = "{md.ref.palette.error80}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Error"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_outline_dark : Entity
md_sys_color_outline_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.outline.dark"
    , name = "md.sys.color.outline.dark"
    , value = "{md.ref.palette.neutral-variant60}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Outline"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onBackground_dark : Entity
md_sys_color_onBackground_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-background.dark"
    , name = "md.sys.color.on-background.dark"
    , value = "{md.ref.palette.neutral90}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On background"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_background_dark : Entity
md_sys_color_background_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.background.dark"
    , name = "md.sys.color.background.dark"
    , value = "{md.ref.palette.neutral10}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Background"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_inverseOnSurface_dark : Entity
md_sys_color_inverseOnSurface_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-on-surface.dark"
    , name = "md.sys.color.inverse-on-surface.dark"
    , value = "{md.ref.palette.neutral20}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse on surface"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_inverseSurface_dark : Entity
md_sys_color_inverseSurface_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-surface.dark"
    , name = "md.sys.color.inverse-surface.dark"
    , value = "{md.ref.palette.neutral90}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse surface"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onSurfaceVariant_dark : Entity
md_sys_color_onSurfaceVariant_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface-variant.dark"
    , name = "md.sys.color.on-surface-variant.dark"
    , value = "{md.ref.palette.neutral-variant80}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On surface variant"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onSurface_dark : Entity
md_sys_color_onSurface_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface.dark"
    , name = "md.sys.color.on-surface.dark"
    , value = "{md.ref.palette.neutral90}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On surface"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_surfaceVariant_dark : Entity
md_sys_color_surfaceVariant_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-variant.dark"
    , name = "md.sys.color.surface-variant.dark"
    , value = "{md.ref.palette.neutral-variant30}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface variant"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_surface_dark : Entity
md_sys_color_surface_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface.dark"
    , name = "md.sys.color.surface.dark"
    , value = "{md.ref.palette.neutral10}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onSecondaryContainer_dark : Entity
md_sys_color_onSecondaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary-container.dark"
    , name = "md.sys.color.on-secondary-container.dark"
    , value = "{md.ref.palette.secondary90}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On secondary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onSecondary_dark : Entity
md_sys_color_onSecondary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary.dark"
    , name = "md.sys.color.on-secondary.dark"
    , value = "{md.ref.palette.secondary20}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On secondary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_secondaryContainer_dark : Entity
md_sys_color_secondaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary-container.dark"
    , name = "md.sys.color.secondary-container.dark"
    , value = "{md.ref.palette.secondary30}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Secondary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_secondary_dark : Entity
md_sys_color_secondary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary.dark"
    , name = "md.sys.color.secondary.dark"
    , value = "{md.ref.palette.secondary80}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Secondary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_inversePrimary_dark : Entity
md_sys_color_inversePrimary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-primary.dark"
    , name = "md.sys.color.inverse-primary.dark"
    , value = "{md.ref.palette.primary40}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse primary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onPrimaryContainer_dark : Entity
md_sys_color_onPrimaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary-container.dark"
    , name = "md.sys.color.on-primary-container.dark"
    , value = "{md.ref.palette.primary90}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On primary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onPrimary_dark : Entity
md_sys_color_onPrimary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary.dark"
    , name = "md.sys.color.on-primary.dark"
    , value = "{md.ref.palette.primary20}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On primary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_primaryContainer_dark : Entity
md_sys_color_primaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary-container.dark"
    , name = "md.sys.color.primary-container.dark"
    , value = "{md.ref.palette.primary30}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Primary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_primary_dark : Entity
md_sys_color_primary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary.dark"
    , name = "md.sys.color.primary.dark"
    , value = "{md.ref.palette.primary80}"
    , category_id = "sys.color.dark"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Primary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_surfaceTint : Entity
md_sys_color_surfaceTint =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-tint"
    , name = "md.sys.color.surface-tint"
    , value = "{md.sys.color.surface-tint.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface tint"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onErrorContainer : Entity
md_sys_color_onErrorContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error-container"
    , name = "md.sys.color.on-error-container"
    , value = "{md.sys.color.on-error-container.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On error container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onError : Entity
md_sys_color_onError =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error"
    , name = "md.sys.color.on-error"
    , value = "{md.sys.color.on-error.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On error"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_errorContainer : Entity
md_sys_color_errorContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error-container"
    , name = "md.sys.color.error-container"
    , value = "{md.sys.color.error-container.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Error container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onTertiaryContainer : Entity
md_sys_color_onTertiaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary-container"
    , name = "md.sys.color.on-tertiary-container"
    , value = "{md.sys.color.on-tertiary-container.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On tertiary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onTertiary : Entity
md_sys_color_onTertiary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary"
    , name = "md.sys.color.on-tertiary"
    , value = "{md.sys.color.on-tertiary.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On tertiary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_tertiaryContainer : Entity
md_sys_color_tertiaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary-container"
    , name = "md.sys.color.tertiary-container"
    , value = "{md.sys.color.tertiary-container.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Tertiary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_tertiary : Entity
md_sys_color_tertiary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary"
    , name = "md.sys.color.tertiary"
    , value = "{md.sys.color.tertiary.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Tertiary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_shadow : Entity
md_sys_color_shadow =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.shadow"
    , name = "md.sys.color.shadow"
    , value = "{md.sys.color.shadow.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Shadow"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_error : Entity
md_sys_color_error =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error"
    , name = "md.sys.color.error"
    , value = "{md.sys.color.error.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Error"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_outline : Entity
md_sys_color_outline =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.outline"
    , name = "md.sys.color.outline"
    , value = "{md.sys.color.outline.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Outline"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onBackground : Entity
md_sys_color_onBackground =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-background"
    , name = "md.sys.color.on-background"
    , value = "{md.sys.color.on-background.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On background"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_background : Entity
md_sys_color_background =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.background"
    , name = "md.sys.color.background"
    , value = "{md.sys.color.background.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Background"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_inverseOnSurface : Entity
md_sys_color_inverseOnSurface =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-on-surface"
    , name = "md.sys.color.inverse-on-surface"
    , value = "{md.sys.color.inverse-on-surface.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse on surface"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_inverseSurface : Entity
md_sys_color_inverseSurface =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-surface"
    , name = "md.sys.color.inverse-surface"
    , value = "{md.sys.color.inverse-surface.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse surface"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onSurfaceVariant : Entity
md_sys_color_onSurfaceVariant =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface-variant"
    , name = "md.sys.color.on-surface-variant"
    , value = "{md.sys.color.on-surface-variant.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On surface variant"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onSurface : Entity
md_sys_color_onSurface =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface"
    , name = "md.sys.color.on-surface"
    , value = "{md.sys.color.on-surface.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On surface"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_surfaceVariant : Entity
md_sys_color_surfaceVariant =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-variant"
    , name = "md.sys.color.surface-variant"
    , value = "{md.sys.color.surface-variant.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface variant"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_surface : Entity
md_sys_color_surface =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface"
    , name = "md.sys.color.surface"
    , value = "{md.sys.color.surface.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Surface"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onSecondaryContainer : Entity
md_sys_color_onSecondaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary-container"
    , name = "md.sys.color.on-secondary-container"
    , value = "{md.sys.color.on-secondary-container.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On secondary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onSecondary : Entity
md_sys_color_onSecondary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary"
    , name = "md.sys.color.on-secondary"
    , value = "{md.sys.color.on-secondary.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On secondary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_secondaryContainer : Entity
md_sys_color_secondaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary-container"
    , name = "md.sys.color.secondary-container"
    , value = "{md.sys.color.secondary-container.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Secondary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_secondary : Entity
md_sys_color_secondary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary"
    , name = "md.sys.color.secondary"
    , value = "{md.sys.color.secondary.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Secondary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_inversePrimary : Entity
md_sys_color_inversePrimary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-primary"
    , name = "md.sys.color.inverse-primary"
    , value = "{md.sys.color.inverse-primary.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Inverse primary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onPrimaryContainer : Entity
md_sys_color_onPrimaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary-container"
    , name = "md.sys.color.on-primary-container"
    , value = "{md.sys.color.on-primary-container.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On primary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onPrimary : Entity
md_sys_color_onPrimary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary"
    , name = "md.sys.color.on-primary"
    , value = "{md.sys.color.on-primary.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "On primary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_primaryContainer : Entity
md_sys_color_primaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary-container"
    , name = "md.sys.color.primary-container"
    , value = "{md.sys.color.primary-container.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Primary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_primary : Entity
md_sys_color_primary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary"
    , name = "md.sys.color.primary"
    , value = "{md.sys.color.primary.light}"
    , category_id = "sys.color.theme"
    , last_updated = "2022-03-30T17:34:16.000Z"
    , last_updated_by = "Material"
    , description = "Primary"
    , tags = [ "sys", "color", "theme" ]
    }
