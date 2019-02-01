defmodule EdsWeb.CourseController do
  use EdsWeb, :controller

  alias Eds.Core
  alias Eds.Core.Course

  def index(conn, _params) do
    courses = Course.list_courses()
    render(conn, "index.html", courses: courses)
  end

  def show(conn, %{"id" => id}) do
    course =
    Course.get_course!(id)
      |> Course.preload_chapters_sections()
      |> Course.preload_nodes()
      |> Course.preload_categories()

    chapters = course.chapters

    render(
      conn,
      "show.html",
      course: course,
      chapters: chapters,
      layout: {EdsWeb.LayoutView, "app_single.html"}
    )
  end
end
