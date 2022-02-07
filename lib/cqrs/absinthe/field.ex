defmodule Cqrs.Absinthe.Field do
  alias Cqrs.DispatchContext, as: Context
  alias Cqrs.Absinthe.{AbsintheErrors, Args, Field, Log}

  @spec name(atom, keyword) :: atom()
  def name(module, opts) do
    [name | _] =
      module
      |> Module.split()
      |> Enum.reverse()

    default_function_name =
      name
      |> to_string
      |> Macro.underscore()
      |> String.to_atom()

    Keyword.get(opts, :as, default_function_name)
  end

  @spec generate_body(atom(), atom, atom, keyword) :: {:__block__, [], [...]}
  def generate_body(operation, field_name, message_module, opts) do
    opts =
      opts
      |> Keyword.put(:operation, operation)
      |> Keyword.put(:field_name, field_name)
      |> Keyword.put(:message_module, message_module)

    args = args(message_module, opts)

    # TODO: message_module simple docs here
    description = nil

    quote do
      unquote_splicing(args)
      description unquote(description)
      # middleware unquote(before_resolve)

      resolve(fn parent, args, resolution ->
        Field.dispatch_and_resolve(
          unquote(operation),
          unquote(message_module),
          unquote(opts),
          parent,
          args,
          resolution
        )
      end)

      # middleware unquote(after_resolve)
    end
  end

  defp args(message_module, opts) do
    fields = message_module.__schema_fields__()
    Args.from_message_fields(fields, opts)
  end

  @type resolution :: Absinthe.Resolution.t()
  @spec dispatch_and_resolve(atom, atom, keyword, map, map, any) :: {:error, list} | {:ok, any}
  def dispatch_and_resolve(operation, message_module, query_opts, parent, args, _resolution) do
    opts =
      query_opts
      |> Keyword.put(:return, :context)
      |> Keyword.put(operation, true)

    results =
      args
      |> Args.resolve_message_input({message_module, parent, query_opts})
      |> message_module.new()
      |> message_module.dispatch(opts)

    :ok = Log.dump()

    case results do
      {:error, %Context{} = context} ->
        return_value = {:error, AbsintheErrors.from_dispatch_context(context)}

        context
        |> Context.put_pipeline(:absinthe_resolve, return_value)
        |> Context.ship()

        return_value

      {:ok, %Context{} = context} ->
        return_value = {:ok, Context.get_last_pipeline(context)}

        context
        |> Context.put_pipeline(:absinthe_resolve, return_value)
        |> Context.ship()

        return_value
    end
  end
end
