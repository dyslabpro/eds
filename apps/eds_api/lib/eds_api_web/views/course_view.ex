defmodule EdsApiWeb.CourseView do
  use EdsApiWeb, :view

  def render("index.json", %{courses: courses}) do
    %{data: render_many(courses, EdsApiWeb.CourseView, "course.json")}
  end

  def render("course.json", %{course: course}) do
    %{id: course.id, title: course.title, test: "sdf"}
  end

  def render("show.json", %{course: course}) do
    %{data: render_one(course, EdsApiWeb.CourseView, "course.json")}
  end
end
