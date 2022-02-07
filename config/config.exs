import Config

config :cqrs_tools, :context_shipper, Cqrs.Absinthe.Test.DispatchContextShipper

config :logger, :console, format: "[$level] $message\n", level: :warning
