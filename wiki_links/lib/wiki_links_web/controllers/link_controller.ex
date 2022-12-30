defmodule WikiLinksWeb.LinkController do
  use WikiLinksWeb, :controller
  alias WikiLinks.GeneratePdf.Pdf
  alias WikiLinks.Wiki_link
  alias WikiLinks.Wiki_link.Link

  @doc """
  filter the links when searched by Link Tag only
  """
  def index(conn, %{"query_tag" => query_tag,"query" => query}) when query_tag != ""  and query == "" do
    links= Wiki_link.list_tag(query_tag)
    render(conn, "index.html", links: links)
end
 @doc """
  filter the links when searched by Link  only
  """
def index(conn, %{"query_tag" => query_tag,"query" => query}) when query_tag == ""  and query != "" do
  links= Wiki_link.list_links(query)
  render(conn, "index.html", links: links)
end

 @doc """
  filter the links when searched by Link  and  Link Tag both
  """
def index(conn, %{"query_tag" => query_tag, "query" => query}) when query_tag != "" and query != "" do
  links= Wiki_link.link_tag(query_tag,query)
  render(conn, "index.html", links: links)
end
 @doc """
 show all saved Links
  """
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

  def deletelink(conn, %{"id" => id}) do
    link = Wiki_link.get_link!(id)
    {:ok, _link} = Wiki_link.delete_link(link)

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: Routes.link_path(conn, :index))
  end


 @doc """
  mark  or unmark the link favourate
  """
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

 @doc """
  generate the pdf for links through GenServer
  """
  def link_pdf(conn, _params) do
    links = Wiki_link.show_links()
    html = Phoenix.View.render_to_string(WikiLinksWeb.FavLinkView,"pdf.html", links: links)
    case PdfGenerator.generate(html, page_size: "A4", shell_params: ["--dpi", "300"]) do
          {:ok, filename} ->
            IO.inspect(filename)
            :ok = File.rename(filename, Path.expand("~/Downloads/Link_list.pdf"))
            conn
            |> put_flash(:info, "PDF Saved")
            |> redirect(to: Routes.link_path(conn, :index))
            {:error, _changeset} ->
                    conn
                 |> put_flash(:error, "PDF Failed")
                 |> redirect(to: Routes.link_path(conn, :index))
            end
  end
end
