# Used by "mix format"
locals_without_parens = [
  derive_enum: 2,
  derive_query: 2,
  derive_query: 3,
  derive_mutation: 2,
  derive_mutation: 3,
  derive_input_object: 1,
  derive_input_object: 2
]

[
  locals_without_parens: locals_without_parens,
  line_length: 120,
  import_deps: [:absinthe, :cqrs_tools, :ecto],
  export: [
    locals_without_parens: locals_without_parens
  ],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"]
]
