defmodule WikiLinksWeb.ChatController do
  use WikiLinksWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end