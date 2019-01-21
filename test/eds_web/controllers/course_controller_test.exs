defmodule EdsWeb.CourseControllerTest do
  use EdsWeb.ConnCase

  alias Eds.Core.Course

  @create_attrs %{subtitle: "some subtitle", title: "some title"}
  @update_attrs %{subtitle: "some updated subtitle", title: "some updated title"}
  @invalid_attrs %{subtitle: nil, title: nil}

  def fixture(:course) do
    {:ok, course} = Course.create_course(@create_attrs)
    course
  end

  defp create_course(_) do
    course = fixture(:course)
    {:ok, course: course}
  end
end
