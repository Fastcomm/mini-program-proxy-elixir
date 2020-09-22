defmodule MiniProgramProxyElixir.Helpers.Connection do

  def delete(path, params, headers) do
    base_url = get_base_url()
    url = "#{base_url}#{path}?#{URI.encode_query(params)}"

    case HTTPoison.delete(url, headers, get_http_options) do
      {:ok, response} ->
        IO.inspect(response)
        {:ok, response}
      {:error, error} ->
        IO.inspect(error)
        {:error, error}
    end

  end

  def get(path, params, headers) do
    base_url = get_base_url()
    url = "#{base_url}#{path}?#{URI.encode_query(params)}"

    case HTTPoison.get(url, headers, get_http_options) do
      {:ok, response} ->
        IO.inspect(response)
        {:ok, response}
      {:error, error} ->
        IO.inspect(error)
        {:error, error}
    end
  end

  def put(path, body, headers) do
    base_url = get_base_url()
    url = "#{base_url}#{path}"

    case HTTPoison.put(url, Jason.encode!(body), headers, get_http_options) do
      {:ok, response} ->
        IO.inspect(response)
        {:ok, response}
      {:error, error} ->
        IO.inspect(error)
        {:error, error}
    end
  end

  def post(path, body, headers) do
    base_url = get_base_url()
    url = "#{base_url}#{path}"

    case HTTPoison.post(url, Jason.encode!(body), headers, get_http_options) do
      {:ok, response} ->
        IO.inspect(response)
        {:ok, response}
      {:error, error} ->
        IO.inspect(error)
        {:error, error}
    end
  end

  def get_base_url do
    base_url = case System.fetch_env("PROXY_HOST") do
      {:ok, base_path} ->
        base_path
      {:error, _} ->
        "http://localhost/"
    end

    case String.ends_with?(base_url, "/") do
      true ->
        base_url
      false ->
        "#{base_url}/"
    end
  end

  def get_http_options do
    [{:follow_redirect, true}]
  end

end
