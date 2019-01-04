defmodule Eds.Core do
  import Ecto.Query, warn: false
  alias Eds.Repo

  alias Eds.Core.Course

  def list_courses do
    Repo.all(Course)
  end


  def get_course!(id), do: Repo.get!(Course, id)

  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end


  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end


  def change_course(%Course{} = course) do
    Course.changeset(course, %{})
  end

  alias Eds.Core.Chapter

  def list_chapters do
    Repo.all(Chapter)
  end


  def get_chapter!(id), do: Repo.get!(Chapter, id)


  def create_chapter(attrs \\ %{}) do
    %Chapter{}
    |> Chapter.changeset(attrs)
    |> Repo.insert()
  end

  def update_chapter(%Chapter{} = chapter, attrs) do
    chapter
    |> Chapter.changeset(attrs)
    |> Repo.update()
  end

  def delete_chapter(%Chapter{} = chapter) do
    Repo.delete(chapter)
  end

  def change_chapter(%Chapter{} = chapter) do
    Chapter.changeset(chapter, %{})
  end

  alias Eds.Core.Section

  def list_sections do
    Repo.all(Section)
  end

  def get_section!(id), do: Repo.get!(Section, id)


  def create_section(attrs \\ %{}) do
    %Section{}
    |> Section.changeset(attrs)
    |> Repo.insert()
  end

  def update_section(%Section{} = section, attrs) do
    section
    |> Section.changeset(attrs)
    |> Repo.update()
  end

  def delete_section(%Section{} = section) do
    Repo.delete(section)
  end

  def change_section(%Section{} = section) do
    Section.changeset(section, %{})
  end
end
