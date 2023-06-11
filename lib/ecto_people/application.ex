defmodule EctoPeople.Application do

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EctoPeopleWeb.Telemetry,
      EctoPeople.Repo,
      {Phoenix.PubSub, name: EctoPeople.PubSub},
      {Finch, name: EctoPeople.Finch},
      EctoPeopleWeb.Endpoint,
      {CSVParser, []}
    ]
    opts = [strategy: :one_for_one, name: EctoPeople.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    EctoPeopleWeb.Endpoint.config_change(changed, removed)
    :ok
  end

end
