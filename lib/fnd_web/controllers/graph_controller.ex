defmodule FndWeb.GraphController do
  use FndWeb, :controller

  require Logger

  def index(conn, %{"user" => user}) do
    Logger.info("user with wallet address #{user}")
    json(conn, Fnd.most_recent())
  end
end
