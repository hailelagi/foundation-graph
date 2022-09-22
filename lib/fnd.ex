defmodule Fnd do
  @moduledoc """
  Fnd keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
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
