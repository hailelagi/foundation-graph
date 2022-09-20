defmodule Fnd.Cache do
  @moduledoc """
    Cache and Periodically query the graph api
  """
  use GenServer
  alias Fnd.Graph

  def init(_), do: {:ok, nil}

  def start_link, do: nil

  def warm, do: GenServer.call(__MODULE__, :list_nifts)

  def handle_call(:list_nfts) do
    # todo: exists in cache and in update window?
      case Graph.query_nfts(20) do
      {:ok, nfts} ->
        # todo: write to database
        # todo: cache and return in intervals
    end
  end
end
