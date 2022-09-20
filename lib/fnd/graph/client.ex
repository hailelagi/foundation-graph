defmodule Fnd.Graph.Client do
  @moduledoc """
    GraphQL client querying theGraph api
  """
  alias Fnd.Graph.ParseError
  require Logger

  def query_nfts(count) do
    Logger.info("Live graph query")
    config()

    Neuron.query(
      """
      {
        nfts(first: $count) {
          id
          dateMinted
          tokenIPFSPath
        }
      }
      """,
      %{count: count}
    )
    |> parse_response()
    |> case do
      {:ok, data} -> {:ok, data["nfts"]}
      err -> err
    end
  end

  def parse_response(response) do
    case response do
      {:ok, %Neuron.Response{status_code: 200, body: %{"data" => body}}} -> {:ok, body}
      error -> ParseError.call(error)
    end
  end

  defp config do
    base_url = Application.get_env(:fnd, :graphql_endpoint)
    sub_graph_id = Application.get_env(:fnd, :sub_graph)
    api_key = Application.get_env(:fnd, :key)
    resource = base_url <> api_key <> "/subgraphs/id/" <> sub_graph_id

    Neuron.Config.set(url: resource)
  end
end
