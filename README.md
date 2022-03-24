# buildkite.dhall

[![Build status](https://badge.buildkite.com/5dc8c0958e280733d589ff14946e2fbdd301c053b08ac02da5.svg)](https://buildkite.com/jcouyang/buildkite-dot-dhall)

## Get Started


put this in the legacy step:
```
dhall-to-yaml <<<  './.buildkite/pipeline.dhall' | buildkite-agent pipeline upload
```

or use <https://github.com/jcouyang/dhall-buildkite-plugin/> if your buildkite agent doesn't has `dhall` installed

in YAML steps:
```yaml
steps:
  - command: "dhall-to-yaml <<< './.buildkite/pipeline.dhall' | buildkite-agent pipeline upload"
    plugins:
      jcouyang/dhall#1.0: ~
    agents:
    - "queue=your-default-queue"
```

The [pipeline.dhall](./.buildkite/pipeline.dhall) itself is test and example

essentially you may need remote import the package in your `.buildkite/pipeline.dhall`

```dhall
let bk = https://raw.githubusercontent.com/myob-oss/buildkite.dhall/0.3.0/package.dhall sha256:58893f017494437f31e55ef37f71cdd53eac3d7f11f9be85dcf63fa22a101a62
```
