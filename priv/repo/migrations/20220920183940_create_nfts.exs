defmodule Fnd.Repo.Migrations.CreateNfts do
  use Ecto.Migration

  def change do
    create table(:nfts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :graph_id, :string
      add :ipfs, :string
      add :create_date, :date

      timestamps()
    end
  end
end
