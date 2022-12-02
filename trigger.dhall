let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v21.1.0/Prelude/Map/Type.dhall
        sha256:210c7a9eba71efbb0f7a66b3dcf8b9d3976ffc2bc0e907aadfb6aa29c333e8ed

let Trigger =
      { Type =
          { trigger : Text
          , label : Text
          , branches : Optional Text
          , build :
              Optional
                { message : Text
                , commit : Text
                , branch : Text
                , env : Map Text Text
                }
          }
      , default =
        { branches = None Text
        , build = Some
          { message = "\${BUILDKITE_MESSAGE}"
          , commit = "\${BUILDKITE_COMMIT}"
          , branch = "\${BUILDKITE_BRANCH}"
          , env = toMap
              { BUILDKITE_PULL_REQUEST = "\${BUILDKITE_PULL_REQUEST}"
              , BUILDKITE_PULL_REQUEST_BASE_BRANCH =
                  "\${BUILDKITE_PULL_REQUEST_BASE_BRANCH}"
              , BUILDKITE_PULL_REQUEST_REPO = "\${BUILDKITE_PULL_REQUEST_REPO}"
              }
          }
        }
      }

in  Trigger
