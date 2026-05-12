(function_statement
  name: (identifier) @function)

(schema_statement
  name: (identifier) @type)

(call_expression
  function: (identifier) @function.call)

(subagent_expression
  agent: (identifier) @constant)

(normal_subagent_field
  name: (subagent_key) @property)

(context_field
  "context" @property)

(assignment_statement
  name: (identifier) @variable)

(pair
  key: (_) @property)

(context_pair
  key: (_) @property)

(schema_pair
  key: (_) @property)

(record_expression
  schema: (identifier) @type)

(default_expression
  "default" @keyword
  schema: (identifier) @type)

(shorthand_field
  name: (identifier) @property)

(spread_field
  ".." @operator)

(field_expression
  field: (identifier) @property)

(path_scope) @type
(schema_primitive) @type.builtin
(schema_ref) @type
(enum_variant) @constant
(enum_literal) @constant
(none) @constant.builtin
(boolean) @boolean
(break_statement) @keyword
(if_statement) @keyword
(else_clause) @keyword
(print_statement) @keyword
(match_statement) @keyword
(wildcard) @variable.builtin
(identifier) @variable
(integer) @number
(float) @float
(string) @string
(comment) @comment
