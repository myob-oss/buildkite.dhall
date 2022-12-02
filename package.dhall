let Command = ./command.dhall

let Wait = ./wait.dhall

let Block = ./block.dhall

let Trigger = ./trigger.dhall

let Input = ./input.dhall

let Steps =
      < Wait : Wait.Type
      | Block : Block.Type
      | Command : Command.Type
      | Trigger : Trigger.Type
      | Input : Input.Input.Type
      >

let wait = Steps.Wait Wait.default

let Retry = ./retry.dhall

let Plugin = ./plugin.dhall

in  { Steps, Wait, Block, Command, Trigger, wait, Retry } // Plugin // Input
