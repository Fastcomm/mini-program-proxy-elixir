defmodule MiniProgramProxyElixirWeb.Router do
  use MiniProgramProxyElixirWeb, :router

  pipeline :api do
    # plug :accepts, ["json"]
  end

  scope "/", MiniProgramProxyElixirWeb do
    pipe_through :api

    get "/delete/*proxy_path", ProxyController, :delete
    get "/*proxy_path", ProxyController, :get

    post "/put/*proxy_path", ProxyController, :put
    post "/*proxy_path", ProxyController, :post
  end

  # Other scopes may use custom stacks.
  # scope "/api", MiniProgramProxyElixirWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      live_dashboard "/dashboard", metrics: MiniProgramProxyElixirWeb.Telemetry
    end
  end
end
