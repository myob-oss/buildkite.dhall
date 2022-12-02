let Prelude =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v21.1.0/Prelude/package.dhall
        sha256:0fed19a88330e9a8a3fbe1e8442aa11d12e38da51eb12ba8bcb56f3c25d0854a

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
