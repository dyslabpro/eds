defmodule EdsWeb.Admin.TextController do
  use EdsWeb, :controller


  alias Eds.Content.{Node, Text}

  def new(conn, params) do
    changeset = Text.changeset(%Text{}, %{})

    render(
      conn,
      "new.html",
      changeset: changeset,
      course_id: params["course_id"],
      node_id: params["node_id"]
    )
  end

  def create(conn, %{"text" => text_params}) do
    text_params = Map.put_new(text_params, "node_id", conn.params["node_id"])

    case Text.create(text_params) do
      {:ok, text} ->
        conn
        |> put_flash(:info, "Text created successfully.")
        |> redirect(to: NavigationHistory.last_path(conn, 1))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    text = Text.get!(id)
    node = Node.get!(text.node_id)
    changeset = Text.changeset(text, %{})

    render(
      conn,
      "edit.html",
      node_id: node.id,
      text: text,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "text" => text_params}) do
    text = Text.get!(id)

    case Text.update(text, text_params) do
      {:ok, chapter} ->
        conn
        |> put_flash(:info, "Text updated successfully.")
        |> redirect(to: NavigationHistory.last_path(conn, 1))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", text: text, changeset: changeset)
    end
  end

end
