# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Eds.Repo.insert!(%Eds.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.Query
import Eds.Factory
require Logger
require IEx

alias Eds.Repo
alias Eds.Core.{Course, Chapter, Section, Category}
alias Eds.Accounts.{User, UserCourse}

Eds.Repo.delete_all(Eds.Core.CourseCategory)

Eds.Repo.delete_all(Eds.Core.Category)
Eds.Repo.delete_all(Eds.Core.Section)
Eds.Repo.delete_all(Eds.Core.Chapter)


Eds.Repo.delete_all(Eds.Accounts.UserCourse)
Eds.Repo.delete_all(Eds.Accounts.User)
Eds.Repo.delete_all(Eds.Core.Course)


# Users
admin = Repo.insert! %User{
  name: "Admin Adminovish",
  email: "admin@example.com",
  handle: "dyslabpro",
  admin: true
}

admin2 = Repo.insert! %User{
  name: "Admin2 Adminovish2",
  email: "admin2@example.com",
  handle: "dyslabpro2",
  admin: true
}

admin3 = Repo.insert! %User{
  name: "Admin3 Adminovish3",
  email: "admin3@example.com",
  handle: "dyslabpro3",
  admin: true
}

admins = [admin, admin2, admin3]
categories = insert_list(12, :category)
courses = insert_list(100, :course)
admins = insert_list(15, :admin)
students = insert_list(15, :student)
course_categories = insert_list(200, :course_categories)



