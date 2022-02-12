defmodule Cqrs.Absinthe.Object do
  @moduledoc false
  alias Cqrs.Absinthe.{ArgsAndFields, Field}

  def generate(:input, message_module, opts) do
    name = :"#{Field.name(message_module, opts)}_input"

    opts =
      opts
      |> Keyword.put(:field_name, name)
      |> Keyword.put(:message_module, message_module)
      |> Keyword.put(:operation, :absinthe_input_object)

    fields = fields(message_module, opts)

    quote do
      input_object unquote(name) do
        (unquote_splicing(fields))
      end
    end
  end

  defp fields(message_module, opts) do
    fields = message_module.__schema_fields__()
    ArgsAndFields.from_message_fields(:fields, fields, opts)
  end
end
