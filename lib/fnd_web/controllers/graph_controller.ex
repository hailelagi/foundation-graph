defmodule FndWeb.GraphController do
  use FndWeb, :controller


  def index(conn, _params) do

    json(conn, Fnd.most_recent())
  end
end
