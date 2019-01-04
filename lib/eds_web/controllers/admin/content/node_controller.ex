defmodule EdsWeb.Admin.NodeController do
  use EdsWeb, :controller

  alias Eds.Content.{Node}

  def new(conn, params) do
    changeset = Node.changeset(%Node{}, %{})
    render(conn, "new.html", changeset: changeset, course_id: params["course_id"])
  end

  def create(conn, %{"node" => node_params}) do
    node_params = Map.put_new(node_params, "course_id", conn.params["course_id"])

    case Node.create(node_params) do
      {:ok, node} ->
        conn
        |> put_flash(:info, "Node created successfully.")
        |> redirect(to: admin_course_path(conn, :show, node.course_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    node = Node.get!(id)
    changeset = Node.change(node)

    render(
      conn,
      "edit.html",
      course_id: node.course_id,
      node: node,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "node" => node_params}) do
    node = Node.get!(id)

    case Node.update(node, node_params) do
      {:ok, node} ->
        conn
        |> put_flash(:info, "Node updated successfully.")
        |> redirect(to: admin_course_path(conn, :show, node.course_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", node: node, changeset: changeset)
    end
  end
end
