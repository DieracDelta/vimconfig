module.exports = grammar({
  name: "vilang",

  extras: ($) => [/[ \t\r]/, $.comment],

  word: ($) => $.identifier,

  rules: {
    source_file: ($) => optional($.statement_list),

    statement_list: ($) =>
      seq(optional($.separator), $.statement, repeat(seq($.separator, $.statement)), optional($.separator)),

    statement: ($) =>
      choice(
        $.function_statement,
        $.loop_statement,
        $.match_statement,
        $.fact_statement,
        $.print_statement,
        $.global_statement,
        $.let_statement,
        $.local_statement,
        $.assignment_statement,
        $.schema_statement,
        $.skill_statement,
        $.break_statement,
        $.return_statement,
        $.expression_statement,
      ),

    fact_statement: ($) => seq("fact", field("value", $.expression)),
    print_statement: ($) => seq("print", field("value", $.expression)),
    global_statement: ($) =>
      seq("global", field("name", $.identifier), optional($.type_annotation), "=", field("value", $.expression)),
    let_statement: ($) =>
      seq("let", field("name", $.identifier), optional($.type_annotation), "=", field("value", $.expression)),
    local_statement: ($) =>
      seq("local", field("name", $.identifier), optional($.type_annotation), "=", field("value", $.expression)),
    assignment_statement: ($) => seq(field("name", $.identifier), "=", field("value", $.expression)),
    schema_statement: ($) => seq("schema", field("name", $.identifier), "=", field("value", $.schema_type)),
    skill_statement: ($) =>
      seq("skill", field("name", $.identifier), "=", field("scope", $.path_scope), field("path", $.string)),
    function_statement: ($) =>
      seq(
        "function",
        field("name", $.identifier),
        "(",
        optional($.field_separator),
        optional($.param_list),
        ")",
        optional($.return_type),
        "=",
        $.separator,
        optional($.statement_list),
        "end",
        optional("function"),
      ),
    loop_statement: ($) => seq("loop", $.separator, optional($.statement_list), "end", optional("loop")),
    match_statement: ($) =>
      seq("match", field("value", $.expression), $.separator, optional($.match_arm_list), "end", optional("match")),
    match_arm_list: ($) => seq($.match_arm, repeat(seq($.separator, $.match_arm)), optional($.separator)),
    match_arm: ($) => seq(field("pattern", $.match_pattern), "=>", field("body", $.statement)),
    match_pattern: ($) => choice($.wildcard, $.enum_literal, $.string, $.boolean, $.integer, $.float, $.identifier),
    wildcard: () => "_",
    break_statement: ($) => seq("break", optional(field("value", $.expression))),
    return_statement: ($) => seq("return", field("value", $.expression)),
    expression_statement: ($) => $.expression,

    expression: ($) => $.comparison_expression,

    comparison_expression: ($) =>
      seq($.additive_expression, optional(seq($.comparison_operator, $.additive_expression))),
    comparison_operator: () => choice("==", "!=", "<=", ">=", "<", ">"),
    additive_expression: ($) =>
      seq($.field_expression, repeat(seq($.additive_operator, $.field_expression))),
    additive_operator: () => choice("+", "-"),

    field_expression: ($) => seq($.primary_expression, repeat(seq(".", field("field", $.identifier)))),

    primary_expression: ($) =>
      choice(
        $.subagent_expression,
        $.call_expression,
        $.dictionary,
        $.list,
        $.enum_literal,
        $.string,
        $.boolean,
        $.float,
        $.integer,
        $.identifier,
      ),
    enum_literal: ($) => seq("'", $.identifier),

    subagent_expression: ($) =>
      seq("subagent", field("agent", $.identifier), "{", optional($.field_separator), $.subagent_field_list, "}"),
    subagent_field_list: ($) =>
      seq($.subagent_field, repeat(seq($.field_separator, $.subagent_field)), optional($.field_separator)),
    subagent_field: ($) => seq(field("name", $.subagent_key), ":", field("value", $.expression)),
    subagent_key: () =>
      choice(
        "skill",
        "input",
        "output",
        "facts",
        "context",
        "resume",
        "interactive",
        "timeout_seconds",
        "idle_timeout_seconds",
        "tool_call_idle_timeout_seconds",
        "exclude_tool_time",
        "unlimited_tool_call",
      ),

    call_expression: ($) =>
      seq(field("function", $.identifier), "(", optional($.field_separator), optional($.expression_list), ")"),

    dictionary: ($) => seq("{", optional($.field_separator), optional($.pair_list), "}"),
    pair_list: ($) => seq($.pair, repeat(seq($.field_separator, $.pair)), optional($.field_separator)),
    pair: ($) => seq(field("key", choice($.identifier, $.string)), ":", field("value", $.expression)),

    list: ($) => seq("[", optional($.field_separator), optional($.expression_list), "]"),
    expression_list: ($) => seq($.expression, repeat(seq($.field_separator, $.expression)), optional($.field_separator)),
    identifier_list: ($) => seq($.identifier, repeat(seq(",", $.identifier)), optional(",")),
    param_list: ($) => seq($.param, repeat(seq($.field_separator, $.param)), optional($.field_separator)),
    param: ($) => seq(field("name", $.identifier), optional(seq(":", field("type", $.schema_type)))),
    return_type: ($) => seq(":", $.schema_type),
    type_annotation: ($) => seq(":", $.schema_type),

    schema_type: ($) =>
      choice($.schema_enum, $.schema_object, $.schema_list, $.schema_primitive, $.schema_ref),
    schema_primitive: () => choice("string", "bool", "int", "float", "json"),
    schema_ref: ($) => $.identifier,
    schema_list: ($) => seq("[", $.schema_type, "]"),
    schema_object: ($) => seq("{", optional($.field_separator), optional($.schema_pair_list), "}"),
    schema_pair_list: ($) =>
      seq($.schema_pair, repeat(seq($.field_separator, $.schema_pair)), optional($.field_separator)),
    schema_pair: ($) => seq(field("key", choice($.identifier, $.string)), ":", field("value", $.schema_type)),
    schema_enum: ($) => seq("enum", "{", optional($.enum_variant_list), "}"),
    enum_variant_list: ($) =>
      seq($.enum_variant, repeat(seq(choice(",", $.separator), $.enum_variant)), optional(choice(",", $.separator))),
    enum_variant: ($) => choice($.identifier, $.string),

    path_scope: () => choice("global", "relative"),
    boolean: () => choice("true", "false"),
    float: () => /-?[0-9]+\.[0-9]+/,
    integer: () => /-?[0-9]+/,
    identifier: () => /[A-Za-z_][A-Za-z0-9_]*/,

    string: ($) => choice($.normal_string, $.triple_string),
    normal_string: () => token(seq('"', repeat(choice(/[^"\\\n]/, /\\["\\nrt]/)), '"')),
    triple_string: () => token(seq('"""', repeat(/(.|\n)/), '"""')),

    separator: () => /[\n;]+/,
    field_separator: ($) => choice(seq(",", optional($.separator)), $.separator),
    comment: () => token(seq("#", /.*/)),
  },
});
