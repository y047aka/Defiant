module DesignToken.Token exposing (..)

{-|

@docs Entity
@docs md

-}


type alias Entity =
    { type_ : String, value : String }


{-| <https://github.com/material-foundation/material-tokens/blob/main/dsp/data/tokens.json>
-}
md =
    { ref =
        { palette =
            { error0 =
                { type_ = "color"
                , value = "#000000ff"
                }
            , error10 =
                { type_ = "color"
                , value = "#410e0bff"
                }
            , error20 =
                { type_ = "color"
                , value = "#601410ff"
                }
            , error30 =
                { type_ = "color"
                , value = "#8c1d18ff"
                }
            , error40 =
                { type_ = "color"
                , value = "#b3261eff"
                }
            , error50 =
                { type_ = "color"
                , value = "#dc362eff"
                }
            , error60 =
                { type_ = "color"
                , value = "#e46962ff"
                }
            , error70 =
                { type_ = "color"
                , value = "#ec928eff"
                }
            , error80 =
                { type_ = "color"
                , value = "#f2b8b5ff"
                }
            , error90 =
                { type_ = "color"
                , value = "#f9dedcff"
                }
            , error95 =
                { type_ = "color"
                , value = "#fceeeeff"
                }
            , error99 =
                { type_ = "color"
                , value = "#fffbf9ff"
                }
            , error100 =
                { type_ = "color"
                , value = "#ffffffff"
                }
            , tertiary0 =
                { type_ = "color"
                , value = "#000000ff"
                }
            , tertiary10 =
                { type_ = "color"
                , value = "#31111dff"
                }
            , tertiary20 =
                { type_ = "color"
                , value = "#492532ff"
                }
            , tertiary30 =
                { type_ = "color"
                , value = "#633b48ff"
                }
            , tertiary40 =
                { type_ = "color"
                , value = "#7d5260ff"
                }
            , tertiary50 =
                { type_ = "color"
                , value = "#986977ff"
                }
            , tertiary60 =
                { type_ = "color"
                , value = "#b58392ff"
                }
            , tertiary70 =
                { type_ = "color"
                , value = "#d29dacff"
                }
            , tertiary80 =
                { type_ = "color"
                , value = "#efb8c8ff"
                }
            , tertiary90 =
                { type_ = "color"
                , value = "#ffd8e4ff"
                }
            , tertiary95 =
                { type_ = "color"
                , value = "#ffecf1ff"
                }
            , tertiary99 =
                { type_ = "color"
                , value = "#fffbfaff"
                }
            , tertiary100 =
                { type_ = "color"
                , value = "#ffffffff"
                }
            , secondary0 =
                { type_ = "color"
                , value = "#000000ff"
                }
            , secondary10 =
                { type_ = "color"
                , value = "#1d192bff"
                }
            , secondary20 =
                { type_ = "color"
                , value = "#332d41ff"
                }
            , secondary30 =
                { type_ = "color"
                , value = "#4a4458ff"
                }
            , secondary40 =
                { type_ = "color"
                , value = "#625b71ff"
                }
            , secondary50 =
                { type_ = "color"
                , value = "#7a7289ff"
                }
            , secondary60 =
                { type_ = "color"
                , value = "#958da5ff"
                }
            , secondary70 =
                { type_ = "color"
                , value = "#b0a7c0ff"
                }
            , secondary80 =
                { type_ = "color"
                , value = "#ccc2dcff"
                }
            , secondary90 =
                { type_ = "color"
                , value = "#e8def8ff"
                }
            , secondary95 =
                { type_ = "color"
                , value = "#f6edffff"
                }
            , secondary99 =
                { type_ = "color"
                , value = "#fffbfeff"
                }
            , secondary100 =
                { type_ = "color"
                , value = "#ffffffff"
                }
            , primary0 =
                { type_ = "color"
                , value = "#000000ff"
                }
            , primary10 =
                { type_ = "color"
                , value = "#21005dff"
                }
            , primary20 =
                { type_ = "color"
                , value = "#381e72ff"
                }
            , primary30 =
                { type_ = "color"
                , value = "#4f378bff"
                }
            , primary40 =
                { type_ = "color"
                , value = "#6750a4ff"
                }
            , primary50 =
                { type_ = "color"
                , value = "#7f67beff"
                }
            , primary60 =
                { type_ = "color"
                , value = "#9a82dbff"
                }
            , primary70 =
                { type_ = "color"
                , value = "#b69df8ff"
                }
            , primary80 =
                { type_ = "color"
                , value = "#d0bcffff"
                }
            , primary90 =
                { type_ = "color"
                , value = "#eaddffff"
                }
            , primary95 =
                { type_ = "color"
                , value = "#f6edffff"
                }
            , primary99 =
                { type_ = "color"
                , value = "#fffbfeff"
                }
            , primary100 =
                { type_ = "color"
                , value = "#ffffffff"
                }
            , neutralVariant0 =
                { type_ = "color"
                , value = "#000000ff"
                }
            , neutralVariant10 =
                { type_ = "color"
                , value = "#1d1a22ff"
                }
            , neutralVariant20 =
                { type_ = "color"
                , value = "#322f37ff"
                }
            , neutralVariant30 =
                { type_ = "color"
                , value = "#49454fff"
                }
            , neutralVariant40 =
                { type_ = "color"
                , value = "#605d66ff"
                }
            , neutralVariant50 =
                { type_ = "color"
                , value = "#79747eff"
                }
            , neutralVariant60 =
                { type_ = "color"
                , value = "#938f99ff"
                }
            , neutralVariant70 =
                { type_ = "color"
                , value = "#aea9b4ff"
                }
            , neutralVariant80 =
                { type_ = "color"
                , value = "#cac4d0ff"
                }
            , neutralVariant90 =
                { type_ = "color"
                , value = "#e7e0ecff"
                }
            , neutralVariant95 =
                { type_ = "color"
                , value = "#f5eefaff"
                }
            , neutralVariant99 =
                { type_ = "color"
                , value = "#fffbfeff"
                }
            , neutralVariant100 =
                { type_ = "color"
                , value = "#ffffffff"
                }
            , neutral0 =
                { type_ = "color"
                , value = "#000000ff"
                }
            , neutral10 =
                { type_ = "color"
                , value = "#1c1b1fff"
                }
            , neutral20 =
                { type_ = "color"
                , value = "#313033ff"
                }
            , neutral30 =
                { type_ = "color"
                , value = "#484649ff"
                }
            , neutral40 =
                { type_ = "color"
                , value = "#605d62ff"
                }
            , neutral50 =
                { type_ = "color"
                , value = "#787579ff"
                }
            , neutral60 =
                { type_ = "color"
                , value = "#939094ff"
                }
            , neutral70 =
                { type_ = "color"
                , value = "#aeaaaeff"
                }
            , neutral80 =
                { type_ = "color"
                , value = "#c9c5caff"
                }
            , neutral90 =
                { type_ = "color"
                , value = "#e6e1e5ff"
                }
            , neutral95 =
                { type_ = "color"
                , value = "#f4eff4ff"
                }
            , neutral99 =
                { type_ = "color"
                , value = "#fffbfeff"
                }
            , neutral100 =
                { type_ = "color"
                , value = "#ffffffff"
                }
            , black =
                { type_ = "color"
                , value = "#000000ff"
                }
            , white =
                { type_ = "color"
                , value = "#ffffffff"
                }
            }
        , typeface =
            { plain =
                { type_ = "custom"
                , value = "Roboto"
                }
            , brand =
                { type_ = "custom"
                , value = "Roboto"
                }
            , weightBold =
                { type_ = "custom"
                , value = "700"
                }
            , weightMedium =
                { type_ = "custom"
                , value = "500"
                }
            , weightRegular =
                { type_ = "custom"
                , value = "400"
                }
            }
        }
    }


