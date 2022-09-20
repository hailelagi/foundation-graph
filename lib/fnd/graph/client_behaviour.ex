defmodule Fnd.Graph.ClientBehaviour do
  @moduledoc """
  Define the behaviour that the Client interface uses. Keeps live and test API in sync.
  """

  @callback query_nfts(count :: integer()) :: {:ok, [map()]} | {:error, String.t()}
end
