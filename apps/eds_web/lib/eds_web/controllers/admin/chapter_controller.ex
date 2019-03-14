defmodule EdsWeb.Admin.ChapterController do
  use EdsWeb, :controller

  alias Eds.{Repo}
  alias Eds.Core.{Chapter, Course}

  def new(conn, params) do
    changeset = Chapter.change_chapter(%Chapter{})
    render(conn, "new.html", changeset: changeset, course_id: params["course_id"])
  end

  def create(conn, %{"chapter" => chapter_params}) do
    chapter_params = Map.put_new(chapter_params, "course_id", conn.params["course_id"])

    case Chapter.create_chapter(chapter_params) do
      {:ok, chapter} ->
        conn
        |> put_flash(:info, "Chapter created successfully.")
        |> redirect(to: Routes.admin_course_path(conn, :show, chapter.course_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chapter =
    Chapter.get_chapter!(id)
      |> Chapter.get_sections()
      |> Chapter.preload_nodes()

    course =
    Course.get_course!(chapter.course_id)
      |> Course.preload_chapters_sections()

    current_link = %{
      "course" => course.id,
      "chapter" => chapter.id,
      "section" => nil
    }

    render(conn, "show.html", chapter: chapter, course: course, current_link: current_link)
  end

  def edit(conn, %{"id" => id}) do
    chapter = Chapter.get_chapter!(id)
    changeset = Chapter.change_chapter(chapter)

    render(
      conn,
      "edit.html",
      course_id: chapter.course_id,
      chapter: chapter,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "chapter" => chapter_params}) do
    chapter = Chapter.get_chapter!(id)

    case Chapter.update_chapter(chapter, chapter_params) do
      {:ok, chapter} ->
        conn
        |> put_flash(:info, "Chapter updated successfully.")
        |> redirect(to: Routes.admin_course_path(conn, :show, chapter.course_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", chapter: chapter, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chapter = Chapter.get_chapter!(id)
    {:ok, _chapter} = Chapter.delete_chapter(chapter)

    conn
    |> put_flash(:info, "Chapter deleted successfully.")
    |> redirect(to: Routes.admin_course_path(conn, chapter.course_id(:show)))
  end
end
