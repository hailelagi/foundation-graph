defmodule Fnd.Graph do
  @moduledoc """
    Pubic interface for querying The foundation mainnet graph
  """

  def query_nfts(count), do: client().query_nfts(count)

  defp client, do: Application.get_env(:fnd, :client_api)
end
