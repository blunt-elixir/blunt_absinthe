defmodule Cqrs.Absinthe.Test.CreatePerson do
  use Cqrs.Command

  alias Cqrs.Absinthe.Test.ReadModel.Person

  field :name, :string
  field :gender, :enum, values: Person.genders(), default: :not_sure

  field :id, :binary_id,
    desc: "Id is set internally. Setting it will have no effect",
    required: false

  option :send_notification, :boolean, default: false

  @impl true
  def after_validate(command) do
    Map.put(command, :id, UUID.uuid4())
  end
end
