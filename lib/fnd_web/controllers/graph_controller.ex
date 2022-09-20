defmodule FndWeb.GraphController do
  use FndWeb, :controller

  def index(conn, _params) do
    nfts = case Fnd.Cache.warm() do
      {:ok, nil} -> nil
    end

    json(conn, nfts)
  end
end
