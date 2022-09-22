defmodule Fnd.Cache do
  @moduledoc """
    Cache and Periodically query the graph api
  """
  use GenServer
  alias Fnd.{Nft, Repo, Graph}

  require Logger

  @impl true
  @spec init(any) :: {:ok, 1}
  def init(_) do
    Logger.info("theGraph cache started..")
    warm_cache(1)

    {:ok, 1}
  end

  def start_link(_), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  @impl true
  def handle_info(:warm, t) do
    Logger.info("cache is querying the graph time - #{t}")

    case Graph.query_nfts(20) do
      {:ok, nfts} ->
        Stream.map(nfts, fn nft ->
          date = String.to_integer(nft["dateMinted"])

          date =
            case DateTime.from_unix(date) do
              {:ok, date} -> date
              {:error, _} -> nil
            end

          Nft.changeset(%Nft{},
            %{
              graph_id: nft["id"],
              ipfs: nft["tokenIPFSPath"],
              create_date: date
            }
          )
        end)
        |> Enum.reduce(fn n, _acc ->
          case Repo.insert(n) do
            {:ok, _} ->
              n

            {:error, error} ->
              Logger.error("Cannot save nft due to #{inspect(error)}")
          end
        end)

        {:reply, :ok, nfts}
    end

    warm_cache(t ** 2)
    {:noreply, t + 1}
  end

  defp warm_cache(t) do
    # warm cache exponentally
    Process.send_after(self(), :warm, t * 60 * 1000)
  end
end
