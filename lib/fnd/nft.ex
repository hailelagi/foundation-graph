defmodule Fnd.Nft do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @derive {Jason.Encoder, only: [:name, :description, :content_url, :create_date]}

  schema "nfts" do
    field :name, :string
    field :description, :string
    field :content_url, :string
    field :create_date, :date
    field :graph_id, :string
    field :ipfs, :string

    timestamps()
  end

  @doc false
  def changeset(nft, attrs) do
    nft
    |> cast(attrs, [:name, :description, :content_url, :graph_id, :ipfs, :create_date])
    |> validate_required([:graph_id, :ipfs, :create_date])
  end
end
