defmodule Cqrs.Absinthe.Log do
  @spec debug(any) :: any()
  @spec warning(any) :: any()
  @spec error(any) :: any()
  @spec info(any) :: any()

  def debug(entry), do: put({:debug, entry})
  def warning(entry), do: put({:warning, entry})
  def error(entry), do: put({:error, entry})
  def info(entry), do: put({:info, entry})

  defp put({level, entry}) do
    logs = Process.get(:cqrs_logs, [])
    logs = logs ++ [%{level: level, date: DateTime.utc_now(), message: entry}]
    Process.put(:cqrs_logs, logs)
    entry
  end

  require Logger

  @spec dump :: :ok

  def dump do
    :cqrs_logs
    |> Process.get([])
    |> Enum.sort_by(& &1.date)
    |> Enum.each(fn %{level: level, message: message} ->
      if System.get_env("CQRS_ABSINTHE_DEBUG") do
        IO.inspect(message, label: "log")
      end

      Logger.log(level, message)
    end)

    Logger.flush()

    :ok
  end
end