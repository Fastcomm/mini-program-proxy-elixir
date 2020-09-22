defmodule MiniProgramProxyElixirWeb.ProxyController do
  use MiniProgramProxyElixirWeb, :controller
  require Logger

  alias MiniProgramProxyElixir.Helpers.Connection

  def delete(conn, params) do
    request_headers = get_headers(conn)
    {_, request_params} = get_params(conn)
    path = get_path(conn)
    request = case Connection.delete(path, request_params, request_headers) do
      {:ok, resp} ->
        resp
      {:error, err} ->
        nil
    end

    response_headers = get_response_headers(request.headers)

    conn = Map.put(conn, :resp_body, request.body)
    |> Map.put(:resp_headers, response_headers)
    |> Map.put(:status, request.status_code)
    |> json(request.body)
  end

  def get(conn, params) do
    request_headers = get_headers(conn)
    {_, request_params} = get_params(conn)
    path = get_path(conn)
    request = case Connection.get(path, request_params, request_headers) do
      {:ok, resp} ->
        resp
      {:error, err} ->
        nil
    end

    response_headers = get_response_headers(request.headers)

    conn = Map.put(conn, :resp_body, request.body)
    |> Map.put(:resp_headers, response_headers)
    |> Map.put(:status, request.status_code)
    |> json(request.body)
  end

  def put(conn, params) do
    request_headers = get_headers(conn)
    {_, request_body} = get_params(conn)
    path = get_path(conn)
    request = case Connection.put(path, request_body, request_headers) do
      {:ok, resp} ->
        resp
      {:error, _err} ->
        nil
    end

    response_headers = get_response_headers(request.headers)

    conn = Map.put(conn, :resp_body, request.body)
    |> Map.put(:resp_headers, response_headers)
    |> Map.put(:status, request.status_code)
    |> json(request.body)
  end

  def post(conn, params) do
    request_headers = get_headers(conn)
    {_, request_body} = get_params(conn)
    path = get_path(conn)
    request = case Connection.post(path, request_body, request_headers) do
      {:ok, resp} ->
        resp
      {:error, err} ->
        nil
    end

    response_headers = get_response_headers(request.headers)

    conn = Map.put(conn, :resp_body, request.body)
    |> Map.put(:resp_headers, response_headers)
    |> Map.put(:status, request.status_code)
    |> json(request.body)
  end

  def get_headers(conn) do
    conn.req_headers
    |> Enum.reject(fn {key, _value} -> key == "host" end)
  end

  def get_params(conn) do
    conn.params
    |> Map.pop("proxy_path")
  end

  def get_path(conn) do
    conn.params["proxy_path"]
    |> Enum.join("/")
  end

  def get_response_headers(headers) do
    headers
    |> Enum.reject(fn {key, _value} -> key == "Status" || key == "X-Cascade" || key == "X-Runtime" || key == "Transfer-Encoding" end)
  end

end
