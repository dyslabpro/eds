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
        |> redirect(to: admin_course_path(conn, :show, conn.params["course_id"]))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
