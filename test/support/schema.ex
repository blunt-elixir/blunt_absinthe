defmodule Cqrs.Absinthe.Test.Schema do
  use Absinthe.Schema
  import_types Cqrs.Absinthe.Test.SchemaTypes

  query do
    import_fields :person_queries
  end

  mutation do
    import_fields :person_mutations
  end
end
