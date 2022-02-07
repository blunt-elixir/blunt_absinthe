defmodule Cqrs.Absinthe.Test.DispatchContextShipper do
  @behaviour Cqrs.DispatchContext.Shipper

  def ship(context) do
    case System.get_env("CQRS_ABSINTHE_DEBUG") do
      nil -> :ok
      _on -> IO.inspect(context, label: "DispatchContextShipper")
    end
  end
end
