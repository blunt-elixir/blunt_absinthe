defmodule Cqrs.Absinthe.Test.GetPerson do
  use Cqrs.Query

  @moduledoc """
  Get's a person.
  """

  field :id, :binary_id, required: true

  field :error_out, :boolean, default: false

  binding :person, CqrsToolsBoundedContext.QueryTest.ReadModel.Person
end
