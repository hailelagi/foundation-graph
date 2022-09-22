# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fnd.Repo.insert!(%Fnd.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Fnd.Nft

{:ok, nfts} = Fnd.Graph.ClientMock.query_nfts(nil)

Enum.map(nfts, fn nft ->
  date = String.to_integer(nft["dateMinted"]) |> DateTime.from_unix!()

  Nft.changeset(
    %Nft{},
    %{
      graph_id: nft["id"],
      ipfs: nft["tokenIPFSPath"],
      create_date: date
    }
  )
end)
|> Enum.reduce(fn n, _acc -> Fnd.Repo.insert!(n) end)
