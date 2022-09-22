defmodule Fnd do
  @moduledoc """
    Foundation graph context.
  """

  alias Fnd.{Nft, Repo}
  import Ecto.Query

  def most_recent do
    query =
      from n in Nft,
      where: not (is_nil(n.name) and is_nil(n.description) and is_nil(n.content_url)),
        order_by: [desc: n.inserted_at],
        limit: 20

    Repo.all(query)
  end
end
