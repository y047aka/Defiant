module DesignToken.Token exposing (..)

{-|

@docs Entity
@docs md

-}


type alias Entity =
    { class : String
    , type_ : String
    , id : String
    , value : String
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
                , value = "#000000ff"
                , description = "Error 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , error10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error10"
                , value = "#410e0bff"
                , description = "Error 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , error20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error20"
                , value = "#601410ff"
                , description = "Error 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , error30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error30"
                , value = "#8c1d18ff"
                , description = "Error 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , error40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error40"
                , value = "#b3261eff"
                , description = "Error 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , error50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error50"
                , value = "#dc362eff"
                , description = "Error 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , error60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error60"
                , value = "#e46962ff"
                , description = "Error 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , error70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error70"
                , value = "#ec928eff"
                , description = "Error 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , error80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error80"
                , value = "#f2b8b5ff"
                , description = "Error 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , error90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error90"
                , value = "#f9dedcff"
                , description = "Error 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , error95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error95"
                , value = "#fceeeeff"
                , description = "Error 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , error99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error99"
                , value = "#fffbf9ff"
                , description = "Error 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , error100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.error100"
                , value = "#ffffffff"
                , description = "Error 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary0"
                , value = "#000000ff"
                , description = "Tertiary 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary10"
                , value = "#31111dff"
                , description = "Tertiary 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary20"
                , value = "#492532ff"
                , description = "Tertiary 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary30"
                , value = "#633b48ff"
                , description = "Tertiary 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary40"
                , value = "#7d5260ff"
                , description = "Tertiary 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary50"
                , value = "#986977ff"
                , description = "Tertiary 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary60"
                , value = "#b58392ff"
                , description = "Tertiary 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary70"
                , value = "#d29dacff"
                , description = "Tertiary 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary80"
                , value = "#efb8c8ff"
                , description = "Tertiary 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary90"
                , value = "#ffd8e4ff"
                , description = "Tertiary 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary95"
                , value = "#ffecf1ff"
                , description = "Tertiary 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary99"
                , value = "#fffbfaff"
                , description = "Tertiary 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , tertiary100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.tertiary100"
                , value = "#ffffffff"
                , description = "Tertiary 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary0"
                , value = "#000000ff"
                , description = "Secondary 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary10"
                , value = "#1d192bff"
                , description = "Secondary 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary20"
                , value = "#332d41ff"
                , description = "Secondary 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary30"
                , value = "#4a4458ff"
                , description = "Secondary 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary40"
                , value = "#625b71ff"
                , description = "Secondary 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary50"
                , value = "#7a7289ff"
                , description = "Secondary 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary60"
                , value = "#958da5ff"
                , description = "Secondary 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary70"
                , value = "#b0a7c0ff"
                , description = "Secondary 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary80"
                , value = "#ccc2dcff"
                , description = "Secondary 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary90"
                , value = "#e8def8ff"
                , description = "Secondary 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary95"
                , value = "#f6edffff"
                , description = "Secondary 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary99"
                , value = "#fffbfeff"
                , description = "Secondary 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , secondary100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.secondary100"
                , value = "#ffffffff"
                , description = "Secondary 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary0"
                , value = "#000000ff"
                , description = "Primary 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary10"
                , value = "#21005dff"
                , description = "Primary 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary20"
                , value = "#381e72ff"
                , description = "Primary 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary30"
                , value = "#4f378bff"
                , description = "Primary 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary40"
                , value = "#6750a4ff"
                , description = "Primary 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary50"
                , value = "#7f67beff"
                , description = "Primary 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary60"
                , value = "#9a82dbff"
                , description = "Primary 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary70"
                , value = "#b69df8ff"
                , description = "Primary 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary80"
                , value = "#d0bcffff"
                , description = "Primary 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary90"
                , value = "#eaddffff"
                , description = "Primary 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary95"
                , value = "#f6edffff"
                , description = "Primary 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary99"
                , value = "#fffbfeff"
                , description = "Primary 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , primary100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.primary100"
                , value = "#ffffffff"
                , description = "Primary 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant0"
                , value = "#000000ff"
                , description = "Neutral Variant 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant10"
                , value = "#1d1a22ff"
                , description = "Neutral Variant 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant20"
                , value = "#322f37ff"
                , description = "Neutral Variant 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant30"
                , value = "#49454fff"
                , description = "Neutral Variant 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant40"
                , value = "#605d66ff"
                , description = "Neutral Variant 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant50"
                , value = "#79747eff"
                , description = "Neutral Variant 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant60"
                , value = "#938f99ff"
                , description = "Neutral Variant 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant70"
                , value = "#aea9b4ff"
                , description = "Neutral Variant 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant80"
                , value = "#cac4d0ff"
                , description = "Neutral Variant 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant90"
                , value = "#e7e0ecff"
                , description = "Neutral Variant 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant95"
                , value = "#f5eefaff"
                , description = "Neutral Variant 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant99"
                , value = "#fffbfeff"
                , description = "Neutral Variant 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutralVariant100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral-variant100"
                , value = "#ffffffff"
                , description = "Neutral Variant 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral0 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral0"
                , value = "#000000ff"
                , description = "Neutral 0"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral10 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral10"
                , value = "#1c1b1fff"
                , description = "Neutral 10"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral20 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral20"
                , value = "#313033ff"
                , description = "Neutral 20"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral30 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral30"
                , value = "#484649ff"
                , description = "Neutral 30"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral40 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral40"
                , value = "#605d62ff"
                , description = "Neutral 40"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral50 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral50"
                , value = "#787579ff"
                , description = "Neutral 50"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral60 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral60"
                , value = "#939094ff"
                , description = "Neutral 60"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral70 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral70"
                , value = "#aeaaaeff"
                , description = "Neutral 70"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral80 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral80"
                , value = "#c9c5caff"
                , description = "Neutral 80"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral90 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral90"
                , value = "#e6e1e5ff"
                , description = "Neutral 90"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral95 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral95"
                , value = "#f4eff4ff"
                , description = "Neutral 95"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral99 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral99"
                , value = "#fffbfeff"
                , description = "Neutral 99"
                , tags = [ "ref", "color", "palette" ]
                }
            , neutral100 =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.neutral100"
                , value = "#ffffffff"
                , description = "Neutral 100"
                , tags = [ "ref", "color", "palette" ]
                }
            , black =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.black"
                , value = "#000000ff"
                , description = "Black"
                , tags = [ "ref", "color", "palette" ]
                }
            , white =
                { class = "token"
                , type_ = "color"
                , id = "md.ref.palette.white"
                , value = "#ffffffff"
                , description = "White"
                , tags = [ "ref", "color", "palette" ]
                }
            }
        , typeface =
            { plain =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.plain"
                , value = "Roboto"
                , description = "Plain typeface"
                , tags = [ "ref", "typography", "typeface" ]
                }
            , brand =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.brand"
                , value = "Roboto"
                , description = "Brand typeface"
                , tags = [ "ref", "typography", "typeface" ]
                }
            , weightBold =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.weight-bold"
                , value = "700"
                , description = "Bold weight"
                , tags = [ "ref", "typography", "typeface" ]
                }
            , weightMedium =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.weight-medium"
                , value = "500"
                , description = "Medium weight"
                , tags = [ "ref", "typography", "typeface" ]
                }
            , weightRegular =
                { class = "token"
                , type_ = "custom"
                , id = "md.ref.typeface.weight-regular"
                , value = "400"
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
    , value = md_sys_color_primary.value
    , description = "Surface tint"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onErrorContainer_light : Entity
md_sys_color_onErrorContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error-container.light"
    , value = md.ref.palette.error10.value
    , description = "On error container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onError_light : Entity
md_sys_color_onError_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error.light"
    , value = md.ref.palette.error100.value
    , description = "On error"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_errorContainer_light : Entity
md_sys_color_errorContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error-container.light"
    , value = md.ref.palette.error90.value
    , description = "Error container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onTertiaryContainer_light : Entity
md_sys_color_onTertiaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary-container.light"
    , value = md.ref.palette.tertiary10.value
    , description = "On tertiary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onTertiary_light : Entity
md_sys_color_onTertiary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary.light"
    , value = md.ref.palette.tertiary100.value
    , description = "On tertiary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_tertiaryContainer_light : Entity
md_sys_color_tertiaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary-container.light"
    , value = md.ref.palette.tertiary90.value
    , description = "Tertiary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_tertiary_light : Entity
md_sys_color_tertiary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary.light"
    , value = md.ref.palette.tertiary40.value
    , description = "Tertiary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_shadow_light : Entity
md_sys_color_shadow_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.shadow.light"
    , value = md.ref.palette.neutral0.value
    , description = "Shadow"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_error_light : Entity
md_sys_color_error_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error.light"
    , value = md.ref.palette.error40.value
    , description = "Error"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_outline_light : Entity
md_sys_color_outline_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.outline.light"
    , value = md.ref.palette.neutralVariant50.value
    , description = "Outline"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onBackground_light : Entity
md_sys_color_onBackground_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-background.light"
    , value = md.ref.palette.neutral10.value
    , description = "On background"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_background_light : Entity
md_sys_color_background_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.background.light"
    , value = md.ref.palette.neutral99.value
    , description = "Background"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_inverseOnSurface_light : Entity
md_sys_color_inverseOnSurface_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-on-surface.light"
    , value = md.ref.palette.neutral95.value
    , description = "Inverse on surface"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_inverseSurface_light : Entity
md_sys_color_inverseSurface_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-surface.light"
    , value = md.ref.palette.neutral20.value
    , description = "Inverse surface"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onSurfaceVariant_light : Entity
md_sys_color_onSurfaceVariant_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface-variant.light"
    , value = md.ref.palette.neutralVariant30.value
    , description = "On surface variant"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onSurface_light : Entity
md_sys_color_onSurface_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface.light"
    , value = md.ref.palette.neutral10.value
    , description = "On surface"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_surfaceVariant_light : Entity
md_sys_color_surfaceVariant_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-variant.light"
    , value = md.ref.palette.neutralVariant90.value
    , description = "Surface variant"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_surface_light : Entity
md_sys_color_surface_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface.light"
    , value = md.ref.palette.neutral99.value
    , description = "Surface"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onSecondaryContainer_light : Entity
md_sys_color_onSecondaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary-container.light"
    , value = md.ref.palette.secondary10.value
    , description = "On secondary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onSecondary_light : Entity
md_sys_color_onSecondary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary.light"
    , value = md.ref.palette.secondary100.value
    , description = "On secondary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_secondaryContainer_light : Entity
md_sys_color_secondaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary-container.light"
    , value = md.ref.palette.secondary90.value
    , description = "Secondary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_secondary_light : Entity
md_sys_color_secondary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary.light"
    , value = md.ref.palette.secondary40.value
    , description = "Secondary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_inversePrimary_light : Entity
md_sys_color_inversePrimary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-primary.light"
    , value = md.ref.palette.primary80.value
    , description = "Inverse primary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onPrimaryContainer_light : Entity
md_sys_color_onPrimaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary-container.light"
    , value = md.ref.palette.primary10.value
    , description = "On primary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_onPrimary_light : Entity
md_sys_color_onPrimary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary.light"
    , value = md.ref.palette.primary100.value
    , description = "On primary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_primaryContainer_light : Entity
md_sys_color_primaryContainer_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary-container.light"
    , value = md.ref.palette.primary90.value
    , description = "Primary container"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_primary_light : Entity
md_sys_color_primary_light =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary.light"
    , value = md.ref.palette.primary40.value
    , description = "Primary"
    , tags = [ "sys", "color", "light" ]
    }


