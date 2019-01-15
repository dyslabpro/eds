defmodule EdsWeb.Admin.SectionController do
  use EdsWeb, :controller

  alias Eds.{Core, Repo}
  alias Eds.Core.{Section, Course}

  def new(conn, params) do
    changeset = Core.change_section(%Section{})

    render(
      conn,
      "new.html",
      changeset: changeset,
      course_id: params["course_id"],
      chapter_id: params["chapter_id"]
    )
  end

  def create(conn, %{"section" => section_params}) do
    section_params = Map.put_new(section_params, "chapter_id", conn.params["chapter_id"])

    case Core.create_section(section_params) do
      {:ok, section} ->
        conn
        |> put_flash(:info, "Section created successfully.")
        |> redirect(
          to: admin_course_chapter_path(conn, :show, conn.params["course_id"], section.chapter_id)
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    section =
      Core.get_section!(id)
      |> Section.preload_nodes()
      |> Repo.preload(:chapter)

    course =
      Core.get_course!(section.chapter.course_id)
      |> Course.preload_chapters_sections()

    courses = Repo.all(Course) |> Repo.preload(chapters: :sections)

    current_link = %{
      "course" => course.id,
      "chapter" => section.chapter_id,
      "section" => section.id
    }

    render(conn, "show.html",
      section: section,
      courses: courses,
      course: course,
      current_link: current_link
    )
  end

  def edit(conn, %{"id" => id}) do
    section = Core.get_section!(id)
    chapter = Core.get_chapter!(section.chapter_id)
    changeset = Core.change_section(section)

    render(
      conn,
      "edit.html",
      course_id: chapter.course_id,
      chapter_id: section.chapter_id,
      section: section,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "section" => section_params}) do
    section = Core.get_section!(id)

    case Core.update_section(section, section_params) do
      {:ok, _section} ->
        conn
        |> put_flash(:info, "Section updated successfully.")
        |> redirect(to: admin_course_path(conn, :show, conn.params["course_id"]))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", section: section, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    section = Core.get_section!(id)
    {:ok, _section} = Core.delete_section(section)

    conn
    |> put_flash(:info, "Section deleted successfully.")

    # |> redirect(to: course_section_path(conn, :index))
  end
end
