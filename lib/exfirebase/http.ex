defmodule ExFirebase.HTTP do
  @moduledoc """
  Wrapper module for handling the HTTP communication with the server.
  """

  @doc "Sends HTTP/get request"
  def get(url, options) do
    send_to_server(url, &HTTPotion.get/2, nil, options)
  end

  def get(url) do
    send_to_server(url, &HTTPotion.get/1)
  end

  @doc "Sends HTTP/post request"
  def post(url, data) do
    send_to_server(url, &HTTPotion.post/2, data)
  end

  @doc "Sends HTTP/put request"
  def put(url, data) do
    send_to_server(url, &HTTPotion.put/2, data)
  end

  @doc "Sends HTTP/patch request"
  def patch(url, data) do
    send_to_server(url, &HTTPotion.patch/2, data)
  end

  @doc "Sends HTTP/delete request"
  def delete(url) do
    send_to_server(url, &HTTPotion.delete/1)
  end

  defp send_to_server(url, method, data \\ nil, options \\ nil) do
    HTTPotion.start

    response =
      if data == nil && options == nil do
        method.(url)
      else if options != nil do
        method.(url, [options: options])
      else
        method.(url, [body: data])
      end

    response.body
  end
end