md_sys_color_surfaceTint_dark : Entity
md_sys_color_surfaceTint_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-tint.dark"
    , value = md_sys_color_primary.value
    , description = "Surface tint"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onErrorContainer_dark : Entity
md_sys_color_onErrorContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error-container.dark"
    , value = md.ref.palette.error80.value
    , description = "On error container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onError_dark : Entity
md_sys_color_onError_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error.dark"
    , value = md.ref.palette.error20.value
    , description = "On error"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_errorContainer_dark : Entity
md_sys_color_errorContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error-container.dark"
    , value = md.ref.palette.error30.value
    , description = "Error container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onTertiaryContainer_dark : Entity
md_sys_color_onTertiaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary-container.dark"
    , value = md.ref.palette.tertiary90.value
    , description = "On tertiary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onTertiary_dark : Entity
md_sys_color_onTertiary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary.dark"
    , value = md.ref.palette.tertiary20.value
    , description = "On tertiary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_tertiaryContainer_dark : Entity
md_sys_color_tertiaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary-container.dark"
    , value = md.ref.palette.tertiary30.value
    , description = "Tertiary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_tertiary_dark : Entity
md_sys_color_tertiary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary.dark"
    , value = md.ref.palette.tertiary80.value
    , description = "Tertiary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_shadow_dark : Entity
