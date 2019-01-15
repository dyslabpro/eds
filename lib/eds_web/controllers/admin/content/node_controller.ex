defmodule EdsWeb.Admin.NodeController do
  use EdsWeb, :controller

  alias Eds.Content.{Node}

  def new(conn, params) do
    changeset = Node.changeset(%Node{}, %{})

    {node_params, path} =
      case params do
        %{"course_id" => c, "chapter_id" => ch, "section_id" => s} ->
          {%{"course_id" => c, "chapter_id" => ch, "section_id" => s},
           admin_course_chapter_section_node_path(conn, :create, c, ch, s)}

        %{"chapter_id" => ch, "course_id" => c} ->
          {%{"course_id" => c, "chapter_id" => ch},
           admin_course_chapter_node_path(conn, :create, c, ch)}

        %{"course_id" => c} ->
          {%{"course_id" => c}, admin_course_node_path(conn, :create, c)}

        _ ->
          {%{}, nil}
      end

    render(conn, "new.html", changeset: changeset, node_params: node_params, path: path)
  end

  def create(conn, %{"node" => node_params}) do
    node_params =
      case Map.has_key?(conn.params, "section_id") do
        false -> node_params
        true -> Map.put_new(node_params, "section_id", conn.params["section_id"])
      end

    node_params =
      case Map.has_key?(conn.params, "chapter_id") do
        false -> node_params
        true -> Map.put_new(node_params, "chapter_id", conn.params["chapter_id"])
      end

    node_params =
      case Map.has_key?(conn.params, "course_id") do
        false -> node_params
        true -> Map.put_new(node_params, "course_id", conn.params["course_id"])
      end

    case Node.create(node_params) do
      {:ok, node} ->
        path = admin_course_path(conn, :show, node.course_id)

        if conn.params["section_id"] do
          path =
            admin_course_chapter_section_path(
              conn,
              :show,
              node.course_id,
              node.chapter_id,
              node.section_id
            )
        end

        if conn.params["chapter_id"] do
          path = admin_course_chapter_path(conn, :show, node.course_id, node.chapter_id)
        end

        conn
        |> put_flash(:info, "Node created successfully.")
        |> redirect(to: path)

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
