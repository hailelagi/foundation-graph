defmodule Fnd.Ipfs do
  @moduledoc """
    Resolve an IPFS.io hash
  """
  require Logger

  # def refresh(nfts) do
  #   Stream.map(nfts, fn nft -> resolve_ipfs(nft.) )
  # end

  def resolve(hash, long_poll \\ 5)

  def resolve(hash, long_poll) when long_poll > 0 do
    gateway = "https://ipfs.io/ipfs/" <> hash
    response = Finch.build(:get, gateway) |> Finch.request(FndFinch, receive_timeout: 20_000)

    with {:ok, %Finch.Response{status: 200, body: body}} <- response,
         {:ok, data} <- Jason.decode(body) do
      {:ok, data}
    else
      {:ok, %Finch.Response{status: status, body: body} = resp} ->
        Logger.error("ipfs hash could not resolve. status #{status} details: #{inspect(resp)}")
        {:error, body}

      {:error, %Mint.TransportError{reason: :timeout}} ->
        Logger.warn("ipfs hash could not be resolved in 20_000 ms, trying again")
        resolve(hash, long_poll - 1)

      {:error, error} ->
        Logger.error("ipfs hash could resolve #{inspect(error)}")
        {:error, "could not resolve ipfs hash, unknown error"}
    end
  end

  def resolve(_, _) do
    # schedule ipfs hash with oban
    {:error, :polling_limit}
  end
end
