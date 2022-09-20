defmodule FndWeb.PageController do
  use FndWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
