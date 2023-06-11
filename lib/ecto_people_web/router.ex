defmodule EctoPeopleWeb.Router do
  use EctoPeopleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {EctoPeopleWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EctoPeopleWeb do
    pipe_through :browser

    get "/", PersonController, :index
    get "/people/", PersonController, :index
    get "/people/new/", PersonController, :new
    get "/people/:id/edit/", PersonController, :edit
    get "/people/:id/", PersonController, :show
    post "/people/", PersonController, :create
    delete "/people/:id/", PersonController, :delete
    put "/people/:id", PersonController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", EctoPeopleWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ecto_people, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EctoPeopleWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
