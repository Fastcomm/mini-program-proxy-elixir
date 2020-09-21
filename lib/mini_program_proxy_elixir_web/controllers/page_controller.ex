defmodule MiniProgramProxyElixirWeb.PageController do
  use MiniProgramProxyElixirWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
