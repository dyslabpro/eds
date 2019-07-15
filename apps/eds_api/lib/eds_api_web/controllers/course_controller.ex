defmodule EdsApiWeb.CourseController do
  use EdsApiWeb, :controller
  alias Eds.Core.Course


  def index(conn, _params) do
    courses = Course.list_courses()
    render(conn, "index.json", courses: courses)
  end

  def show(conn, %{"id" => id}) do
    course = Course.get_course!(id)
    render(conn, "show.json", course: course)
  end
end
