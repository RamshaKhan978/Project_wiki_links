defmodule WikiLinksWeb.FavLinkController do
  use WikiLinksWeb, :controller
  alias WikiLinks.Wiki_link


  def index(conn, _params) do
    links = Wiki_link.list_fav_links()
    render(conn, "index.html", links: links)
  end
end
