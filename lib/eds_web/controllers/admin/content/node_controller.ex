defmodule EdsWeb.Admin.NodeController do
  use EdsWeb, :controller

  alias Eds.Content.{Node}
  alias Eds.Core.{Section, Course, Chapter}

  def new(conn, params) do
    changeset = Node.changeset(%Node{}, %{})

    {node_params, path} =
      case params do
        %{"section_id" => s} ->
          {%{"section_id" => s}, Routes.admin_section_node_path(conn, :create, s)}

        %{"chapter_id" => ch} ->
          {%{"chapter_id" => ch}, Routes.admin_chapter_node_path(conn, :create, ch)}

        %{"course_id" => c} ->
          {%{"course_id" => c}, Routes.admin_course_node_path(conn, :create, c)}

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
        path =
          cond do
            Map.has_key?(conn.params, "section_id") ->
              section = Section.get_section_with_parent(conn.params["section_id"])

              Routes.admin_course_chapter_section_path(
                conn,
                :show,
                section.chapter.course_id,
                section.chapter.id,
                section.id
              )

            Map.has_key?(conn.params, "chapter_id") ->
              chapter = Chapter.get_chapter_with_parent(conn.params["chapter_id"])
              Routes.admin_course_chapter_path(conn, :show, chapter.course_id, chapter.id)

            Map.has_key?(conn.params, "course_id") ->
              Routes.admin_course_path(conn, :show, conn.params["course_id"])

            true ->
              "/admin"
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
        |> redirect(to: Routes.admin_course_path(conn, :show, node.course_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", node: node, changeset: changeset)
    end
  end
end
