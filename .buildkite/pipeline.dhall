let bk = ../package.dhall

let Steps = bk.Steps

let PluginConfigValue = bk.PluginConfigValue

let JSON =
      https://prelude.dhall-lang.org/v20.1.0/JSON/package.dhall
        sha256:5f98b7722fd13509ef448b075e02b9ff98312ae7a406cf53ed25012dbc9990ac

let main = "master"

in  [ Steps.Command
        bk.Command::{
        , label = Some ":scala:"
        , env = Some (toMap { NODE_ENV = "test" })
        , agents = Some { queue = "default" }
        , commands = [ "echo yay" ]
        , artifact_paths = Some [ "logs/**/*", "coverage/**/*" ]
        , parallelism = Some 5
        , timeout_in_minutes = Some 3
        , retry = Some
            ( bk.Retry.Auto
                { automatic =
                  [ { exit_status = Some -1, limit = Some 2 }
                  , { exit_status = Some +143, limit = Some 2 }
                  ]
                }
            )
        }
    , Steps.Command
        bk.Command::{
        , label = Some "Skipped job"
        , commands = [ "broken.sh" ]
        , skip = Some "Currently broken and needs to be fixed"
        }
    , bk.wait
    , Steps.Command
        bk.Command::{
        , label = Some ":shipit: Deploy"
        , commands = [ "echo deploy" ]
        , branches = Some "master"
        , concurrency = Some 1
        , concurrency_group = Some "my-app/deploy"
        , retry = Some
            ( bk.Retry.Manual
                { manual =
                  { allowed = Some False
                  , reason = Some "Sorry, you can't retry a deployment"
                  , permit_on_passed = None Bool
                  }
                }
            )
        }
    , Steps.Input
        bk.Input::{
        , input = "Release?"
        , fields =
          [ bk.InputField.Select
              bk.OptionField::{
              , select = "y/n"
              , key = "is-release"
              , options = [ { label = "yes", value = "yes" } ]
              }
          , bk.InputField.Text
              bk.TextField::{ text = "Release Name", key = "release-name" }
          ]
        }
    ]
