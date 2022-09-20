defmodule Fnd.Cache do
  @moduledoc """
    Cache and Periodically query the graph api
  """
  use GenServer
  alias Fnd.Graph

  require Logger

  @impl true
  def init(_), do: {:ok, nil}

  def start_link(_), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def warm, do: GenServer.call(__MODULE__, :list_nifts)

  @impl true
  def handle_call(:list_nfts, _, _) do
    # todo: exists in cache and in update window?
    case Graph.query_nfts(20) do
      {:ok, nfts} ->
        # todo: write to database
        # todo: cache and return in intervals
        {:reply, :ok, nfts}
    end
  end
end
