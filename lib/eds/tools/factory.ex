defmodule Eds.Factory do
  use ExMachina.Ecto, repo: Eds.Repo

  def category_factory do
    %Eds.Core.Category{
      title: sequence(:title, &"Category #{&1}")
    }
  end

  def course_factory do
    %Eds.Core.Course{
      description: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
      subtitle: sequence(:subtitle, &"subtitle #{&1}"),
      title: sequence(:title, &"Course #{&1}"),
      chapters: build_list(Enum.random(3..7), :chapter)
    }
  end

  def course_categories_factory do
    categories = Eds.Repo.all(Eds.Core.Category)
    category = Enum.random(categories)
    courses = Eds.Repo.all(Eds.Core.Course)
    course = Enum.random(courses)

    %Eds.Core.CourseCategory{
      category_id: category.id,
      course_id: course.id
    }
  end

  def chapter_factory do
    %Eds.Core.Chapter{
      title: sequence(:title, &"Chapter #{&1}"),
      sections: build_list(Enum.random(3..7), :section)
    }
  end

  def section_factory do
    %Eds.Core.Section{
      title: sequence(:title, &"Section #{&1}")
    }
  end

  def admin_factory do
    %Eds.Accounts.User{
      name: sequence(:name, &"Username #{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      handle: "dyslabpro3",
      admin: true
    }
  end

  def student_factory do
    %Eds.Accounts.User{
      name: sequence(:name, &"Username #{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      handle: "dyslabpro3",
      admin: false,
      student: true
    }
  end

  def node_factory do
    %Eds.Content.Node{
      title: sequence(:title, &"Title #{&1}"),

    }
  end
end
