defmodule EdsWeb.Admin.ChapterController do
  use EdsWeb, :controller

  alias Eds.{Core, Repo}
  alias Eds.Core.{Chapter, Course}

  def index(conn, _params) do
    chapters = Core.list_chapters()
    courses = Repo.all(Course) |> Repo.preload(chapters: :sections)
    render(conn, "index.html", chapters: chapters, courses: courses)
  end

  def new(conn, params) do
    changeset = Core.change_chapter(%Chapter{})
    render(conn, "new.html", changeset: changeset, course_id: params["course_id"])
  end

  def create(conn, %{"chapter" => chapter_params}) do
    chapter_params = Map.put_new(chapter_params, "course_id", conn.params["course_id"])

    case Core.create_chapter(chapter_params) do
      {:ok, chapter} ->
        conn
        |> put_flash(:info, "Chapter created successfully.")
        |> redirect(to: admin_course_path(conn, :show, chapter.course_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chapter = Core.get_chapter!(id) |> Chapter.get_sections()
    sections = chapter.sections
    render(conn, "show.html", chapter: chapter, sections: sections)
  end

  def edit(conn, %{"id" => id}) do
    chapter = Core.get_chapter!(id)
    changeset = Core.change_chapter(chapter)

    render(
      conn,
      "edit.html",
      course_id: chapter.course_id,
      chapter: chapter,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "chapter" => chapter_params}) do
    chapter = Core.get_chapter!(id)

    case Core.update_chapter(chapter, chapter_params) do
      {:ok, chapter} ->
        conn
        |> put_flash(:info, "Chapter updated successfully.")
        |> redirect(to: admin_course_path(conn, :show, chapter.course_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", chapter: chapter, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chapter = Core.get_chapter!(id)
    {:ok, _chapter} = Core.delete_chapter(chapter)

    conn
    |> put_flash(:info, "Chapter deleted successfully.")
    |> redirect(to: admin_course_path(conn, chapter.course_id(:show)))
  end
end
