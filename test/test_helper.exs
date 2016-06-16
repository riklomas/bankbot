ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Bankbot.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Bankbot.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Bankbot.Repo)

