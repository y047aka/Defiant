module DesignToken.Tokens.Reference.Typography exposing (sd)
sd =
    { reference =
        { typography =
            { fontFamily =
                { primary =
                    { value = "Roboto"
                    , type_ = "fontFamily"
                    , description = "Serendieは和文Noto Sans JP、欧文Robotoを採用しています。Figmaは和欧混植に対応していないため、Robotoのみ指定することで、和文はFigmaのフォントフォールバックによりNoto Sans JPが自動適用されることを意図しています。これにより実質的な混植を行います。CSSでは一般的なfont-family指定により混植します。"
                    }
                , monospace =
                    { value = "Noto Sans Mono"
                    , type_ = "fontFamily"
                    }
                }
            , fontWeight =
                { regular =
                    { value = 400
                    , type_ = "fontWeight"
                    }
                , bold =
                    { value = 700
                    , type_ = "fontWeight"
                    }
                }
            , lineHeight =
                { none =
                    { value = 1
                    , type_ = "number"
                    }
                , tight =
                    { value = 1.4
                    , type_ = "number"
                    }
                , normal =
                    { value = 1.6
                    , type_ = "number"
                    }
                , relaxed =
                    { value = 1.8
                    , type_ = "number"
                    }
                }
            , scale =
                { expanded =
                    { fourExtraSmall =
                        { value = "10px"
                        , type_ = "dimension"
                        }
                    , threeExtraSmall =
                        { value = "11px"
                        , type_ = "dimension"
                        }
                    , twoExtraSmall =
                        { value = "12px"
                        , type_ = "dimension"
                        }
                    , extraSmall =
                        { value = "13px"
                        , type_ = "dimension"
                        }
                    , small =
                        { value = "14px"
                        , type_ = "dimension"
                        }
                    , medium =
                        { value = "16px"
                        , type_ = "dimension"
                        }
                    , large =
                        { value = "18px"
                        , type_ = "dimension"
                        }
                    , extraLarge =
                        { value = "21px"
                        , type_ = "dimension"
                        }
                    , twoExtraLarge =
                        { value = "26px"
                        , type_ = "dimension"
                        }
                    , threeExtraLarge =
                        { value = "32px"
                        , type_ = "dimension"
                        }
                    , fourExtraLarge =
                        { value = "43px"
                        , type_ = "dimension"
                        }
                    , fiveExtraLarge =
                        { value = "64px"
                        , type_ = "dimension"
                        }
                    }
                , compact =
                    { twoExtraSmall =
                        { value = "10px"
                        , type_ = "dimension"
                        }
                    , extraSmall =
                        { value = "11px"
                        , type_ = "dimension"
                        }
                    , small =
                        { value = "12px"
                        , type_ = "dimension"
                        }
                    , medium =
                        { value = "14px"
                        , type_ = "dimension"
                        }
                    , large =
                        { value = "16px"
                        , type_ = "dimension"
                        }
                    , extraLarge =
                        { value = "19px"
                        , type_ = "dimension"
                        }
                    , twoExtraLarge =
                        { value = "22px"
                        , type_ = "dimension"
                        }
                    , threeExtraLarge =
                        { value = "28px"
                        , type_ = "dimension"
                        }
                    , fourExtraLarge =
                        { value = "37px"
                        , type_ = "dimension"
                        }
                    , fiveExtraLarge =
                        { value = "56px"
                        , type_ = "dimension"
                        }
                    }
                }
            }
        }
    }