md_sys_color_surfaceTint_light : Entity
md_sys_color_surfaceTint_light =
    { type_ = "alias"
    , value = md_sys_color_primary.value
    }


md_sys_color_onErrorContainer_light : Entity
md_sys_color_onErrorContainer_light =
    { type_ = "alias"
    , value = md.ref.palette.error10.value
    }


md_sys_color_onError_light : Entity
md_sys_color_onError_light =
    { type_ = "alias"
    , value = md.ref.palette.error100.value
    }


md_sys_color_errorContainer_light : Entity
md_sys_color_errorContainer_light =
    { type_ = "alias"
    , value = md.ref.palette.error90.value
    }


md_sys_color_onTertiaryContainer_light : Entity
md_sys_color_onTertiaryContainer_light =
    { type_ = "alias"
    , value = md.ref.palette.tertiary10.value
    }


md_sys_color_onTertiary_light : Entity
md_sys_color_onTertiary_light =
    { type_ = "alias"
    , value = md.ref.palette.tertiary100.value
    }


md_sys_color_tertiaryContainer_light : Entity
md_sys_color_tertiaryContainer_light =
    { type_ = "alias"
    , value = md.ref.palette.tertiary90.value
    }


md_sys_color_tertiary_light : Entity
md_sys_color_tertiary_light =
    { type_ = "alias"
    , value = md.ref.palette.tertiary40.value
    }


