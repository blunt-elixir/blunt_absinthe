defmodule Cqrs.Absinthe.Message do
  @moduledoc false

  alias Cqrs.Absinthe.Error
  alias Cqrs.Message.Metadata

  def validate!(:command, module) do
    error = "#{inspect(module)} is not a valid #{inspect(Cqrs.Command)}"
    do_validate!(module, :command, error)
  end

  def validate!(:query, module) do
    error = "#{inspect(module)} is not a valid #{inspect(Cqrs.Query)}"
    do_validate!(module, :query, error)
  end

  defp do_validate!(module, type, error) do
    case Code.ensure_compiled(module) do
      {:module, module} ->
        unless Metadata.is_message_type?(module, type) do
          raise Error, message: error
        end

      _ ->
        raise Error, message: error
    end
  end
end
