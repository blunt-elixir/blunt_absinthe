defmodule Cqrs.Absinthe.MutationTest do
  use ExUnit.Case
  alias Cqrs.Absinthe.Test.Schema

  setup do
    %{
      query: """
      mutation create($name: String!, $gender: Gender!){
        createPerson(name: $name, gender: $gender){
          id
          name
          gender
        }
      }
      """
    }
  end

  test "can create a person", %{query: query} do
    assert {:ok, %{data: %{"createPerson" => person}}} =
             Absinthe.run(query, Schema, variables: %{"name" => "chris", "gender" => "MALE"})

    assert %{"id" => id, "name" => "chris", "gender" => "MALE"} = person
    assert {:ok, _} = UUID.info(id)
  end
end