md_sys_color_shadow_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.shadow.dark"
    , value = md.ref.palette.neutral0.value
    , description = "Shadow"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_error_dark : Entity
md_sys_color_error_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error.dark"
    , value = md.ref.palette.error80.value
    , description = "Error"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_outline_dark : Entity
md_sys_color_outline_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.outline.dark"
    , value = md.ref.palette.neutralVariant60.value
    , description = "Outline"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onBackground_dark : Entity
md_sys_color_onBackground_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-background.dark"
    , value = md.ref.palette.neutral90.value
    , description = "On background"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_background_dark : Entity
md_sys_color_background_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.background.dark"
    , value = md.ref.palette.neutral10.value
    , description = "Background"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_inverseOnSurface_dark : Entity
md_sys_color_inverseOnSurface_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-on-surface.dark"
    , value = md.ref.palette.neutral20.value
    , description = "Inverse on surface"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_inverseSurface_dark : Entity
md_sys_color_inverseSurface_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-surface.dark"
    , value = md.ref.palette.neutral90.value
    , description = "Inverse surface"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onSurfaceVariant_dark : Entity
md_sys_color_onSurfaceVariant_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface-variant.dark"
    , value = md.ref.palette.neutralVariant80.value
    , description = "On surface variant"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onSurface_dark : Entity
