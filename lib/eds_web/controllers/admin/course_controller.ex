defmodule EdsWeb.Admin.CourseController do
  use EdsWeb, :controller

  alias Eds.{Core, Repo}
  alias Eds.Core.Course

  def index(conn, _params) do
    courses = Eds.Helpers.AdminHelpers.get_user_courses(conn)
    render(conn, "index.html", courses: courses)
  end

  def new(conn, _params) do
    changeset = Core.change_course(%Course{})
    categories = Eds.Repo.all(Eds.Core.Category)
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"course" => course_params}) do
    user = conn.assigns[:current_user]

    user_courses = [
      %{
        role: 1,
        user_id: user.id
      }
    ]

    course_params = Map.put_new(course_params, "user_courses", user_courses)

    case Core.create_course(course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, "Course created successfully.")
        |> redirect(to: admin_course_path(conn, :show, course))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    course =
      Core.get_course!(id)
      |> Course.preload_chapters_sections()
      |> Course.preload_nodes()

    courses =
      Repo.all(Course)
      |> Repo.preload(chapters: :sections)

    render(conn, "show.html", course: course, courses: courses)
  end

  def edit(conn, %{"id" => id}) do
    course = Core.get_course!(id)
    changeset = Core.change_course(course)
    render(conn, "edit.html", course: course, changeset: changeset)
  end

  def update(conn, %{"id" => id, "course" => course_params}) do
    course = Core.get_course!(id)

    case Core.update_course(course, course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, "Course updated successfully.")
        |> redirect(to: admin_course_path(conn, :show, course))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", course: course, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    course = Core.get_course!(id)
    {:ok, _course} = Core.delete_course(course)

    conn
    |> put_flash(:info, "Course deleted successfully.")
    |> redirect(to: course_path(conn, :index))
  end
end
