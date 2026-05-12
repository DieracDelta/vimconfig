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
        $.fact_statement,
        $.global_statement,
        $.local_statement,
        $.schema_statement,
        $.skill_statement,
        $.break_statement,
        $.return_statement,
        $.expression_statement,
      ),

    fact_statement: ($) => seq("fact", field("value", $.expression)),
    global_statement: ($) => seq("global", field("name", $.identifier), "=", field("value", $.expression)),
    local_statement: ($) => seq("local", field("name", $.identifier), "=", field("value", $.expression)),
    schema_statement: ($) => seq("schema", field("name", $.identifier), "=", field("value", $.dictionary)),
    skill_statement: ($) =>
      seq("skill", field("name", $.identifier), "=", field("scope", $.path_scope), field("path", $.string)),
    function_statement: ($) =>
      seq(
        "function",
        field("name", $.identifier),
        "(",
        optional($.identifier_list),
        ")",
        "=",
        $.separator,
        optional($.statement_list),
        "end",
      ),
    loop_statement: ($) => seq("loop", $.separator, optional($.statement_list), "end"),
    break_statement: () => "break",
    return_statement: ($) => seq("return", field("value", $.expression)),
    expression_statement: ($) => $.expression,

    expression: ($) =>
      choice(
        $.subagent_expression,
        $.call_expression,
        $.dictionary,
        $.list,
        $.string,
        $.boolean,
        $.number,
        $.identifier,
      ),

    subagent_expression: ($) =>
      seq("subagent", field("agent", $.identifier), "{", optional($.field_separator), $.subagent_field_list, "}"),
    subagent_field_list: ($) =>
      seq($.subagent_field, repeat(seq($.field_separator, $.subagent_field)), optional($.field_separator)),
    subagent_field: ($) => seq(field("name", $.subagent_key), ":", field("value", $.expression)),
    subagent_key: () => choice("skill", "input", "output", "facts", "resume"),

    call_expression: ($) => seq(field("function", $.identifier), "(", optional($.expression_list), ")"),

    dictionary: ($) => seq("{", optional($.field_separator), optional($.pair_list), "}"),
    pair_list: ($) => seq($.pair, repeat(seq($.field_separator, $.pair)), optional($.field_separator)),
    pair: ($) => seq(field("key", choice($.identifier, $.string)), ":", field("value", $.expression)),

    list: ($) => seq("[", optional($.expression_list), "]"),
    expression_list: ($) => seq($.expression, repeat(seq(",", $.expression)), optional(",")),
    identifier_list: ($) => seq($.identifier, repeat(seq(",", $.identifier)), optional(",")),

    path_scope: () => choice("global", "relative"),
    boolean: () => choice("true", "false"),
    number: () => /-?[0-9]+(\.[0-9]+)?/,
    identifier: () => /[A-Za-z_][A-Za-z0-9_]*/,

    string: ($) => choice($.normal_string, $.triple_string),
    normal_string: () => token(seq('"', repeat(choice(/[^"\\\n]/, /\\["\\nrt]/)), '"')),
    triple_string: () => token(seq('"""', repeat(/(.|\n)/), '"""')),

    separator: () => /[\n;]+/,
    field_separator: ($) => choice(",", $.separator),
    comment: () => token(seq("#", /.*/)),
  },
});
