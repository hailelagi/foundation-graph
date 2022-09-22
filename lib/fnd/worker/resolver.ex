defmodule Fnd.Worker.Resolver do
  @moduledoc """
    Cache and Periodically query the graph api
  """
  use GenServer
  alias Fnd.{Nft, Repo, Ipfs}

  import Ecto.Query
  require Logger

  @impl true
  def init(_) do
    Logger.info("Ipfs resolver started..")
    schedule()
    {:ok, nil}
  end

  def start_link(_), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  @impl true
  def handle_info(:resolve, _) do
    case unresolved() do
      [] ->
        :ok

      nfts ->
        Logger.info("ipfs resolution started..")

        Stream.map(nfts, fn nft ->
          case Ipfs.resolve(nft.ipfs) do
            {:ok, data} ->
              Logger.info(data["description"])
              changeset =
                Nft.changeset(nft, %{
                  name: data["name"],
                  description: data["description"],
                  content_url: data["image"] || data["video"]
                })

              Repo.update!(changeset)
          end
        end)
        |> Enum.take(20)
    end

    {:noreply, :ok}
  end

  defp schedule, do: Process.send_after(self(), :resolve, 1000)

  def unresolved do
    query =
      from n in Nft,
        where: is_nil(n.name) or is_nil(n.description) or is_nil(n.content_url)

    Repo.all(query)
  end
end
