defmodule Eds.Factory do
  use ExMachina.Ecto, repo: Eds.Repo

  def category_factory do
    %Eds.Core.Category{
      title: Faker.Industry.En.industry
    }
  end

  def course_factory do
    %Eds.Core.Course{
      description: Faker.Lorem.paragraph(1..2),
      subtitle: Faker.Lorem.sentence(1..2),
      title: Faker.Lorem.sentence(1..2),
      chapters: build_list(Enum.random(3..7), :chapter),
      nodes: build_list(Enum.random(1..2), :node)
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

  def user_course_factory do
    courses = Eds.Repo.all(Eds.Core.Course)
    course = Enum.random(courses)
    users = Eds.Repo.all(Eds.Accounts.User)
    user = Enum.random(users)

    %Eds.Accounts.UserCourse{
      user_id: user.id,
      course_id: course.id,
      role: Enum.random(1..3)
    }
  end

  def chapter_factory do
    %Eds.Core.Chapter{
      title: Faker.Lorem.sentence(1..2),
      sections: build_list(Enum.random(3..7), :section),
      nodes: build_list(Enum.random(1..2), :node)
    }
  end

  def section_factory do
    %Eds.Core.Section{
      title: Faker.Lorem.sentence(1..2),
      nodes: build_list(Enum.random(1..2), :node)
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
      title: Faker.Lorem.sentence(1..2),
      text: Faker.Lorem.paragraph(1..2),
      texts: build_list(Enum.random(1..3), :text)
    }
  end

  def text_factory do
    %Eds.Content.Text{
      title: Faker.Lorem.sentence(1..2),
      text: Faker.Lorem.paragraph(2..5),
    }
  end
end
