module DesignToken.Tokens.System exposing (sd_)

import DesignToken.Tokens.Reference exposing (sd)


sd_ =
    { system =
        { color = color
        , dimension = dimension
        , elevation = elevation
        , typography = typography
        }
    }



-- COLOR


color =
    { impression =
        { primary =
            { type_ = "color"
            , value = sd.reference.color.scale.blue700
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , onPrimary =
            { type_ = "color"
            , value = sd.reference.color.scale.white1000
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , primaryContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.blue700
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        , onPrimaryContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.white1000
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , secondary =
            { type_ = "color"
            , value = sd.reference.color.scale.blue300
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , onSecondary =
            { type_ = "color"
            , value = sd.reference.color.scale.black1000
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , secondaryContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.blue300
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        , onSecondaryContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.black1000
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , tertiary =
            { type_ = "color"
            , value = sd.reference.color.scale.blue100
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , onTertiary =
            { type_ = "color"
            , value = sd.reference.color.scale.black1000
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , tertiaryContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.blue100
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        , onTertiaryContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.black1000
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , notice =
            { type_ = "color"
            , value = sd.reference.color.scale.yellow300
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , onNotice =
            { type_ = "color"
            , value = sd.reference.color.scale.black1000
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , noticeContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.yellow300
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        , onNoticeContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.black1000
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , negative =
            { type_ = "color"
            , value = sd.reference.color.scale.red600
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , onNegative =
            { type_ = "color"
            , value = sd.reference.color.scale.white1000
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , negativeContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.red200
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        , onNegativeContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.black1000
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , positive =
            { type_ = "color"
            , value = sd.reference.color.scale.green500
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , onPositive =
            { type_ = "color"
            , value = sd.reference.color.scale.white1000
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , positiveContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.green500
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        , onPositiveContainer =
            { type_ = "color"
            , value = sd.reference.color.scale.white1000
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        }
    , component =
        { surface =
            { type_ = "color"
            , value = sd.reference.color.scale.white1000
            , description = "bodyの背景色などサイトのベースカラー"
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        , onSurface =
            { type_ = "color"
            , value = sd.reference.color.scale.black1000
            , description = "surface色を地にしたオブジェクト色"
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , onSurfaceVariant =
            { type_ = "color"
            , value = sd.reference.color.scale.gray600
            , description = "プレイスホルダーやサブテキストなどonSurfaceに強弱をつける際に利用"
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , inverseSurface =
            { type_ = "color"
            , value = sd.reference.color.scale.gray1000
            , description = "toastやtooltipなどに使用するsurfaceの反対色"
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        , inverseOnSurface =
            { type_ = "color"
            , value = sd.reference.color.scale.white1000
            , description = "surfaceの反対色を地にしたオブジェクト色"
            , extensions = { scopes = [ "SHAPE_FILL", "TEXT_FILL", "STROKE_COLOR" ] }
            }
        , outline =
            { type_ = "color"
            , value = sd.reference.color.scale.gray300
            , description = "ボタンやフォームなどのアウトライン色"
            , extensions = { scopes = [ "STROKE_COLOR" ] }
            }
        , outlineVariant =
            { type_ = "color"
            , value = sd.reference.color.scale.gray500
            , extensions = { scopes = [ "STROKE_COLOR" ] }
            }
        , scrim =
            { type_ = "color"
            , value = sd.reference.color.scale.transparency20
            , description = "modalやdrawerの背景色として使用する色"
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL" ] }
            }
        }
    , interaction =
        { disabled =
            { type_ = "color"
            , value = sd.reference.color.scale.gray100
            , description = "disabled状態のオブジェクト色"
            , extensions = { scopes = [ "ALL_FILLS" ] }
            }
        , disabledOnSurface =
            { type_ = "color"
            , value = sd.reference.color.scale.gray400
            , description = "onSurface色をdisabled状態にするときに使用"
            , extensions = { scopes = [ "ALL_FILLS", "STROKE_COLOR" ] }
            }
        , selectedSurface =
            { type_ = "color"
            , value = sd.reference.color.scale.blue300
            , description = "surface色をselected状態にするときに使用 (ListItemなど)"
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL", "STROKE_COLOR" ] }
            }
        , hovered =
            { type_ = "color"
            , value = sd.reference.color.scale.transparency20
            , description = "hover状態のオブジェクトに重ねわせる半透明色"
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL", "STROKE_COLOR" ] }
            }
        , hoveredVariant =
            { type_ = "color"
            , value = sd.reference.color.scale.transparency5
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL", "STROKE_COLOR" ] }
            }
        , hoveredOnPrimary =
            { type_ = "color"
            , value = sd.reference.color.scale.transparency60
            , description = "primaryなど有彩色を使用したhover状態のオブジェクトに重ね合わせる半透明色"
            , extensions = { scopes = [ "FRAME_FILL", "SHAPE_FILL", "STROKE_COLOR" ] }
            }
        }
    }



-- DIMENSION


dimension =
    { spacing =
        { none =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension0
            , extensions = { scopes = [ "GAP" ] }
            }
        , twoExtraSmall =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension3
            , extensions = { scopes = [ "GAP" ] }
            }
        , extraSmall =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension4
            , extensions = { scopes = [ "GAP" ] }
            }
        , small =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension5
            , extensions = { scopes = [ "GAP" ] }
            }
        , medium =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension6
            , extensions = { scopes = [ "GAP" ] }
            }
        , large =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension7
            , extensions = { scopes = [ "GAP" ] }
            }
        , extraLarge =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension8
            , extensions = { scopes = [ "GAP" ] }
            }
        , twoExtraLarge =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension10
            , extensions = { scopes = [ "GAP" ] }
            }
        , threeExtraLarge =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension12
            , extensions = { scopes = [ "GAP" ] }
            }
        , fourExtraLarge =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension13
            , extensions = { scopes = [ "GAP" ] }
            }
        , fiveExtraLarge =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension15
            , extensions = { scopes = [ "GAP" ] }
            }
        , sixExtraLarge =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension17
            , extensions = { scopes = [ "GAP" ] }
            }
        }
    , border =
        { medium =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension1
            , extensions = { scopes = [ "STROKE_FLOAT" ] }
            }
        , thick =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension2
            , extensions = { scopes = [ "STROKE_FLOAT" ] }
            }
        , extraThick =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension3
            , extensions = { scopes = [ "STROKE_FLOAT" ] }
            }
        }
    , radius =
        { extraSmall =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension2
            , extensions = { scopes = [ "CORNER_RADIUS" ] }
            }
        , small =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension3
            , extensions = { scopes = [ "CORNER_RADIUS" ] }
            }
        , medium =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension4
            , extensions = { scopes = [ "CORNER_RADIUS" ] }
            }
        , large =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension5
            , extensions = { scopes = [ "CORNER_RADIUS" ] }
            }
        , extraLarge =
            { type_ = "dimension"
            , value = sd.reference.dimension.scale.dimension6
            , extensions = { scopes = [ "CORNER_RADIUS" ] }
            }
        , full =
            { type_ = "dimension"
            , value = "9999px"
            , extensions = { scopes = [ "CORNER_RADIUS" ] }
            }
        }
    , breakpoint =
        { compact =
            { type_ = "dimension"
            , value = "0px"
            , extensions = { scopes = [] }
            }
        , expanded =
            { type_ = "dimension"
            , value = sd.reference.dimension.breakpoint.medium
            , extensions = { scopes = [] }
            }
        }
    }


