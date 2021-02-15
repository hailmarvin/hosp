defmodule HospWeb.PageController do
  use HospWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
