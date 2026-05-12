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

(path_scope) @type
(boolean) @boolean
(break_statement) @keyword
(identifier) @variable
(number) @number
(string) @string
(comment) @comment