md_sys_color_shadow_light : Entity
md_sys_color_shadow_light =
    { type_ = "alias"
    , value = md.ref.palette.neutral0.value
    }


md_sys_color_error_light : Entity
md_sys_color_error_light =
    { type_ = "alias"
    , value = md.ref.palette.error40.value
    }


md_sys_color_outline_light : Entity
md_sys_color_outline_light =
    { type_ = "alias"
    , value = md.ref.palette.neutralVariant50.value
    }


md_sys_color_onBackground_light : Entity
md_sys_color_onBackground_light =
    { type_ = "alias"
    , value = md.ref.palette.neutral10.value
    }


md_sys_color_background_light : Entity
md_sys_color_background_light =
    { type_ = "alias"
    , value = md.ref.palette.neutral99.value
    }


md_sys_color_inverseOnSurface_light : Entity
md_sys_color_inverseOnSurface_light =
    { type_ = "alias"
    , value = md.ref.palette.neutral95.value
    }


md_sys_color_inverseSurface_light : Entity
md_sys_color_inverseSurface_light =
    { type_ = "alias"
    , value = md.ref.palette.neutral20.value
    }


md_sys_color_onSurfaceVariant_light : Entity
md_sys_color_onSurfaceVariant_light =
    { type_ = "alias"
    , value = md.ref.palette.neutralVariant30.value
    }


md_sys_color_onSurface_light : Entity
md_sys_color_onSurface_light =
    { type_ = "alias"
    , value = md.ref.palette.neutral10.value
    }


md_sys_color_surfaceVariant_light : Entity
md_sys_color_surfaceVariant_light =
    { type_ = "alias"
    , value = md.ref.palette.neutralVariant90.value
    }


md_sys_color_surface_light : Entity
md_sys_color_surface_light =
    { type_ = "alias"
    , value = md.ref.palette.neutral99.value
    }


md_sys_color_onSecondaryContainer_light : Entity
md_sys_color_onSecondaryContainer_light =
    { type_ = "alias"
    , value = md.ref.palette.secondary10.value
    }


md_sys_color_onSecondary_light : Entity
md_sys_color_onSecondary_light =
    { type_ = "alias"
    , value = md.ref.palette.secondary100.value
    }


md_sys_color_secondaryContainer_light : Entity
md_sys_color_secondaryContainer_light =
    { type_ = "alias"
    , value = md.ref.palette.secondary90.value
    }


md_sys_color_secondary_light : Entity
md_sys_color_secondary_light =
    { type_ = "alias"
    , value = md.ref.palette.secondary40.value
    }


md_sys_color_inversePrimary_light : Entity
md_sys_color_inversePrimary_light =
    { type_ = "alias"
    , value = md.ref.palette.primary80.value
    }


md_sys_color_onPrimaryContainer_light : Entity
md_sys_color_onPrimaryContainer_light =
    { type_ = "alias"
    , value = md.ref.palette.primary10.value
    }


md_sys_color_onPrimary_light : Entity
md_sys_color_onPrimary_light =
    { type_ = "alias"
    , value = md.ref.palette.primary100.value
    }


md_sys_color_primaryContainer_light : Entity
md_sys_color_primaryContainer_light =
    { type_ = "alias"
    , value = md.ref.palette.primary90.value
    }


md_sys_color_primary_light : Entity
md_sys_color_primary_light =
    { type_ = "alias"
    , value = md.ref.palette.primary40.value
    }


md_sys_color_surfaceTint_dark : Entity
md_sys_color_surfaceTint_dark =
    { type_ = "alias"
    , value = md_sys_color_primary.value
    }


md_sys_color_onErrorContainer_dark : Entity
md_sys_color_onErrorContainer_dark =
    { type_ = "alias"
    , value = md.ref.palette.error80.value
    }