elevation =
    { shadow =
        { level1 =
            { type_ = "shadow"
            , value =
                { color = "#0000004D"
                , offsetX = "0px"
                , offsetY = "1px"
                , blur = "2px"
                , spread = "0px"
                }
            }
        , level2 =
            { type_ = "shadow"
            , value =
                { color = "#00000033"
                , offsetX = "0px"
                , offsetY = "1px"
                , blur = "4px"
                , spread = "0px"
                }
            }
        , level3 =
            { type_ = "shadow"
            , value =
                { color = "#00000033"
                , offsetX = "0px"
                , offsetY = "2px"
                , blur = "8px"
                , spread = "0px"
                }
            }
        , level4 =
            { type_ = "shadow"
            , value =
                { color = "#00000033"
                , offsetX = "0px"
                , offsetY = "4px"
                , blur = "12px"
                , spread = "0px"
                }
            }
        , level5 =
            { type_ = "shadow"
            , value =
                { color = "#00000033"
                , offsetX = "0px"
                , offsetY = "8px"
                , blur = "24px"
                , spread = "0px"
                }
            }
        }
    , zIndex =
        { deepDive =
            { type_ = "number"
            , value = -1000
            }
        , base =
            { type_ = "number"
            , value = 0
            }
        , docked =
            { type_ = "number"
            , value = 10
            }
        , dropdown =
            { type_ = "number"
            , value = 500
            }
        , modal =
            { type_ = "number"
            , value = 1000
            }
        , toast =
            { type_ = "number"
            , value = 2000
            }
        }
    }


typography =
    { compact =
        { display =
            { small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.fourExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.fiveExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            }
        , headline =
            { small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.threeExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.fourExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , large =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.fiveExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            }
        , title =
            { small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.large
                    , fontWeight = sd.reference.typography.fontWeight.bold
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.extraLarge
                    , fontWeight = sd.reference.typography.fontWeight.bold
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , large =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.twoExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.bold
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            }
        , body =
            { extraSmall =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.small
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.tight
                    }
                }
            , small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.medium
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.large
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , large =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.extraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            }
        , label =
            { small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.extraSmall
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.none
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.small
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.none
                    }
                }
            , large =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.medium
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.none
                    }
                }
            , extraLarge =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.compact.large
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.none
                    }
                }
            }
        }
    , expanded =
        { display =
            { small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.fourExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.fiveExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            }
        , headline =
            { small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.extraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.twoExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , large =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.threeExtraLarge
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            }
        , title =
            { small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.small
                    , fontWeight = sd.reference.typography.fontWeight.bold
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.medium
                    , fontWeight = sd.reference.typography.fontWeight.bold
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , large =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.large
                    , fontWeight = sd.reference.typography.fontWeight.bold
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            }
        , body =
            { extraSmall =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.twoExtraSmall
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.tight
                    }
                }
            , small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.extraSmall
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.small
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            , large =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.medium
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.normal
                    }
                }
            }
        , label =
            { small =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.threeExtraSmall
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.none
                    }
                }
            , medium =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.twoExtraSmall
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.none
                    }
                }
            , large =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.extraSmall
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.none
                    }
                }
            , extraLarge =
                { type_ = "typography"
                , value =
                    { fontSize = sd.reference.typography.scale.expanded.small
                    , fontWeight = sd.reference.typography.fontWeight.regular
                    , fontFamily = sd.reference.typography.fontFamily.primary
                    , lineHeight = sd.reference.typography.lineHeight.none
                    }
                }
            }
        }
    }
