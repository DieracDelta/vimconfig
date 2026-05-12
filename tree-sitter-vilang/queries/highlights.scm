(function_statement
  name: (identifier) @function)

(schema_statement
  name: (identifier) @type)

(call_expression
  function: (identifier) @function.call)

(subagent_expression
  agent: (identifier) @constant)

(subagent_field
  name: (subagent_key) @property)

(pair
  key: (_) @property)

(schema_pair
  key: (_) @property)

(field_expression
  field: (identifier) @property)

(path_scope) @type
(schema_primitive) @type.builtin
(schema_ref) @type
(enum_variant) @constant
(boolean) @boolean
(break_statement) @keyword
(match_statement) @keyword
(identifier) @variable
(number) @number
(string) @string
(comment) @comment