md_sys_color_onError_dark : Entity
md_sys_color_onError_dark =
    { type_ = "alias"
    , value = md.ref.palette.error20.value
    }


md_sys_color_errorContainer_dark : Entity
md_sys_color_errorContainer_dark =
    { type_ = "alias"
    , value = md.ref.palette.error30.value
    }


md_sys_color_onTertiaryContainer_dark : Entity
md_sys_color_onTertiaryContainer_dark =
    { type_ = "alias"
    , value = md.ref.palette.tertiary90.value
    }


md_sys_color_onTertiary_dark : Entity
md_sys_color_onTertiary_dark =
    { type_ = "alias"
    , value = md.ref.palette.tertiary20.value
    }


md_sys_color_tertiaryContainer_dark : Entity
md_sys_color_tertiaryContainer_dark =
    { type_ = "alias"
    , value = md.ref.palette.tertiary30.value
    }


md_sys_color_tertiary_dark : Entity
md_sys_color_tertiary_dark =
    { type_ = "alias"
    , value = md.ref.palette.tertiary80.value
    }


md_sys_color_shadow_dark : Entity
md_sys_color_shadow_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutral0.value
    }


md_sys_color_error_dark : Entity
md_sys_color_error_dark =
    { type_ = "alias"
    , value = md.ref.palette.error80.value
    }


md_sys_color_outline_dark : Entity
md_sys_color_outline_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutralVariant60.value
    }


md_sys_color_onBackground_dark : Entity
md_sys_color_onBackground_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutral90.value
    }


md_sys_color_background_dark : Entity
md_sys_color_background_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutral10.value
    }


md_sys_color_inverseOnSurface_dark : Entity
md_sys_color_inverseOnSurface_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutral20.value
    }


md_sys_color_inverseSurface_dark : Entity
md_sys_color_inverseSurface_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutral90.value
    }


md_sys_color_onSurfaceVariant_dark : Entity
md_sys_color_onSurfaceVariant_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutralVariant80.value
    }


md_sys_color_onSurface_dark : Entity
md_sys_color_onSurface_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutral90.value
    }


md_sys_color_surfaceVariant_dark : Entity
md_sys_color_surfaceVariant_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutralVariant30.value
    }


md_sys_color_surface_dark : Entity
md_sys_color_surface_dark =
    { type_ = "alias"
    , value = md.ref.palette.neutral10.value
    }


md_sys_color_onSecondaryContainer_dark : Entity
md_sys_color_onSecondaryContainer_dark =
    { type_ = "alias"
    , value = md.ref.palette.secondary90.value
    }


md_sys_color_onSecondary_dark : Entity
md_sys_color_onSecondary_dark =
    { type_ = "alias"
    , value = md.ref.palette.secondary20.value
    }


md_sys_color_secondaryContainer_dark : Entity
md_sys_color_secondaryContainer_dark =
    { type_ = "alias"
    , value = md.ref.palette.secondary30.value
    }


md_sys_color_secondary_dark : Entity
md_sys_color_secondary_dark =
    { type_ = "alias"
    , value = md.ref.palette.secondary80.value
    }


md_sys_color_inversePrimary_dark : Entity
md_sys_color_inversePrimary_dark =
    { type_ = "alias"
    , value = md.ref.palette.primary40.value
    }


md_sys_color_onPrimaryContainer_dark : Entity
md_sys_color_onPrimaryContainer_dark =
    { type_ = "alias"
    , value = md.ref.palette.primary90.value
    }


md_sys_color_onPrimary_dark : Entity
md_sys_color_onPrimary_dark =
    { type_ = "alias"
    , value = md.ref.palette.primary20.value
    }


md_sys_color_primaryContainer_dark : Entity
md_sys_color_primaryContainer_dark =
    { type_ = "alias"
    , value = md.ref.palette.primary30.value
    }


md_sys_color_primary_dark : Entity
md_sys_color_primary_dark =
    { type_ = "alias"
    , value = md.ref.palette.primary80.value
    }


md_sys_color_surfaceTint : Entity
md_sys_color_surfaceTint =
    { type_ = "alias"
    , value = md_sys_color_surfaceTint_light.value
    }


md_sys_color_onErrorContainer : Entity
md_sys_color_onErrorContainer =
    { type_ = "alias"
    , value = md_sys_color_onErrorContainer_light.value
    }