md_sys_color_onSurface_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface.dark"
    , value = md.ref.palette.neutral90.value
    , description = "On surface"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_surfaceVariant_dark : Entity
md_sys_color_surfaceVariant_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-variant.dark"
    , value = md.ref.palette.neutralVariant30.value
    , description = "Surface variant"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_surface_dark : Entity
md_sys_color_surface_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface.dark"
    , value = md.ref.palette.neutral10.value
    , description = "Surface"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onSecondaryContainer_dark : Entity
md_sys_color_onSecondaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary-container.dark"
    , value = md.ref.palette.secondary90.value
    , description = "On secondary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onSecondary_dark : Entity
md_sys_color_onSecondary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary.dark"
    , value = md.ref.palette.secondary20.value
    , description = "On secondary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_secondaryContainer_dark : Entity
md_sys_color_secondaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary-container.dark"
    , value = md.ref.palette.secondary30.value
    , description = "Secondary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_secondary_dark : Entity
md_sys_color_secondary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary.dark"
    , value = md.ref.palette.secondary80.value
    , description = "Secondary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_inversePrimary_dark : Entity
md_sys_color_inversePrimary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-primary.dark"
    , value = md.ref.palette.primary40.value
    , description = "Inverse primary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onPrimaryContainer_dark : Entity
md_sys_color_onPrimaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary-container.dark"
    , value = md.ref.palette.primary90.value
    , description = "On primary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_onPrimary_dark : Entity
md_sys_color_onPrimary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary.dark"
    , value = md.ref.palette.primary20.value
    , description = "On primary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_primaryContainer_dark : Entity
md_sys_color_primaryContainer_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary-container.dark"
    , value = md.ref.palette.primary30.value
    , description = "Primary container"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_primary_dark : Entity
md_sys_color_primary_dark =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary.dark"
    , value = md.ref.palette.primary80.value
    , description = "Primary"
    , tags = [ "sys", "color", "dark" ]
    }


md_sys_color_surfaceTint : Entity
md_sys_color_surfaceTint =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-tint"
    , value = md_sys_color_surfaceTint_light.value
    , description = "Surface tint"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onErrorContainer : Entity
md_sys_color_onErrorContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error-container"
    , value = md_sys_color_onErrorContainer_light.value
    , description = "On error container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onError : Entity
