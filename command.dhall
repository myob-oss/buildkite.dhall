{- https://buildkite.com/docs/pipelines/command-step -}
let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98

let Map = Prelude.Map.Type

let JSON = Prelude.JSON.Type

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
