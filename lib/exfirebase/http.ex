defmodule ExFirebase.HTTP do
  @moduledoc """
  Wrapper module for handling the HTTP communication with the server.
  """

  @doc "Sends HTTP/get request"
  def get(url, query) do
    send_to_server(url <> "&#{build_query(query)}", &HTTPotion.get/1)
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

  def build_query(query) do
    URI.encode_query(query)
  end
  defp send_to_server(url, method, data \\ nil) do
    HTTPotion.start

    IO.inspect(url)

    response =
      if data == nil do
        method.(url)
      else
        method.(url, [body: data])
      end

    response.body
  end
end
