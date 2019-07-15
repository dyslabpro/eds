defmodule EdsWeb.Admin.ImageController do
  use EdsWeb, :controller


  alias Eds.Content.{Node, Image}

  def new(conn, params) do
    changeset = Image.changeset(%Image{}, %{})

    render(
      conn,
      "new.html",
      changeset: changeset,
      course_id: params["course_id"],
      node_id: params["node_id"]
    )
  end

  def create(conn, %{"image" => image_params}) do
    image_params = Map.put_new(image_params, "node_id", conn.params["node_id"])

    case Image.create(image_params) do
      {:ok, image} ->
        image = Image.image_changeset(image, image_params) |> Repo.update
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: NavigationHistory.last_path(conn, 1))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    image = Image.get!(id)
    node = Node.get!(image.node_id)
    changeset = Image.changeset(image, %{})

    render(
      conn,
      "edit.html",
      node_id: node.id,
      image: image,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Image.get!(id)

    case Image.update(image, image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Text updated successfully.")
        |> redirect(to: NavigationHistory.last_path(conn, 1))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", image: image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Image.get!(id)
    {:ok, _image} = Image.delete(image)
    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: NavigationHistory.last_path(conn, 2))
  end

end