md_sys_color_onError =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-error"
    , value = md_sys_color_onError_light.value
    , description = "On error"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_errorContainer : Entity
md_sys_color_errorContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error-container"
    , value = md_sys_color_errorContainer_light.value
    , description = "Error container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onTertiaryContainer : Entity
md_sys_color_onTertiaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary-container"
    , value = md_sys_color_onTertiaryContainer_light.value
    , description = "On tertiary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onTertiary : Entity
md_sys_color_onTertiary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-tertiary"
    , value = md_sys_color_onTertiary_light.value
    , description = "On tertiary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_tertiaryContainer : Entity
md_sys_color_tertiaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary-container"
    , value = md_sys_color_tertiaryContainer_light.value
    , description = "Tertiary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_tertiary : Entity
md_sys_color_tertiary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.tertiary"
    , value = md_sys_color_tertiary_light.value
    , description = "Tertiary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_shadow : Entity
md_sys_color_shadow =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.shadow"
    , value = md_sys_color_shadow_light.value
    , description = "Shadow"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_error : Entity
md_sys_color_error =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.error"
    , value = md_sys_color_error_light.value
    , description = "Error"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_outline : Entity
md_sys_color_outline =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.outline"
    , value = md_sys_color_outline_light.value
    , description = "Outline"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onBackground : Entity
md_sys_color_onBackground =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-background"
    , value = md_sys_color_onBackground_light.value
    , description = "On background"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_background : Entity
md_sys_color_background =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.background"
    , value = md_sys_color_background_light.value
    , description = "Background"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_inverseOnSurface : Entity
md_sys_color_inverseOnSurface =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-on-surface"
    , value = md_sys_color_inverseOnSurface_light.value
    , description = "Inverse on surface"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_inverseSurface : Entity
md_sys_color_inverseSurface =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-surface"
    , value = md_sys_color_inverseSurface_light.value
    , description = "Inverse surface"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onSurfaceVariant : Entity
md_sys_color_onSurfaceVariant =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface-variant"
    , value = md_sys_color_onSurfaceVariant_light.value
    , description = "On surface variant"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onSurface : Entity
md_sys_color_onSurface =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-surface"
    , value = md_sys_color_onSurface_light.value
    , description = "On surface"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_surfaceVariant : Entity
md_sys_color_surfaceVariant =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface-variant"
    , value = md_sys_color_surfaceVariant_light.value
    , description = "Surface variant"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_surface : Entity
md_sys_color_surface =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.surface"
    , value = md_sys_color_surface_light.value
    , description = "Surface"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onSecondaryContainer : Entity
md_sys_color_onSecondaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary-container"
    , value = md_sys_color_onSecondaryContainer_light.value
    , description = "On secondary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onSecondary : Entity
md_sys_color_onSecondary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-secondary"
    , value = md_sys_color_onSecondary_light.value
    , description = "On secondary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_secondaryContainer : Entity
md_sys_color_secondaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary-container"
    , value = md_sys_color_secondaryContainer_light.value
    , description = "Secondary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_secondary : Entity
md_sys_color_secondary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.secondary"
    , value = md_sys_color_secondary_light.value
    , description = "Secondary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_inversePrimary : Entity
md_sys_color_inversePrimary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.inverse-primary"
    , value = md_sys_color_inversePrimary_light.value
    , description = "Inverse primary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onPrimaryContainer : Entity
md_sys_color_onPrimaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary-container"
    , value = md_sys_color_onPrimaryContainer_light.value
    , description = "On primary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_onPrimary : Entity
md_sys_color_onPrimary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.on-primary"
    , value = md_sys_color_onPrimary_light.value
    , description = "On primary"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_primaryContainer : Entity
md_sys_color_primaryContainer =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary-container"
    , value = md_sys_color_primaryContainer_light.value
    , description = "Primary container"
    , tags = [ "sys", "color", "theme" ]
    }


md_sys_color_primary : Entity
md_sys_color_primary =
    { class = "token"
    , type_ = "alias"
    , id = "md.sys.color.primary"
    , value = md_sys_color_primary_light.value
    , description = "Primary"
    , tags = [ "sys", "color", "theme" ]
    }
