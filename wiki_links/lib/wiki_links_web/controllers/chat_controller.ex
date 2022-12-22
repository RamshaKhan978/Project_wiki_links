defmodule WikiLinksWeb.ChatController do
  use WikiLinksWeb, :controller

  def chatbox(conn, _params) do
    render(conn, "index.html")
  end
end
