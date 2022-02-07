defmodule Cqrs.Absinthe.Test.GetPersonHandler do
  use Cqrs.QueryHandler

  alias Cqrs.Repo
  alias Cqrs.Absinthe.Test.ReadModel.Person

  @impl true
  def create_query(filters, _context) do
    query = from p in Person, as: :person

    Enum.reduce(filters, query, fn
      {:id, id}, query -> from([person: p] in query, where: p.id == ^id)
      _other, query -> query
    end)
  end

  @impl true
  def before_dispatch(%{error_out: error_out}, context) do
    if error_out,
      do: {:error, %{sumting: "wong"}},
      else: {:ok, context}
  end

  @impl true
  def handle_dispatch(query, _context, opts),
    do: Repo.one(query, opts)
end