md_sys_color_onError : Entity
md_sys_color_onError =
    { type_ = "alias"
    , value = md_sys_color_onError_light.value
    }


md_sys_color_errorContainer : Entity
md_sys_color_errorContainer =
    { type_ = "alias"
    , value = md_sys_color_errorContainer_light.value
    }


md_sys_color_onTertiaryContainer : Entity
md_sys_color_onTertiaryContainer =
    { type_ = "alias"
    , value = md_sys_color_onTertiaryContainer_light.value
    }


md_sys_color_onTertiary : Entity
md_sys_color_onTertiary =
    { type_ = "alias"
    , value = md_sys_color_onTertiary_light.value
    }


md_sys_color_tertiaryContainer : Entity
md_sys_color_tertiaryContainer =
    { type_ = "alias"
    , value = md_sys_color_tertiaryContainer_light.value
    }


md_sys_color_tertiary : Entity
md_sys_color_tertiary =
    { type_ = "alias"
    , value = md_sys_color_tertiary_light.value
    }


md_sys_color_shadow : Entity
md_sys_color_shadow =
    { type_ = "alias"
    , value = md_sys_color_shadow_light.value
    }


md_sys_color_error : Entity
md_sys_color_error =
    { type_ = "alias"
    , value = md_sys_color_error_light.value
    }


md_sys_color_outline : Entity
md_sys_color_outline =
    { type_ = "alias"
    , value = md_sys_color_outline_light.value
    }


md_sys_color_onBackground : Entity
md_sys_color_onBackground =
    { type_ = "alias"
    , value = md_sys_color_onBackground_light.value
    }


md_sys_color_background : Entity
md_sys_color_background =
    { type_ = "alias"
    , value = md_sys_color_background_light.value
    }


md_sys_color_inverseOnSurface : Entity
md_sys_color_inverseOnSurface =
    { type_ = "alias"
    , value = md_sys_color_inverseOnSurface_light.value
    }


md_sys_color_inverseSurface : Entity
md_sys_color_inverseSurface =
    { type_ = "alias"
    , value = md_sys_color_inverseSurface_light.value
    }


md_sys_color_onSurfaceVariant : Entity
md_sys_color_onSurfaceVariant =
    { type_ = "alias"
    , value = md_sys_color_onSurfaceVariant_light.value
    }


md_sys_color_onSurface : Entity
md_sys_color_onSurface =
    { type_ = "alias"
    , value = md_sys_color_onSurface_light.value
    }


md_sys_color_surfaceVariant : Entity
md_sys_color_surfaceVariant =
    { type_ = "alias"
    , value = md_sys_color_surfaceVariant_light.value
    }


md_sys_color_surface : Entity
md_sys_color_surface =
    { type_ = "alias"
    , value = md_sys_color_surface_light.value
    }


md_sys_color_onSecondaryContainer : Entity
md_sys_color_onSecondaryContainer =
    { type_ = "alias"
    , value = md_sys_color_onSecondaryContainer_light.value
    }


md_sys_color_onSecondary : Entity
md_sys_color_onSecondary =
    { type_ = "alias"
    , value = md_sys_color_onSecondary_light.value
    }


md_sys_color_secondaryContainer : Entity
md_sys_color_secondaryContainer =
    { type_ = "alias"
    , value = md_sys_color_secondaryContainer_light.value
    }


md_sys_color_secondary : Entity
md_sys_color_secondary =
    { type_ = "alias"
    , value = md_sys_color_secondary_light.value
    }


md_sys_color_inversePrimary : Entity
md_sys_color_inversePrimary =
    { type_ = "alias"
    , value = md_sys_color_inversePrimary_light.value
    }


md_sys_color_onPrimaryContainer : Entity
md_sys_color_onPrimaryContainer =
    { type_ = "alias"
    , value = md_sys_color_onPrimaryContainer_light.value
    }


md_sys_color_onPrimary : Entity
md_sys_color_onPrimary =
    { type_ = "alias"
    , value = md_sys_color_onPrimary_light.value
    }


md_sys_color_primaryContainer : Entity
md_sys_color_primaryContainer =
    { type_ = "alias"
    , value = md_sys_color_primaryContainer_light.value
    }


md_sys_color_primary : Entity
md_sys_color_primary =
    { type_ = "alias"
    , value = md_sys_color_primary_light.value
    }
