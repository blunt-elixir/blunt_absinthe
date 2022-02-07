defmodule Cqrs.Absinthe.EnumTest do
  use ExUnit.Case, async: true

  alias Absinthe.Type.Enum
  alias Cqrs.Absinthe.Test.Schema

  test "enum is defined" do
    assert %Enum{values: values} = Absinthe.Schema.lookup_type(Schema, :gender)
    assert [:female, :male, :not_sure] = Map.keys(values)
  end
end
