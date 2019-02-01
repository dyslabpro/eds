defmodule EdsWeb.Admin.CourseController do
  use EdsWeb, :controller

  alias Eds.Core.{Course, Category}

  def index(conn, _params) do
    courses = Eds.Helpers.AdminHelpers.get_user_courses(conn)
    render(conn, "index.html", courses: courses)
  end

  def new(conn, _params) do
    changeset = Course.change_course(%Course{})
    categories = Eds.Repo.all(Category)
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

    case Course.create_course(course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, "Course created successfully.")
        |> redirect(to: Routes.admin_course_path(conn, :show, course))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    course =
    Course.get_course!(id)
      |> Course.preload_chapters_sections()
      |> Course.preload_nodes()

      current_link = %{
        course: course.id,
        chapter: nil,
        section: nil
      }

    render(conn, "show.html", course: course, current_link: current_link)
  end

  def edit(conn, %{"id" => id}) do
    course = Course.get_course!(id)
    changeset = Course.change_course(course)
    render(conn, "edit.html", course: course, changeset: changeset)
  end

  def update(conn, %{"id" => id, "course" => course_params}) do
    course = Course.get_course!(id)

    case Course.update_course(course, course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, "Course updated successfully.")
        |> redirect(to: Routes.admin_course_path(conn, :show, course))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", course: course, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    course = Course.get_course!(id)
    {:ok, _course} = Course.delete_course(course)

    conn
    |> put_flash(:info, "Course deleted successfully.")
    |> redirect(to: Routes.course_path(conn, :index))
  end
end
