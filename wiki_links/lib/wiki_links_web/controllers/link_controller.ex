defmodule WikiLinksWeb.LinkController do
  use WikiLinksWeb, :controller

  alias WikiLinks.Wiki_link
  alias WikiLinks.Wiki_link.Link

  def index(conn, _params) do
    links = Wiki_link.show_links()
    render(conn, "index.html", links: links)
    end


  def index(conn, params) do
    if params["query_tag"]== "" do
      links= Wiki_link.list_links(params)
       render(conn, "index.html", links: links)
    end
    if params["query"]== "" do
     links= Wiki_link.list_tag(params)
      render(conn, "index.html", links: links)
   end
   if params["query_tag"] && params["query"] != "" do
    links= Wiki_link.link_tag(params)
    render(conn, "index.html", links: links)
   end
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
end
