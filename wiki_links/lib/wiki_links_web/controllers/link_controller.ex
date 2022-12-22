defmodule WikiLinksWeb.LinkController do
  use WikiLinksWeb, :controller

  alias WikiLinks.Wiki_link
  alias WikiLinks.Wiki_link.Link

  def index(conn, %{"query_tag" => query_tag,"query" => query}) when query_tag != ""  and query == "" do
    links= Wiki_link.list_tag(query_tag)
    render(conn, "index.html", links: links)
end

def index(conn, %{"query_tag" => query_tag,"query" => query}) when query_tag == ""  and query != "" do
  links= Wiki_link.list_links(query)
  render(conn, "index.html", links: links)
end
def index(conn, %{"query_tag" => query_tag, "query" => query}) when query_tag != "" and query != "" do
  links= Wiki_link.link_tag(query_tag,query)
  render(conn, "index.html", links: links)
end

def index(conn, _params) do
  links = Wiki_link.show_links()
  render(conn, "index.html", links: links)
  end

  def new(conn, _params) do
    changeset = Wiki_link.change_link(%Link{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    case Wiki_link.create_link(link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: Routes.link_path(conn, :show, link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Wiki_link.get_link!(id)
    render(conn, "show.html", link: link)
  end

  def edit(conn, %{"id" => id}) do
    link = Wiki_link.get_link!(id)
    changeset = Wiki_link.change_link(link)
    render(conn, "edit.html", link: link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Wiki_link.get_link!(id)

    case Wiki_link.update_link(link, link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link updated successfully.")
        |> redirect(to: Routes.link_path(conn, :show, link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", link: link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Wiki_link.get_link!(id)
    {:ok, _link} = Wiki_link.delete_link(link)

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: Routes.link_path(conn, :index))
  end



  def updatefav(conn, %{"id" => id}) do
    link = Wiki_link.get_link!(id)
    fav_link = link.fav
    if link.fav == true do
      Wiki_link.fav_update(id)
      conn
    |> put_flash(:info, " UnMarked faviourate ")
    |> redirect(to: Routes.link_path(conn, :index))
    else
      Wiki_link.unfav_update(id)
    end
    conn
    |> put_flash(:info, "Marked faviourate")
    |> redirect(to: Routes.link_path(conn, :index))

  end
end
