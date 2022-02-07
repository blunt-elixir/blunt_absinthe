Cqrs.Repo.start_link([])
Application.put_env(:cqrs_tools, :context_shipper, Cqrs.Absinthe.Test.DispatchContextShipper)
ExUnit.start()
