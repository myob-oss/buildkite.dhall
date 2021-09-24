let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98

let Map = Prelude.Map.Type

let JSON = Prelude.JSON

let PluginConfigValue =
      < L0 : Text
      | L1 : Map Text Text
      | L2 : Map Text (Map Text Text)
      | Arbitrary : JSON.Type
      >

let PluginConfig = Map Text PluginConfigValue

let Plugin = Map Text PluginConfig

let example =
      { plugins = Some
        [ toMap
            { `seek-oss/aws-sm#v2.3.1` = toMap
                { env =
                    PluginConfigValue.L1
                      ( toMap
                          { MY_SECRET = "my-secret-id"
                          , MY_OTHER_SECRET = "my-other-secret-id"
                          }
                      )
                , file =
                    PluginConfigValue.Arbitrary
                      ( JSON.array
                          [ JSON.object
                              ( toMap
                                  { path = JSON.string "save-my-secret-here"
                                  , secret-id = JSON.string "my-secret-file-id"
                                  }
                              )
                          , JSON.object
                              ( toMap
                                  { path =
                                      JSON.string "save-my-other-secret-here"
                                  , secret-id =
                                      JSON.string "my-other-secret-file-id"
                                  }
                              )
                          ]
                      )
                }
            }
        ]
      }

in  { Plugin, PluginConfigValue }
