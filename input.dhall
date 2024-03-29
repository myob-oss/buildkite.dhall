let TextField =
      { Type =
          { text : Text
          , key : Text
          , hint : Optional Text
          , required : Optional Bool
          , default : Optional Text
          }
      , default =
        { hint = None Text, required = Some False, default = None Text }
      }

let OptionField =
      { Type =
          { select : Text
          , key : Text
          , hint : Optional Text
          , required : Optional Bool
          , default : Optional Text
          , multiple : Optional Bool
          , options : List { label : Text, value : Text }
          }
      , default =
        { hint = None Text
        , required = Some False
        , default = None Text
        , multiple = Some False
        }
      }

let InputField = < Text : TextField.Type | Select : OptionField.Type >

let Input =
      { Type =
          { input : Text
          , fields : List InputField
          , prompt : Optional Text
          , branches : Optional Text
          , `if` : Optional Text
          , depends_on : Optional Text
          , allow_dependency_failure : Bool
          }
      , default =
        { prompt = None Text
        , branches = None Text
        , `if` = None Text
        , depends_on = None Text
        , allow_dependency_failure = False
        }
      }

in  { Input, InputField, OptionField, TextField }
