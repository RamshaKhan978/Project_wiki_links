defmodule WikiLinks.Wiki_linkTest do
  use WikiLinks.DataCase

  alias WikiLinks.Wiki_link

  describe "links" do
    alias WikiLinks.Wiki_link.Link

    import WikiLinks.Wiki_linkFixtures

    @invalid_attrs %{description: nil, fav: nil, link: nil, tag: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Wiki_link.show_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Wiki_link.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{description: "some description", fav: true, link: "some link", tag: "some tag"}

      assert {:ok, %Link{} = link} = Wiki_link.create_link(valid_attrs)
      assert link.description == "some description"
      assert link.fav == true
      assert link.link == "some link"
      assert link.tag == "some tag"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wiki_link.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{description: "some updated description", fav: false, link: "some updated link", tag: "some updated tag"}

      assert {:ok, %Link{} = link} = Wiki_link.update_link(link, update_attrs)
      assert link.description == "some updated description"
      assert link.fav == false
      assert link.link == "some updated link"
      assert link.tag == "some updated tag"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Wiki_link.update_link(link, @invalid_attrs)
      assert link == Wiki_link.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Wiki_link.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Wiki_link.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Wiki_link.change_link(link)
    end
  end
end
