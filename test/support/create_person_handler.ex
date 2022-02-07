defmodule Cqrs.Absinthe.Test.CreatePersonHandler do
  use Cqrs.CommandHandler

  alias Cqrs.Repo
  alias Cqrs.Absinthe.Test.ReadModel.Person

  @impl true
  def handle_dispatch(command, _context) do
    command
    |> Map.from_struct()
    |> Person.changeset()
    |> Repo.insert()
  end
end
