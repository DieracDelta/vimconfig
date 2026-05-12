[
  "fact"
  "global"
  "local"
  "schema"
  "skill"
  "function"
  "loop"
  "break"
  "return"
  "subagent"
  "end"
] @keyword

[
  "true"
  "false"
] @boolean

[
  "relative"
  "global"
] @type

(function_statement
  name: (identifier) @function)

(call_expression
  function: (identifier) @function.call)

(subagent_expression
  agent: (identifier) @constant)

(subagent_field
  name: (subagent_key) @property)

(pair
  key: (_) @property)

(identifier) @variable
(number) @number
(string) @string
(comment) @comment
