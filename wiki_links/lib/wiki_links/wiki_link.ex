defmodule WikiLinks.Wiki_link do
  @moduledoc """
  The Wiki_link context.
  """

  import Ecto.Query, warn: false
  alias WikiLinks.Repo
  alias WikiLinks.Wiki_link.Link


  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def show_links() do
    Repo.all(Link)
  end

  def list_links(query) do
    Link
    |> Link.search(query)
    |> Repo.all()
  end

  def list_tag(query_tag) do
    Link
    |> Link.search_tag(query_tag)
    |> Repo.all()
  end

  def link_tag(query_tag,query) do
    Link
    |> Link.search_link_tag(query_tag,query)
    |> Repo.all()
  end


  def list_fav_links do
    query = from(u in Link,
          where: u.fav == true)
    Repo.all(query)
  end


  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{data: %Link{}}

  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end

  def fav_update(id) do
    query =  from(p in Link, where: p.id == ^id, select: p)
  |> Repo.update_all(set: [fav: false])
  end

  def unfav_update(id) do
    query =  from(p in Link, where: p.id == ^id, select: p)
  |> Repo.update_all(set: [fav: true])
  end





end
