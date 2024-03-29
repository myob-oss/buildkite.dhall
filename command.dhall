{- https://buildkite.com/docs/pipelines/command-step -}
let Prelude =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v21.1.0/Prelude/package.dhall
        sha256:0fed19a88330e9a8a3fbe1e8442aa11d12e38da51eb12ba8bcb56f3c25d0854a

let Map = Prelude.Map.Type

let Retry = ./retry.dhall

let Plugin = (./plugin.dhall).Plugin

let Command =
      { Type =
          { commands : List Text
          , agents : Optional { queue : Text }
          , branches : Optional Text
          , artifact_paths : Optional (List Text)
          , allow_dependency_failure : Optional Bool
          , concurrency : Optional Natural
          , concurrency_group : Optional Text
          , depends_on : Optional (List Text)
          , env : Optional (Map Text Text)
          , `if` : Optional Text
          , key : Optional Text
          , label : Optional Text
          , parallelism : Optional Natural
          , plugins : Optional (List Plugin)
          , retry : Optional Retry
          , skip : Optional Text
          , soft_fail : Optional Bool
          , timeout_in_minutes : Optional Natural
          }
      , default =
        { retry = None Retry
        , branches = None Text
        , agents = None { queue : Text }
        , artifact_paths = None (List Text)
        , allow_dependency_failure = None Bool
        , concurrency = None Natural
        , concurrency_group = None Text
        , depends_on = None (List Text)
        , env = None (Map Text Text)
        , `if` = None Text
        , key = None Text
        , label = None Text
        , parallelism = None Natural
        , plugins = None (List Plugin)
        , skip = None Text
        , soft_fail = None Bool
        , timeout_in_minutes = None Natural
        }
      }

in  Command
