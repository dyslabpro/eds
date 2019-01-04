defmodule Eds.CoreTest do
  use Eds.DataCase

  alias Eds.Core

  describe "courses" do
    alias Eds.Core.Course

    @valid_attrs %{subtitle: "some subtitle", title: "some title"}
    @update_attrs %{subtitle: "some updated subtitle", title: "some updated title"}
    @invalid_attrs %{subtitle: nil, title: nil}

    def course_fixture(attrs \\ %{}) do
      {:ok, course} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_course()

      course
    end

    test "list_courses/0 returns all courses" do
      course = course_fixture()
      assert Core.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = course_fixture()
      assert Core.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      assert {:ok, %Course{} = course} = Core.create_course(@valid_attrs)
      assert course.subtitle == "some subtitle"
      assert course.title == "some title"
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()
      assert {:ok, course} = Core.update_course(course, @update_attrs)
      assert %Course{} = course
      assert course.subtitle == "some updated subtitle"
      assert course.title == "some updated title"
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = course_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_course(course, @invalid_attrs)
      assert course == Core.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = course_fixture()
      assert {:ok, %Course{}} = Core.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Core.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = course_fixture()
      assert %Ecto.Changeset{} = Core.change_course(course)
    end
  end

  describe "chapters" do
    alias Eds.Core.Chapter

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def chapter_fixture(attrs \\ %{}) do
      {:ok, chapter} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_chapter()

      chapter
    end

    test "list_chapters/0 returns all chapters" do
      chapter = chapter_fixture()
      assert Core.list_chapters() == [chapter]
    end

    test "get_chapter!/1 returns the chapter with given id" do
      chapter = chapter_fixture()
      assert Core.get_chapter!(chapter.id) == chapter
    end

    test "create_chapter/1 with valid data creates a chapter" do
      assert {:ok, %Chapter{} = chapter} = Core.create_chapter(@valid_attrs)
      assert chapter.title == "some title"
    end

    test "create_chapter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_chapter(@invalid_attrs)
    end

    test "update_chapter/2 with valid data updates the chapter" do
      chapter = chapter_fixture()
      assert {:ok, chapter} = Core.update_chapter(chapter, @update_attrs)
      assert %Chapter{} = chapter
      assert chapter.title == "some updated title"
    end

    test "update_chapter/2 with invalid data returns error changeset" do
      chapter = chapter_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_chapter(chapter, @invalid_attrs)
      assert chapter == Core.get_chapter!(chapter.id)
    end

    test "delete_chapter/1 deletes the chapter" do
      chapter = chapter_fixture()
      assert {:ok, %Chapter{}} = Core.delete_chapter(chapter)
      assert_raise Ecto.NoResultsError, fn -> Core.get_chapter!(chapter.id) end
    end

    test "change_chapter/1 returns a chapter changeset" do
      chapter = chapter_fixture()
      assert %Ecto.Changeset{} = Core.change_chapter(chapter)
    end
  end

  describe "sections" do
    alias Eds.Core.Section

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def section_fixture(attrs \\ %{}) do
      {:ok, section} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_section()

      section
    end

    test "list_sections/0 returns all sections" do
      section = section_fixture()
      assert Core.list_sections() == [section]
    end

    test "get_section!/1 returns the section with given id" do
      section = section_fixture()
      assert Core.get_section!(section.id) == section
    end

    test "create_section/1 with valid data creates a section" do
      assert {:ok, %Section{} = section} = Core.create_section(@valid_attrs)
      assert section.title == "some title"
    end

    test "create_section/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_section(@invalid_attrs)
    end

    test "update_section/2 with valid data updates the section" do
      section = section_fixture()
      assert {:ok, section} = Core.update_section(section, @update_attrs)
      assert %Section{} = section
      assert section.title == "some updated title"
    end

    test "update_section/2 with invalid data returns error changeset" do
      section = section_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_section(section, @invalid_attrs)
      assert section == Core.get_section!(section.id)
    end

    test "delete_section/1 deletes the section" do
      section = section_fixture()
      assert {:ok, %Section{}} = Core.delete_section(section)
      assert_raise Ecto.NoResultsError, fn -> Core.get_section!(section.id) end
    end

    test "change_section/1 returns a section changeset" do
      section = section_fixture()
      assert %Ecto.Changeset{} = Core.change_section(section)
    end
  end
end
